package com.Grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "modules")
public class ModuleEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer moduleId;

	@Column(nullable = false)
	private String moduleName;

	private String description;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	private ProjectEntity project;

	@OneToMany(mappedBy = "module", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private java.util.List<TaskEntity> tasks;

	private Integer estimatedHours;

	public java.util.List<TaskEntity> getTasks() {
		return tasks;
	}

	public void setTasks(java.util.List<TaskEntity> tasks) {
		this.tasks = tasks;
	}

	public Integer getModuleId() {
		return moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public ProjectEntity getProject() {
		return project;
	}

	public void setProject(ProjectEntity project) {
		this.project = project;
	}

	public Integer getEstimatedHours() {
		return estimatedHours;
	}

	public void setEstimatedHours(Integer estimatedHours) {
		this.estimatedHours = estimatedHours;
	}

	public Integer getTotalTaskHours() {
		if (tasks == null || tasks.isEmpty()) {
			return 0;
		}
		return tasks.stream()
				.filter(t -> t.getEstimatedHours() != null)
				.mapToInt(TaskEntity::getEstimatedHours)
				.sum();
	}
}
