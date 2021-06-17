package com.bit.coin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.bit.coin.model.CustomUserDetails;
import com.bit.coin.model.UserDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private UserService userService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDto user = userService.getUser(username);
		log.info("CustomUserDetailsService : " + username);
		log.info("CustomUserDetailsService : " + user);
		return user == null ? null : new CustomUserDetails(user);
	}

}
