package com.Grownited.entity;

import jakarta.persistence.*;


@Entity
@Table(name = "modules" )
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
    
    
}
