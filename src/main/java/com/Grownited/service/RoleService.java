package com.Grownited.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Grownited.entity.RoleEntity;
import com.Grownited.repository.RoleRepository;

@Service
public class RoleService {

    @Autowired
    private RoleRepository roleRepository;

    public List<RoleEntity> findAssignableRoles() {
        return roleRepository.findByRoleNameNot("ADMIN");
    }
}

