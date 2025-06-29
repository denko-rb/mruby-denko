set(MRUBY_DIR "${COMPONENT_DIR}/mruby")
set(LIBMRUBY_FILE "${COMPONENT_DIR}/mruby/build/esp32/lib/libmruby.a")
set(MRUBY_CONFIG ${COMPONENT_DIR}/esp32_build_config.rb)

idf_component_register(
  SRCS
    ${COMPONENT_DIR}/picoruby/mrbgems/picoruby-gpio/ports/esp32/gpio.c
    ${COMPONENT_DIR}/picoruby/mrbgems/picoruby-adc/ports/esp32/adc.c
    ${COMPONENT_DIR}/picoruby/mrbgems/picoruby-spi/ports/esp32/spi.c
    ${COMPONENT_DIR}/picoruby/mrbgems/picoruby-pwm/ports/esp32/pwm.c
    ${COMPONENT_DIR}/picoruby/mrbgems/picoruby-i2c/ports/esp32/i2c.c
  INCLUDE_DIRS
    ${COMPONENT_DIR}/include
    ${COMPONENT_DIR}/mruby/include
  REQUIRES
    esp_hw_support
    esp_rom
    esp_timer
    esp_wifi
    mqtt
    esp_driver_gpio
    esp_driver_ledc
    esp_adc
    esp_driver_i2c
    esp_driver_spi
)

add_definitions(
  -DPICORB_VM_MRUBY
  -DPICORUBY_PORT_ESP32
  -DMRBC_USE_FLOAT
)

add_custom_command(
  OUTPUT ${LIBMRUBY_FILE}
  COMMAND ${CMAKE_COMMAND} -E env "MRUBY_CONFIG=${MRUBY_CONFIG}" "CC=${CMAKE_C_COMPILER}" "LD=${CMAKE_LINKER}" "AR=${CMAKE_AR}" "COMPONENT_INCLUDES=$<TARGET_PROPERTY:${COMPONENT_TARGET},INTERFACE_INCLUDE_DIRECTORIES>" rake
  WORKING_DIRECTORY ${MRUBY_DIR}
  BYPRODUCTS ${COMPONENT_DIR}/esp32_build_config.rb.lock
  VERBATIM
)

set_property(DIRECTORY APPEND PROPERTY
  ADDITIONAL_CLEAN_FILES ${MRUBY_DIR}/build
)

add_prebuilt_library(
  libmruby ${LIBMRUBY_FILE}
  PRIV_REQUIRES
    esp_hw_support
    esp_rom
    esp_timer
    esp_wifi
    mqtt
    esp_driver_gpio
    esp_driver_ledc
    esp_adc
    esp_driver_i2c
    esp_driver_spi
)
target_link_libraries(libmruby INTERFACE ${COMPONENT_LIB})
target_link_libraries(${COMPONENT_LIB} INTERFACE libmruby)

add_custom_target(mruby DEPENDS ${LIBMRUBY_FILE})
add_dependencies(${COMPONENT_LIB} mruby)
