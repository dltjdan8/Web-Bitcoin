package com.bit.coin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.bit.coin.service.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	private CustomUserDetailsService userService;

	// 패스워드 인코더 bean 등록
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// TODO Auto-generated method stub
		http.csrf().disable();
		// 접근허용
		http.authorizeRequests().antMatchers("/user/**").permitAll().anyRequest().permitAll().and()
		// iframe 허용
//				.headers().frameOptions().disable().and()
		// DB 어드민 접속 허용
//				.csrf().disable().and()
				// 로그인
				.formLogin().loginPage("/").loginProcessingUrl("/user/login").defaultSuccessUrl("/home")
				.failureUrl("/home").usernameParameter("id").passwordParameter("pwd").permitAll().and()
				// .exceptionHandling().accessDeniedHandler().and()
//				.rememberMe().key("jpub").rememberMeParameter("remember-me").rememberMeCookieName("jpubcookie").tokenValiditySeconds(60 * 60 * 24).tokenRepository(userService).userDetailService(userService).and()
				.logout().invalidateHttpSession(true).clearAuthentication(true)
				.logoutRequestMatcher(new AntPathRequestMatcher("/user/logout")).logoutSuccessUrl("/home").permitAll();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// TODO Auto-generated method stub
		auth.userDetailsService(userService).passwordEncoder(bCryptPasswordEncoder());
	}

}
