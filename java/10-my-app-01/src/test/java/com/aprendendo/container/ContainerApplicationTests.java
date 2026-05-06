package com.aprendendo.container;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;

@SpringBootTest
class ContainerApplicationTests {

  @Autowired
  private ApplicationContext applicationContext;

  @Test
  void applicationContextShouldLoadSuccessfully() {
    assertNotNull(applicationContext, "The application context should have loaded.");
  }

  @Test
  void shouldContainUserControllerBean() {
    assertTrue(applicationContext.containsBean("userController"),
        "The UserController bean should be present in the context.");
  }

}
