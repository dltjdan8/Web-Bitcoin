package com.bit.coin.security;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.bit.coin.model.CustomUserDetails;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		CustomUserDetails userVO = (CustomUserDetails) authentication.getPrincipal();
		Collection<GrantedAuthority> authList = userVO.getAuthorities();
		Iterator<GrantedAuthority> authList_it = authList.iterator();
		String url = "/";
		while (authList_it.hasNext()) {
			GrantedAuthority auth = authList_it.next();
			if ("ROLE_ADMIN".equals(auth.getAuthority())) {
				url = "/";
			}
		}
		response.sendRedirect(url);
	}

}
