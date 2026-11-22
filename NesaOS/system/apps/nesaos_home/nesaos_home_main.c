/****************************************************************************
 * NesaOS native home screen
 *
 * Copyright (C) 2026 NesaOS contributors
 * SPDX-License-Identifier: Apache-2.0
 *
 * Initial native LVGL shell component for openvela. This is not a complete
 * operating system and does not yet launch applications or expose hardware
 * controls.
 ****************************************************************************/

#include <nuttx/config.h>
#include <unistd.h>
#include <sys/boardctl.h>

#include <lvgl/lvgl.h>

#if defined(CONFIG_BOARDCTL) && !defined(CONFIG_NSH_ARCHINIT)
#  define NESAOS_NEED_BOARDINIT 1
#endif

#ifdef CONFIG_INPUT_TOUCHSCREEN
#  define NESAOS_INPUT_PATH CONFIG_NESAOS_HOME_DEVPATH
#endif

static lv_obj_t *g_status_label;

static void nesaos_tile_event(lv_event_t *event)
{
  const char *target = (const char *)lv_event_get_user_data(event);

  if (g_status_label != NULL && target != NULL)
    {
      lv_label_set_text_fmt(g_status_label, "%s  •  integration pending",
                            target);
    }
}

static void nesaos_create_tile(lv_obj_t *parent,
                               const char *title,
                               const char *target,
                               lv_align_t align,
                               lv_coord_t x,
                               lv_coord_t y,
                               lv_color_t color)
{
  lv_obj_t *button;
  lv_obj_t *label;

  button = lv_button_create(parent);
  lv_obj_set_size(button, 174, 66);
  lv_obj_align(button, align, x, y);
  lv_obj_set_style_radius(button, 18, 0);
  lv_obj_set_style_bg_color(button, color, 0);
  lv_obj_set_style_border_width(button, 0, 0);
  lv_obj_add_event_cb(button, nesaos_tile_event, LV_EVENT_CLICKED,
                      (void *)target);

  label = lv_label_create(button);
  lv_label_set_text(label, title);
  lv_obj_set_style_text_color(label, lv_color_hex(0xffffff), 0);
  lv_obj_center(label);
}

static void nesaos_create_home(void)
{
  lv_obj_t *screen;
  lv_obj_t *title;
  lv_obj_t *subtitle;

  screen = lv_screen_active();
  lv_obj_set_style_bg_color(screen, lv_color_hex(0x101d20), 0);
  lv_obj_set_style_bg_opa(screen, LV_OPA_COVER, 0);

  title = lv_label_create(screen);
  lv_label_set_text(title, "NesaOS");
  lv_obj_set_style_text_color(title, lv_color_hex(0xe5fbf7), 0);
  lv_obj_set_style_text_font(title, LV_FONT_DEFAULT, 0);
  lv_obj_align(title, LV_ALIGN_TOP_MID, 0, 42);

  subtitle = lv_label_create(screen);
  lv_label_set_text(subtitle, "YOUR WATCH. YOUR SYSTEM.");
  lv_obj_set_style_text_color(subtitle, lv_color_hex(0x8bcfc5), 0);
  lv_obj_align(subtitle, LV_ALIGN_TOP_MID, 0, 76);

  nesaos_create_tile(screen, "Calculator", "calculator",
                     LV_ALIGN_TOP_LEFT, 22, 132,
                     lv_color_hex(0x168f86));
  nesaos_create_tile(screen, "Snake", "snake_game",
                     LV_ALIGN_TOP_RIGHT, -22, 132,
                     lv_color_hex(0x477fae));
  nesaos_create_tile(screen, "Music", "music_player2",
                     LV_ALIGN_TOP_LEFT, 22, 210,
                     lv_color_hex(0x806044));
  nesaos_create_tile(screen, "Virtual Pet", "pet",
                     LV_ALIGN_TOP_RIGHT, -22, 210,
                     lv_color_hex(0x397f82));

  g_status_label = lv_label_create(screen);
  lv_label_set_text(g_status_label, "NesaOS native shell");
  lv_obj_set_style_text_color(g_status_label, lv_color_hex(0xc5d8d5), 0);
  lv_obj_align(g_status_label, LV_ALIGN_BOTTOM_MID, 0, -38);
}

int main(int argc, FAR char *argv[])
{
  lv_nuttx_dsc_t info;
  lv_nuttx_result_t result;

  (void)argc;

  if (lv_is_initialized())
    {
      LV_LOG_ERROR("LVGL already initialized! aborting.");
      return -1;
    }

#ifdef NESAOS_NEED_BOARDINIT
  boardctl(BOARDIOC_INIT, 0);
#endif

  lv_init();
  lv_nuttx_dsc_init(&info);

#ifdef CONFIG_LV_USE_NUTTX_LCD
  info.fb_path = "/dev/lcd0";
#endif

#ifdef CONFIG_INPUT_TOUCHSCREEN
  info.input_path = NESAOS_INPUT_PATH;
#endif

  lv_nuttx_init(&info, &result);

  if (result.disp == NULL)
    {
      LV_LOG_ERROR("NesaOS Home display initialization failed.");
      return 1;
    }

  nesaos_create_home();

  for (;;)
    {
      uint32_t idle = lv_timer_handler();

      /* Minimum sleep of 1ms, matching the upstream LVGL NuttX demo. */

      idle = idle ? idle : 1;
      usleep(idle * 1000);
    }

  return 0;
}
