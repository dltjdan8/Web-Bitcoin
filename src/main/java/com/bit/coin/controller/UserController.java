package com.bit.coin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.coin.model.UserDto;
import com.bit.coin.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private PasswordEncoder encoder;

	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public void loginPage(String error, Model model) {
		if (error != null) {
			model.addAttribute("msg", error);
		}
	}

	@PostMapping("/regist")
	public ModelAndView regist(UserDto userDto) {
		userDto.setRpwd(encoder.encode(userDto.getRpwd()));
		int result = userService.regist(userDto);
		ModelAndView mav = new ModelAndView("home");
		if (result != 0) {
			mav.addObject("msg", "success");
		} else {
			mav.addObject("msg", "fail");
		}
		return mav;
	}

	@ResponseBody
	@PostMapping("/validate")
	public String validate(@RequestParam("id") String userId) {
		int result = userService.validate(userId);
		if (result == 1) {
			return "no";
		}
		return "ok";
	}

	@PutMapping("/modify")
	public ModelAndView modify() {
		int result = userService.login();
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("msg", result);
		return mav;
	}

	@DeleteMapping("/delete")
	public ModelAndView delete() {
		int result = userService.login();
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("msg", result);
		return mav;
	}

}
