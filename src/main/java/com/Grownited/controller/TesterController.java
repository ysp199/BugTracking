package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Grownited.entity.UserEntity;
import com.Grownited.entity.BugEntity;
import com.Grownited.entity.BugHistoryEntity;
import com.Grownited.entity.TaskEntity;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.repository.BugHistoryRepository;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.Cloudinary;
import java.io.IOException;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/tester")
public class TesterController {

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private BugHistoryRepository bugHistoryRepository;

    @Autowired
    private Cloudinary cloudinary;

    private UserEntity getLoggedInUser(HttpSession session) {
        return (UserEntity) session.getAttribute("loggedInUser");
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        long reportedBugs = bugRepository.findAll().stream()
                .filter(b -> b.getReportedBy() != null && b.getReportedBy().getUserId().equals(user.getUserId()))
                .count();

        model.addAttribute("reportedBugs", reportedBugs);
        return "tester/dashboard";
    }

    @GetMapping("/bugs")
    public String bugs(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<BugEntity> myBugs = bugRepository.findAll().stream()
                .filter(b -> b.getReportedBy() != null && b.getReportedBy().getUserId().equals(user.getUserId()))
                .collect(Collectors.toList());

        model.addAttribute("bugs", myBugs);
        return "tester/bugs";
    }

    @GetMapping("/test-bugs")
    public String testBugs(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        // Show bugs reported by this tester that are currently FIXED
        List<BugEntity> myTestBugs = bugRepository.findAll().stream()
                .filter(b -> b.getReportedBy() != null
                        && b.getReportedBy().getUserId().equals(user.getUserId())
                        && "FIXED".equals(b.getStatus()))
                .collect(Collectors.toList());

        model.addAttribute("bugs", myTestBugs);
        return "tester/test-bugs";
    }

    @GetMapping("/report-bug")
    public String showReportBugForm(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }

        List<TaskEntity> tasks = taskRepository.findAll();
        model.addAttribute("tasks", tasks);
        model.addAttribute("bug", new BugEntity());
        return "tester/report-bug";
    }

    @PostMapping("/report-bug")
    public String submitBugReport(@ModelAttribute BugEntity bug,
            @RequestParam(value = "taskId", required = false) Integer taskId,
            @RequestParam(value = "file", required = false) MultipartFile file,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        bug.setReportedBy(user);
        bug.setStatus("NEW");

        if (taskId != null) {
            TaskEntity task = taskRepository.findById(taskId).orElse(null);
            bug.setTask(task);
        }

        try {
            if (file != null && !file.isEmpty()) {
                @SuppressWarnings("rawtypes")
                Map map = cloudinary.uploader().upload(file.getBytes(), null);
                String attachmentUrl = map.get("secure_url").toString();
                bug.setAttachment(attachmentUrl);
            }
        } catch (IOException e) {
            e.printStackTrace();
            // We just ignore and print stack trace if it fails, or keep it optional
        }

        bugRepository.save(bug);

        return "redirect:/tester/bugs?success=Bug+Reported+Successfully";
    }

    @GetMapping("/bugs/{id}")
    public String viewBugDetail(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug == null) {
            return "redirect:/tester/bugs";
        }

        List<BugHistoryEntity> history = bugHistoryRepository.findByBug_BugId(id);

        model.addAttribute("bug", bug);
        model.addAttribute("history", history);
        return "tester/bug-detail";
    }

    @PostMapping("/bugs/{id}/status")
    public String updateBugStatus(@PathVariable Integer id,
            @RequestParam("status") String status,
            @RequestParam(value = "notes", required = false) String notes,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("TESTER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug != null) {
            String oldStatus = bug.getStatus();
            bug.setStatus(status);

            if ("REOPENED".equals(status)) {
                UserEntity dev = null;
                List<BugHistoryEntity> historyList = bugHistoryRepository.findByBug_BugId(id);
                // Search history for who set it to FIXED or IN_PROGRESS
                for (int i = historyList.size() - 1; i >= 0; i--) {
                    BugHistoryEntity h = historyList.get(i);
                    if ("FIXED".equals(h.getNewStatus()) || "IN_PROGRESS".equals(h.getNewStatus())) {
                        dev = h.getChangedBy();
                        break;
                    }
                }
                if (dev == null && bug.getTask() != null) {
                    dev = bug.getTask().getAssignedTo();
                }
                if (dev != null) {
                    bug.setAssignedTo(dev);
                }
            }

            bugRepository.save(bug);

            BugHistoryEntity history = new BugHistoryEntity();
            history.setBug(bug);
            history.setOldStatus(oldStatus);
            history.setNewStatus(status);
            history.setChangedBy(user);
            if (notes != null && !notes.trim().isEmpty()) {
                history.setNotes(notes.trim());
            }
            bugHistoryRepository.save(history);
        }

        return "redirect:/tester/bugs/" + id + "?success=Status+Updated";
    }
}
