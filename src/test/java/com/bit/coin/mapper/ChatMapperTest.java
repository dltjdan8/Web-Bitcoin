package com.bit.coin.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bit.coin.service.UserService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ChatMapperTest {
	@Autowired
	private ChatMapper chatMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserService service;
	@Test
	public void insert() {
		log.info(service);
	}

}
