; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 21m 21s; total estimated time: 27m 37s
; total layer number: 30
; total filament length [mm] : 3210.32
; total filament volume [cm^3] : 7721.72
; total filament weight [g] : 9.57
; model label id: 181,192,203,214,225,236,247,258,269
; object max height: 2.00,2.00,2.00,4.00,4.00,4.00,4.00,6.00,2.00
; filament_density: 1.24
; filament_diameter: 1.75
; max_z_height: 6.00
; filament: 1
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 70
; additional_fan_full_speed_layer = 0
; alternate_extra_wall = 0
; ams_filament_load_time_ams = 0
; ams_filament_load_time_ams_lite = 0
; ams_filament_load_time_n3f_s = 0
; ams_filament_unload_time_ams = 0
; ams_filament_unload_time_ams_lite = 0
; ams_filament_unload_time_n3f_s = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_heat_soak_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = no_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = ;=P1S 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == \"PETG\"}\nM109 S260\n{elsif filament_type[next_extruder] == \"PVA\"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 1
; close_fan_the_first_x_layers = 1
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 35
; cool_plate_temp_initial_layer = 35
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; counterbore_hole_bridging = none
; curr_bed_type = Cool Plate
; default_acceleration = 10000
; default_ams_type = -1
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL P1S 0.4 nozzle"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = ;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 1
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0
; eng_plate_temp_initial_layer = 0
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = 
; extruder_offset = 0x2
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 80
; fan_direction = left
; fan_max_speed = 100
; fan_min_speed = 50
; farthest_point_timelapse = 1
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 100
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #00AE42
; filament_cooling_before_tower = 0
; filament_cost = 20
; filament_density = 1.24
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 45
; filament_dev_ams_drying_temperature = 45
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 70
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 45
; filament_dev_drying_softening_temperature = 50
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.98
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFL99
; filament_is_mixed = 0
; filament_is_support = 0
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 12
; filament_metal_stickiness = None
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 10
; filament_prime_volume = 45
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_scarf_gap = 15%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Generic PLA @BBL P1P"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S255\n{elsif(bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S180\n{endif};Prevent PLA from jamming\n\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PLA
; filament_velocity_adaptation_factor = 1
; filament_vendor = Generic
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0,280,280,280,280,0,280,280,280,280,0,280,280,280,280,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; hot_plate_temp = 65
; hot_plate_temp_initial_layer = 65
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of \"timelapse_record_flag\"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_force_Y = 0
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,500
; machine_max_speed_y = 500,500
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: P1S-0.4 ========================\n;===== date: 20251031 =====================\n;===== turn on the HB fan & MC board fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\nM710 A1 S255 ;turn on MC fan by default(P1S)\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action:54\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]==\"PLA\"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_extruder]A\nM620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X230 Y15\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]==\"PLA\"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== fmech mode fast check============================\n\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature_initial_layer[initial_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type==\"Textured PEI Plate\"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 28
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 220
; nozzle_temperature_initial_layer = 220
; nozzle_temperature_range_high = 240
; nozzle_temperature_range_low = 190
; nozzle_type = stainless_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 50%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by layer
; print_settings_id = Baymax fit tests - P1S 0.4 - 0.20 PLA
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab P1S
; printer_notes = 
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 8
; slow_down_min_speed = 20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 20%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45
; supertack_plate_temp_initial_layer = 45
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45
; template_custom_gcode = 
; textured_plate_temp = 65
; textured_plate_temp_initial_layer = 65
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; SKIPPABLE_END
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 3
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 220
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R27
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: P1S-0.4 ========================
;===== date: 20251031 =====================
;===== turn on the HB fan & MC board fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
M710 A1 S255 ;turn on MC fan by default(P1S)
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action:54
M140 S35 ;set bed temp
M190 S35 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F299.339 T240


M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
M73 P2 R27
G1 E50 F200
M400
M104 S220
G92 E0
M73 P17 R22
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P18 R22
G1 E-0.5 F300

M73 P19 R22
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
M73 P20 R22
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X230 Y15
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X78.3651 Y78.0036 I99.2699 J99.9927
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression


;=============turn on fans to prevent PLA jamming=================

    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead


M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
M73 P20 R21
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== fmech mode fast check============================


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F4800
G0 Y11 E0.700 F1200
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X18 E15 F4800
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Cool Plate

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
; MACHINE_START_GCODE_END
; filament start gcode
;Prevent PLA from jamming


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/30
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X145.807 Y78.43 F30000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X151.721 Y78.43 E.22028
M73 P21 R21
G1 X151.721 Y77.43 E.03725
G1 X164.492 Y77.43 E.4757
G1 X164.492 Y92.802 E.57254
G1 X143.121 Y92.802 E.79602
G1 X143.121 Y77.43 E.57254
G1 X144.892 Y77.43 E.06599
G1 X144.892 Y78.43 E.03725
G1 X145.747 Y78.43 E.03181
M204 S6000
G1 X145.807 Y77.973 F30000
G1 F3000
M204 S500
G1 X151.264 Y77.973 E.20325
G1 X151.264 Y76.973 E.03725
G1 X164.949 Y76.973 E.50975
G1 X164.949 Y93.259 E.60659
G1 X142.664 Y93.259 E.83006
G1 X142.664 Y76.973 E.60659
G1 X145.349 Y76.973 E.10004
G1 X145.349 Y77.973 E.03725
G1 X145.747 Y77.973 E.01479
M204 S6000
G1 X145.806 Y77.516 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X147.806 Y77.516 E.07449
G1 X147.806 Y76.516 E.03725
G1 X148.806 Y76.516 E.03725
G1 X148.806 Y77.516 E.03725
M73 P22 R21
G1 X150.806 Y77.516 E.07449
G1 X150.806 Y76.516 E.03725
G1 X165.407 Y76.516 E.5438
G1 X165.407 Y93.716 E.64064
G1 X142.206 Y93.716 E.86411
G1 X142.206 Y76.516 E.64064
G1 X145.806 Y76.516 E.13409
G1 X145.806 Y77.456 E.03501
; WIPE_START
G1 X147.806 Y77.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X155.423 Y77.994 Z.6 F30000
G1 X164.31 Y78.552 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50708
G1 F6300
M204 S500
G1 X163.576 Y77.819 E.03923
G1 X162.92 Y77.819 E.02483
G1 X164.104 Y79.003 E.06333
G1 X164.104 Y79.659 E.02483
G1 X162.263 Y77.819 E.09845
G1 X161.607 Y77.819 E.02483
G1 X164.104 Y80.316 E.13356
G1 X164.104 Y80.972 E.02483
G1 X160.951 Y77.819 E.16867
G1 X160.294 Y77.819 E.02483
G1 X164.104 Y81.629 E.20378
G1 X164.104 Y82.285 E.02483
G1 X159.638 Y77.819 E.23889
G1 X158.981 Y77.819 E.02483
G1 X164.104 Y82.942 E.27401
G1 X164.104 Y83.598 E.02483
G1 X158.325 Y77.819 E.30912
G1 X157.668 Y77.819 E.02483
G1 X164.104 Y84.254 E.34423
G1 X164.104 Y84.911 E.02483
G1 X157.012 Y77.819 E.37934
G1 X156.356 Y77.819 E.02483
G1 X164.104 Y85.567 E.41446
G1 X164.104 Y86.224 E.02483
G1 X155.699 Y77.819 E.44957
G1 X155.043 Y77.819 E.02483
G1 X164.104 Y86.88 E.48468
G1 X164.104 Y87.537 E.02483
G1 X154.386 Y77.819 E.51979
G1 X153.73 Y77.819 E.02483
G1 X164.104 Y88.193 E.5549
G1 X164.104 Y88.849 E.02483
G1 X153.073 Y77.819 E.59001
G1 X152.417 Y77.819 E.02483
G1 X164.104 Y89.506 E.62513
G1 X164.104 Y90.162 E.02483
G1 X152.109 Y78.167 E.6416
G1 X152.104 Y78.819 E.02464
G1 X164.104 Y90.819 E.64186
M73 P23 R21
G1 X164.104 Y91.475 E.02483
G1 X151.448 Y78.819 E.67697
G1 X150.791 Y78.819 E.02483
G1 X164.104 Y92.131 E.71209
G1 X164.104 Y92.414 E.01068
G1 X163.73 Y92.414 E.01415
G1 X150.135 Y78.819 E.72718
G1 X149.479 Y78.819 E.02483
G1 X163.073 Y92.414 E.72718
G1 X162.417 Y92.414 E.02483
G1 X148.822 Y78.819 E.72718
G1 X148.166 Y78.819 E.02483
G1 X161.76 Y92.414 E.72718
G1 X161.104 Y92.414 E.02483
G1 X147.509 Y78.819 E.72718
G1 X146.853 Y78.819 E.02483
G1 X160.448 Y92.414 E.72718
G1 X159.791 Y92.414 E.02483
G1 X146.196 Y78.819 E.72718
G1 X145.54 Y78.819 E.02483
G1 X159.135 Y92.414 E.72718
G1 X158.478 Y92.414 E.02483
G1 X143.884 Y77.819 E.78067
G1 X143.509 Y77.819 E.01416
G1 X143.509 Y78.101 E.01067
G1 X157.822 Y92.414 E.76559
G1 X157.165 Y92.414 E.02483
G1 X143.509 Y78.757 E.73048
G1 X143.509 Y79.414 E.02483
G1 X156.509 Y92.414 E.69536
G1 X155.853 Y92.414 E.02483
G1 X143.509 Y80.07 E.66025
G1 X143.509 Y80.727 E.02483
G1 X155.196 Y92.414 E.62514
G1 X154.54 Y92.414 E.02483
G1 X143.509 Y81.383 E.59003
G1 X143.509 Y82.039 E.02483
G1 X153.883 Y92.414 E.55492
G1 X153.227 Y92.414 E.02483
G1 X143.509 Y82.696 E.5198
G1 X143.509 Y83.352 E.02483
G1 X152.571 Y92.414 E.48469
G1 X151.914 Y92.414 E.02483
G1 X143.509 Y84.009 E.44958
G1 X143.509 Y84.665 E.02483
G1 X151.258 Y92.414 E.41447
G1 X150.601 Y92.414 E.02483
G1 X143.509 Y85.322 E.37936
G1 X143.509 Y85.978 E.02483
G1 X149.945 Y92.414 E.34424
G1 X149.288 Y92.414 E.02483
G1 X143.509 Y86.634 E.30913
G1 X143.509 Y87.291 E.02483
G1 X148.632 Y92.414 E.27402
G1 X147.976 Y92.414 E.02483
G1 X143.509 Y87.947 E.23891
G1 X143.509 Y88.604 E.02483
G1 X147.319 Y92.414 E.2038
G1 X146.663 Y92.414 E.02483
G1 X143.509 Y89.26 E.16868
G1 X143.509 Y89.917 E.02483
G1 X146.006 Y92.414 E.13357
G1 X145.35 Y92.414 E.02483
G1 X143.509 Y90.573 E.09846
G1 X143.509 Y91.229 E.02483
G1 X144.693 Y92.414 E.06335
G1 X144.037 Y92.414 E.02483
G1 X143.303 Y91.68 E.03924
; OBJECT_ID: 203
; WIPE_START
G1 X144.037 Y92.414 E-.39422
G1 X144.693 Y92.414 E-.24944
G1 X144.477 Y92.197 E-.11634
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
M204 S6000
G1 X149.846 Y97.622 Z.6 F30000
G1 X166.565 Y114.516 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X166.565 Y114.973 E.01702
G1 X139.85 Y114.973 E.995
G1 X139.85 Y99.259 E.58529
G1 X166.565 Y99.259 E.995
G1 X166.565 Y114.456 E.56603
M204 S6000
G1 X166.107 Y114.516 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X140.307 Y114.516 E.96095
G1 X140.307 Y99.716 E.55124
G1 X166.107 Y99.716 E.96095
G1 X166.107 Y114.456 E.54901
; WIPE_START
G1 X164.107 Y114.461 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X156.475 Y114.441 Z.6 F30000
G1 X139.393 Y114.395 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X139.393 Y115.602 E.04496
G1 X138.022 Y115.602 E.05109
G1 X138.022 Y97.43 E.67683
G1 X168.393 Y97.43 E1.13123
G1 X168.393 Y116.802 E.72152
G1 X147.222 Y116.802 E.78857
G1 X147.222 Y115.43 E.05109
G1 X167.022 Y115.43 E.73748
G1 X167.022 Y98.802 E.61934
G1 X139.393 Y98.802 E1.02905
G1 X139.393 Y114.335 E.57854
; WIPE_START
G1 X139.393 Y115.602 E-.48149
G1 X138.66 Y115.602 E-.27851
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X140.85 Y116.059 Z.6 F30000
M73 P24 R20
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
G1 X137.85 Y116.059 E.11174
G1 X137.85 Y117.259 E.0447
G1 X137.565 Y117.259 E.01065
G1 X137.565 Y96.973 E.75557
G1 X168.85 Y96.973 E1.16528
G1 X168.85 Y117.259 E.75557
G1 X146.765 Y117.259 E.82262
G1 X146.765 Y116.059 E.0447
G1 X140.91 Y116.059 E.21804
M204 S6000
G1 X141.307 Y116.516 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X141.307 Y117.716 E.0447
G1 X140.307 Y117.716 E.03725
G1 X140.307 Y116.516 E.0447
G1 X138.307 Y116.516 E.07449
G1 X138.307 Y117.716 E.0447
G1 X137.107 Y117.716 E.0447
G1 X137.107 Y96.516 E.78962
G1 X169.308 Y96.516 E1.19933
G1 X169.308 Y117.716 E.78962
G1 X146.307 Y117.716 E.85666
G1 X146.307 Y116.516 E.0447
G1 X144.307 Y116.516 E.07449
G1 X144.307 Y117.716 E.0447
G1 X143.307 Y117.716 E.03725
G1 X143.307 Y116.516 E.0447
G1 X141.367 Y116.516 E.07226
M204 S6000
G1 X140.807 Y116.288 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.58586
G1 F3000
M204 S500
G1 X140.807 Y117.488 E.05309
; WIPE_START
G1 X140.807 Y116.288 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X139.622 Y115.516 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.67172
G1 F3000
M204 S500
G1 X146.993 Y115.516 E.37768
; WIPE_START
G1 X144.993 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X143.807 Y116.288 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.58586
G1 F3000
M204 S500
G1 X143.807 Y117.488 E.05309
; WIPE_START
G1 X143.807 Y116.288 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X149.781 Y111.537 Z.6 F30000
G1 X167.285 Y97.613 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50066
G1 F6300
M204 S500
G1 X168.005 Y98.333 E.03796
G1 X168.005 Y98.98 E.02415
G1 X166.843 Y97.819 E.06126
G1 X166.196 Y97.819 E.02415
G1 X166.791 Y98.414 E.03137
G1 X167.41 Y98.414 E.0231
G1 X167.41 Y99.033 E.0231
G1 X168.211 Y99.833 E.04222
; WIPE_START
G1 X167.41 Y99.033 E-.43013
G1 X167.41 Y98.414 E-.23533
G1 X167.161 Y98.414 E-.09454
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X167.204 Y99.475 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X168.005 Y100.275 E.04222
G1 X168.005 Y100.922 E.02415
G1 X167.41 Y100.328 E.03137
G1 X167.41 Y100.975 E.02415
G1 X168.005 Y101.57 E.03137
G1 X168.005 Y102.217 E.02415
G1 X167.41 Y101.622 E.03137
G1 X167.41 Y102.27 E.02415
G1 X168.005 Y102.864 E.03137
G1 X168.005 Y103.512 E.02415
G1 X167.41 Y102.917 E.03137
G1 X167.41 Y103.564 E.02415
G1 X168.005 Y104.159 E.03137
G1 X168.005 Y104.806 E.02415
G1 X167.41 Y104.212 E.03137
G1 X167.41 Y104.859 E.02415
G1 X168.005 Y105.454 E.03137
G1 X168.005 Y106.101 E.02415
G1 X167.41 Y105.506 E.03137
G1 X167.41 Y106.154 E.02415
G1 X168.005 Y106.748 E.03137
G1 X168.005 Y107.396 E.02415
G1 X167.41 Y106.801 E.03137
G1 X167.41 Y107.448 E.02415
G1 X168.005 Y108.043 E.03137
G1 X168.005 Y108.69 E.02415
G1 X167.41 Y108.096 E.03137
G1 X167.41 Y108.743 E.02415
G1 X168.005 Y109.338 E.03137
G1 X168.005 Y109.985 E.02415
G1 X167.41 Y109.39 E.03137
G1 X167.41 Y110.038 E.02415
G1 X168.005 Y110.632 E.03137
G1 X168.005 Y111.28 E.02415
G1 X167.41 Y110.685 E.03137
G1 X167.41 Y111.332 E.02415
G1 X168.005 Y111.927 E.03137
G1 X168.005 Y112.574 E.02415
G1 X167.41 Y111.98 E.03137
G1 X167.41 Y112.627 E.02415
G1 X168.005 Y113.222 E.03137
M73 P25 R20
G1 X168.005 Y113.869 E.02415
G1 X167.41 Y113.274 E.03137
G1 X167.41 Y113.922 E.02415
G1 X168.005 Y114.517 E.03137
G1 X168.005 Y115.164 E.02415
G1 X167.41 Y114.569 E.03137
G1 X167.41 Y115.216 E.02415
G1 X168.005 Y115.811 E.03137
G1 X168.005 Y116.414 E.02247
G1 X167.96 Y116.414 E.00167
G1 X167.365 Y115.819 E.03137
G1 X166.718 Y115.819 E.02415
G1 X167.313 Y116.414 E.03137
G1 X166.665 Y116.414 E.02415
G1 X166.071 Y115.819 E.03137
G1 X165.423 Y115.819 E.02415
G1 X166.018 Y116.414 E.03137
G1 X165.371 Y116.414 E.02415
G1 X164.776 Y115.819 E.03137
G1 X164.129 Y115.819 E.02415
G1 X164.723 Y116.414 E.03137
G1 X164.076 Y116.414 E.02415
G1 X163.481 Y115.819 E.03137
G1 X162.834 Y115.819 E.02415
G1 X163.429 Y116.414 E.03137
G1 X162.781 Y116.414 E.02415
G1 X162.187 Y115.819 E.03137
G1 X161.539 Y115.819 E.02415
G1 X162.134 Y116.414 E.03137
G1 X161.487 Y116.414 E.02415
G1 X160.892 Y115.819 E.03137
G1 X160.245 Y115.819 E.02415
G1 X160.839 Y116.414 E.03137
G1 X160.192 Y116.414 E.02415
G1 X159.597 Y115.819 E.03137
G1 X158.95 Y115.819 E.02415
G1 X159.545 Y116.414 E.03137
G1 X158.897 Y116.414 E.02415
G1 X158.302 Y115.819 E.03137
G1 X157.655 Y115.819 E.02415
G1 X158.25 Y116.414 E.03137
G1 X157.602 Y116.414 E.02415
G1 X157.008 Y115.819 E.03137
G1 X156.36 Y115.819 E.02415
G1 X156.955 Y116.414 E.03137
G1 X156.308 Y116.414 E.02415
G1 X155.713 Y115.819 E.03137
G1 X155.066 Y115.819 E.02415
G1 X155.66 Y116.414 E.03137
G1 X155.013 Y116.414 E.02415
G1 X154.418 Y115.819 E.03137
G1 X153.771 Y115.819 E.02415
G1 X154.366 Y116.414 E.03137
G1 X153.718 Y116.414 E.02415
G1 X153.124 Y115.819 E.03137
G1 X152.476 Y115.819 E.02415
G1 X153.071 Y116.414 E.03137
G1 X152.424 Y116.414 E.02415
G1 X151.829 Y115.819 E.03137
G1 X151.182 Y115.819 E.02415
G1 X151.776 Y116.414 E.03137
G1 X151.129 Y116.414 E.02415
G1 X150.534 Y115.819 E.03137
G1 X149.887 Y115.819 E.02415
G1 X150.482 Y116.414 E.03137
G1 X149.834 Y116.414 E.02415
G1 X149.24 Y115.819 E.03137
G1 X148.592 Y115.819 E.02415
G1 X149.187 Y116.414 E.03137
G1 X148.54 Y116.414 E.02415
G1 X147.945 Y115.819 E.03137
G1 X147.61 Y115.819 E.01249
G1 X147.61 Y116.131 E.01166
G1 X148.098 Y116.619 E.02574
; WIPE_START
G1 X147.61 Y116.131 E-.2622
G1 X147.61 Y115.819 E-.11874
G1 X147.945 Y115.819 E-.12725
G1 X148.414 Y116.288 E-.25181
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X153.851 Y110.931 Z.6 F30000
G1 X166.349 Y98.619 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X165.549 Y97.819 E.04222
G1 X164.901 Y97.819 E.02415
G1 X165.496 Y98.414 E.03137
G1 X164.849 Y98.414 E.02415
G1 X164.254 Y97.819 E.03137
G1 X163.607 Y97.819 E.02415
G1 X164.201 Y98.414 E.03137
G1 X163.554 Y98.414 E.02415
G1 X162.959 Y97.819 E.03137
G1 X162.312 Y97.819 E.02415
G1 X162.907 Y98.414 E.03137
G1 X162.259 Y98.414 E.02415
G1 X161.665 Y97.819 E.03137
G1 X161.017 Y97.819 E.02415
G1 X161.612 Y98.414 E.03137
G1 X160.965 Y98.414 E.02415
G1 X160.37 Y97.819 E.03137
G1 X159.723 Y97.819 E.02415
G1 X160.317 Y98.414 E.03137
G1 X159.67 Y98.414 E.02415
G1 X159.075 Y97.819 E.03137
G1 X158.428 Y97.819 E.02415
G1 X159.023 Y98.414 E.03137
G1 X158.375 Y98.414 E.02415
G1 X157.781 Y97.819 E.03137
G1 X157.133 Y97.819 E.02415
G1 X157.728 Y98.414 E.03137
G1 X157.081 Y98.414 E.02415
G1 X156.486 Y97.819 E.03137
G1 X155.839 Y97.819 E.02415
G1 X156.433 Y98.414 E.03137
G1 X155.786 Y98.414 E.02415
G1 X155.191 Y97.819 E.03137
G1 X154.544 Y97.819 E.02415
G1 X155.139 Y98.414 E.03137
G1 X154.491 Y98.414 E.02415
G1 X153.897 Y97.819 E.03137
G1 X153.249 Y97.819 E.02415
G1 X153.844 Y98.414 E.03137
G1 X153.197 Y98.414 E.02415
G1 X152.602 Y97.819 E.03137
G1 X151.955 Y97.819 E.02415
G1 X152.549 Y98.414 E.03137
G1 X151.902 Y98.414 E.02415
G1 X151.307 Y97.819 E.03137
G1 X150.66 Y97.819 E.02415
G1 X151.255 Y98.414 E.03137
G1 X150.607 Y98.414 E.02415
G1 X150.013 Y97.819 E.03137
G1 X149.365 Y97.819 E.02415
G1 X149.96 Y98.414 E.03137
G1 X149.313 Y98.414 E.02415
G1 X148.718 Y97.819 E.03137
G1 X148.071 Y97.819 E.02415
G1 X148.665 Y98.414 E.03137
G1 X148.018 Y98.414 E.02415
G1 X147.423 Y97.819 E.03137
G1 X146.776 Y97.819 E.02415
G1 X147.371 Y98.414 E.03137
G1 X146.723 Y98.414 E.02415
G1 X146.129 Y97.819 E.03137
G1 X145.481 Y97.819 E.02415
G1 X146.076 Y98.414 E.03137
G1 X145.429 Y98.414 E.02415
G1 X144.834 Y97.819 E.03137
G1 X144.187 Y97.819 E.02415
G1 X144.781 Y98.414 E.03137
G1 X144.134 Y98.414 E.02415
G1 X143.539 Y97.819 E.03137
G1 X142.892 Y97.819 E.02415
G1 X143.487 Y98.414 E.03137
G1 X142.839 Y98.414 E.02415
G1 X142.245 Y97.819 E.03137
G1 X141.597 Y97.819 E.02415
G1 X142.192 Y98.414 E.03137
G1 X141.545 Y98.414 E.02415
G1 X140.95 Y97.819 E.03137
G1 X140.302 Y97.819 E.02415
G1 X140.897 Y98.414 E.03137
G1 X140.25 Y98.414 E.02415
G1 X139.655 Y97.819 E.03137
G1 X139.008 Y97.819 E.02415
G1 X139.602 Y98.414 E.03137
G1 X139.005 Y98.414 E.02229
G1 X139.005 Y98.463 E.00185
G1 X138.41 Y97.869 E.03137
G1 X138.41 Y98.516 E.02415
G1 X139.005 Y99.111 E.03137
G1 X139.005 Y99.758 E.02415
G1 X138.41 Y99.163 E.03137
G1 X138.41 Y99.811 E.02415
G1 X139.005 Y100.405 E.03137
G1 X139.005 Y101.053 E.02415
G1 X138.41 Y100.458 E.03137
G1 X138.41 Y101.105 E.02415
G1 X139.005 Y101.7 E.03137
G1 X139.005 Y102.347 E.02415
G1 X138.41 Y101.753 E.03137
G1 X138.41 Y102.4 E.02415
G1 X139.005 Y102.995 E.03137
G1 X139.005 Y103.642 E.02415
G1 X138.41 Y103.047 E.03137
G1 X138.41 Y103.695 E.02415
G1 X139.005 Y104.289 E.03137
G1 X139.005 Y104.937 E.02415
G1 X138.41 Y104.342 E.03137
G1 X138.41 Y104.989 E.02415
G1 X139.005 Y105.584 E.03137
G1 X139.005 Y106.231 E.02415
G1 X138.41 Y105.637 E.03137
G1 X138.41 Y106.284 E.02415
G1 X139.005 Y106.879 E.03137
G1 X139.005 Y107.526 E.02415
G1 X138.41 Y106.931 E.03137
G1 X138.41 Y107.579 E.02415
G1 X139.005 Y108.173 E.03137
G1 X139.005 Y108.821 E.02415
G1 X138.41 Y108.226 E.03137
G1 X138.41 Y108.873 E.02415
G1 X139.005 Y109.468 E.03137
G1 X139.005 Y110.116 E.02415
G1 X138.41 Y109.521 E.03137
G1 X138.41 Y110.168 E.02415
G1 X139.005 Y110.763 E.03137
G1 X139.005 Y111.41 E.02415
G1 X138.41 Y110.815 E.03137
G1 X138.41 Y111.463 E.02415
G1 X139.005 Y112.058 E.03137
G1 X139.005 Y112.705 E.02415
G1 X138.41 Y112.11 E.03137
G1 X138.41 Y112.758 E.02415
G1 X139.005 Y113.352 E.03137
G1 X139.005 Y114 E.02415
G1 X138.41 Y113.405 E.03137
G1 X138.41 Y114.052 E.02415
G1 X139.005 Y114.647 E.03137
G1 X139.005 Y115.214 E.02114
G1 X138.924 Y115.214 E.00301
G1 X138.204 Y114.494 E.03797
; OBJECT_ID: 269
; WIPE_START
G1 X138.924 Y115.214 E-.38682
G1 X139.005 Y115.214 E-.03062
G1 X139.005 Y114.647 E-.21537
G1 X138.768 Y114.41 E-.12719
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
M204 S6000
G1 X144.047 Y119.923 Z.6 F30000
G1 X175.982 Y153.277 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X175.981 Y153.285 E.00031
G1 X175.073 Y156.671 E.13057
G1 X173.732 Y159.91 E.13058
G1 X171.979 Y162.946 E.13057
G1 X169.845 Y165.727 E.13057
G1 X167.366 Y168.206 E.13058
G1 X164.585 Y170.34 E.13058
G1 X161.549 Y172.093 E.13058
G1 X158.31 Y173.435 E.13057
G1 X154.924 Y174.342 E.13057
G1 X152.452 Y174.668 E.09285
G1 X151.448 Y174.8 E.03773
G1 X147.942 Y174.8 E.13057
G1 X144.466 Y174.342 E.13058
G1 X143.488 Y174.08 E.03772
G1 X141.08 Y173.435 E.09285
G1 X137.841 Y172.093 E.13057
G1 X134.805 Y170.34 E.13058
G1 X132.024 Y168.206 E.13057
G1 X129.545 Y165.727 E.13058
G1 X127.411 Y162.946 E.13057
G1 X125.658 Y159.91 E.13058
G1 X124.316 Y156.671 E.13057
G1 X123.409 Y153.285 E.13057
G1 X123.084 Y150.813 E.09285
G1 X122.951 Y149.809 E.03773
G1 X122.951 Y146.304 E.13057
G1 X123.409 Y142.828 E.13058
G1 X123.671 Y141.849 E.03772
G1 X124.316 Y139.442 E.09285
G1 X125.658 Y136.203 E.13057
G1 X127.411 Y133.167 E.13058
G1 X129.545 Y130.385 E.13057
G1 X132.024 Y127.906 E.13058
G1 X134.805 Y125.772 E.13057
G1 X137.841 Y124.019 E.13058
G1 X141.08 Y122.678 E.13057
G1 X144.466 Y121.77 E.13057
G1 X147.942 Y121.313 E.13057
G1 X150.953 Y121.313 E.11214
G1 X151.448 Y121.313 E.01843
G1 X154.923 Y121.77 E.13058
G1 X158.31 Y122.678 E.13057
G1 X161.548 Y124.019 E.13057
G1 X164.585 Y125.772 E.13058
G1 X167.366 Y127.906 E.13057
G1 X169.845 Y130.385 E.13058
G1 X171.979 Y133.166 E.13057
G1 X173.732 Y136.203 E.13058
G1 X175.073 Y139.441 E.13057
G1 X175.981 Y142.828 E.13057
G1 X176.306 Y145.299 E.09285
G1 X176.438 Y146.303 E.03773
G1 X176.438 Y149.809 E.13057
G1 X175.99 Y153.217 E.12803
; WIPE_START
G1 X175.981 Y153.285 E-.02597
G1 X175.481 Y155.151 E-.73403
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X171.568 Y148.598 Z.6 F30000
G1 X155.079 Y120.987 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
G1 X158.566 Y121.922 E.13446
G1 X161.902 Y123.303 E.13447
G1 X165.028 Y125.108 E.13446
G1 X167.892 Y127.306 E.13446
G1 X170.445 Y129.859 E.13447
G1 X172.643 Y132.723 E.13446
G1 X174.448 Y135.849 E.13447
G1 X175.829 Y139.185 E.13446
G1 X176.764 Y142.672 E.13447
G1 X177.235 Y146.251 E.13447
G1 X177.235 Y149.861 E.13446
G1 X176.764 Y153.441 E.13447
G1 X175.829 Y156.928 E.13446
G1 X174.448 Y160.263 E.13447
G1 X172.643 Y163.39 E.13446
G1 X170.445 Y166.254 E.13446
G1 X167.892 Y168.806 E.13447
; object ids of layer 1 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer1 end: 181,192,203,214,225,236,247,258,269
M625
G1 X165.028 Y171.004 E.13446
G1 X161.902 Y172.809 E.13447
G1 X158.567 Y174.191 E.13446
G1 X155.079 Y175.125 E.13447
G1 X151.5 Y175.596 E.13447
G1 X147.89 Y175.596 E.13446
G1 X144.311 Y175.125 E.13447
G1 X140.824 Y174.191 E.13446
G1 X137.488 Y172.809 E.13446
G1 X134.362 Y171.004 E.13447
G1 X131.498 Y168.807 E.13446
G1 X128.945 Y166.254 E.13447
G1 X126.747 Y163.39 E.13446
G1 X124.942 Y160.263 E.13447
G1 X123.56 Y156.928 E.13446
G1 X122.626 Y153.441 E.13447
G1 X122.155 Y149.861 E.13447
G1 X122.155 Y146.251 E.13446
G1 X122.626 Y142.672 E.13447
G1 X123.56 Y139.185 E.13446
G1 X124.942 Y135.85 E.13447
G1 X126.747 Y132.723 E.13446
G1 X128.945 Y129.859 E.13446
G1 X131.497 Y127.306 E.13447
G1 X134.361 Y125.109 E.13446
G1 X137.488 Y123.303 E.13447
G1 X140.823 Y121.922 E.13446
G1 X144.31 Y120.988 E.13447
G1 X147.89 Y120.516 E.13447
G1 X151.5 Y120.516 E.13446
G1 X152.952 Y120.707 E.05457
G1 X155.02 Y120.98 E.07767
M204 S6000
G1 X154.968 Y121.375 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.382432
G1 F3000
M204 S500
G1 X155.001 Y121.379 E.00094
G1 X158.438 Y122.3 E.09843
G1 X161.735 Y123.667 E.09874
G1 X164.815 Y125.447 E.09843
G1 X167.629 Y127.606 E.09812
M73 P26 R20
G1 X170.137 Y130.114 E.09813
G1 X172.311 Y132.945 E.09873
G1 X174.09 Y136.026 E.09844
G1 X175.451 Y139.313 E.09843
G1 X176.372 Y142.75 E.09843
G3 X176.701 Y145.247 I-75.625 J11.232 E.06969
G3 X176.836 Y146.277 I-32.092 J4.743 E.02875
G1 X176.836 Y149.835 E.09843
G1 X176.374 Y153.352 E.09813
G1 X175.451 Y156.799 E.09874
G1 X174.084 Y160.096 E.09874
G1 X172.311 Y163.168 E.09813
G1 X170.152 Y165.982 E.09812
G1 X167.629 Y168.506 E.09874
G1 X164.797 Y170.678 E.09874
G1 X161.725 Y172.451 E.09813
G1 X158.448 Y173.809 E.09812
G1 X155.001 Y174.733 E.09874
G3 X152.504 Y175.062 I-11.232 J-75.625 E.06969
G3 X151.474 Y175.198 I-4.743 J-32.092 E.02875
G1 X147.916 Y175.198 E.09843
G1 X144.389 Y174.734 E.09844
G3 X143.385 Y174.465 I7.697 J-30.755 E.02875
G3 X140.952 Y173.813 I18.691 J-74.6 E.06969
G1 X137.665 Y172.451 E.09843
G1 X134.583 Y170.672 E.09843
G1 X131.761 Y168.506 E.09843
G1 X129.245 Y165.99 E.09843
G1 X127.079 Y163.168 E.09843
G1 X125.3 Y160.087 E.09844
G1 X123.939 Y156.8 E.09843
G1 X123.018 Y153.363 E.09843
G3 X122.689 Y150.865 I75.625 J-11.232 E.06969
G3 X122.553 Y149.835 I32.092 J-4.743 E.02875
G1 X122.553 Y146.278 E.09843
G1 X123.018 Y142.75 E.09844
G3 X123.286 Y141.746 I30.755 J7.697 E.02875
G3 X123.939 Y139.313 I74.6 J18.691 E.06969
G1 X125.3 Y136.026 E.09843
G1 X127.086 Y132.936 E.09874
G1 X129.245 Y130.122 E.09812
G1 X131.753 Y127.614 E.09813
G1 X134.583 Y125.441 E.09873
G1 X137.665 Y123.662 E.09844
G1 X140.962 Y122.297 E.09874
G1 X144.388 Y121.379 E.09813
G1 X147.905 Y120.916 E.09812
G1 X151.474 Y120.915 E.09874
G3 X152.9 Y121.102 I-5.105 J44.334 E.03981
G1 X154.908 Y121.367 E.05603
; OBJECT_ID: 192
; WIPE_START
G1 X155.001 Y121.379 E-.03568
G1 X156.842 Y121.872 E-.72432
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
M204 S6000
G1 X151.568 Y127.389 Z.6 F30000
G1 X116.612 Y163.95 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X116.612 Y164.408 E.01702
G1 X101.898 Y164.408 E.54805
G1 X101.898 Y138.693 E.95775
G1 X116.612 Y138.693 E.54805
G1 X116.612 Y163.89 E.9385
M204 S6000
G1 X116.155 Y163.95 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X102.355 Y163.95 E.514
G1 X102.355 Y139.15 E.92371
G1 X116.155 Y139.15 E.514
G1 X116.155 Y163.89 E.92147
; WIPE_START
G1 X114.155 Y163.899 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X110.993 Y156.952 Z.6 F30000
G1 X102.476 Y138.236 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X101.269 Y138.236 E.04496
G1 X101.269 Y136.865 E.05109
G1 X118.441 Y136.865 E.63958
G1 X118.441 Y166.236 E1.09399
G1 X100.069 Y166.236 E.68428
G1 X100.069 Y143.065 E.86306
G1 X101.441 Y143.065 E.05109
G1 X101.441 Y164.865 E.81197
G1 X117.069 Y164.865 E.58209
G1 X117.069 Y138.236 E.9918
G1 X102.536 Y138.236 E.5413
; WIPE_START
G1 X101.269 Y138.236 E-.48148
G1 X101.269 Y137.503 E-.27852
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X100.812 Y139.693 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
G1 X100.812 Y136.693 E.11174
G1 X99.612 Y136.693 E.0447
G1 X99.612 Y136.408 E.01065
G1 X118.898 Y136.408 E.71833
G1 X118.898 Y166.693 E1.12803
G1 X99.612 Y166.693 E.71833
G1 X99.612 Y142.608 E.89711
G1 X100.812 Y142.608 E.0447
G1 X100.812 Y139.753 E.1063
M204 S6000
G1 X100.355 Y140.15 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X99.155 Y140.15 E.0447
G1 X99.155 Y139.15 E.03725
G1 X100.355 Y139.15 E.0447
G1 X100.355 Y137.15 E.07449
G1 X99.155 Y137.15 E.0447
G1 X99.155 Y135.95 E.0447
G1 X119.355 Y135.95 E.75237
G1 X119.355 Y167.151 E1.16208
G1 X99.155 Y167.151 E.75237
G1 X99.155 Y142.15 E.93116
G1 X100.355 Y142.15 E.0447
G1 X100.355 Y140.21 E.07226
M204 S6000
G1 X100.583 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.58586
G1 F3000
M204 S500
G1 X99.383 Y139.65 E.05309
; WIPE_START
G1 X100.583 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X101.355 Y138.465 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.67172
G1 F3000
M204 S500
G1 X101.355 Y142.836 E.22397
; WIPE_START
G1 X101.355 Y140.836 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X108.881 Y139.566 Z.6 F30000
G1 X118.258 Y137.983 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50552
G1 F6300
M204 S500
G1 X117.528 Y137.253 E.03892
G1 X116.874 Y137.253 E.02466
G1 X118.052 Y138.432 E.06283
G1 X118.052 Y139.086 E.02466
G1 X117.458 Y138.491 E.0317
G1 X117.458 Y137.848 E.02425
G1 X116.814 Y137.848 E.02425
G1 X116.014 Y137.047 E.04267
; WIPE_START
G1 X116.814 Y137.848 E-.43013
G1 X117.458 Y137.848 E-.24447
G1 X117.458 Y138.073 E-.0854
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X116.366 Y138.054 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
M73 P27 R20
G1 X115.565 Y137.253 E.04267
G1 X114.911 Y137.253 E.02466
G1 X115.506 Y137.848 E.0317
G1 X114.852 Y137.848 E.02466
G1 X114.257 Y137.253 E.0317
G1 X113.603 Y137.253 E.02466
G1 X114.197 Y137.848 E.0317
G1 X113.543 Y137.848 E.02466
G1 X112.948 Y137.253 E.0317
G1 X112.294 Y137.253 E.02466
G1 X112.889 Y137.848 E.0317
G1 X112.235 Y137.848 E.02466
G1 X111.64 Y137.253 E.0317
G1 X110.986 Y137.253 E.02466
G1 X111.58 Y137.848 E.0317
G1 X110.926 Y137.848 E.02466
G1 X110.332 Y137.253 E.0317
G1 X109.677 Y137.253 E.02466
G1 X110.272 Y137.848 E.0317
G1 X109.618 Y137.848 E.02466
G1 X109.023 Y137.253 E.0317
G1 X108.369 Y137.253 E.02466
G1 X108.964 Y137.848 E.0317
G1 X108.309 Y137.848 E.02466
G1 X107.715 Y137.253 E.0317
G1 X107.06 Y137.253 E.02466
G1 X107.655 Y137.848 E.0317
G1 X107.001 Y137.848 E.02466
G1 X106.406 Y137.253 E.0317
G1 X105.752 Y137.253 E.02466
G1 X106.347 Y137.848 E.0317
G1 X105.693 Y137.848 E.02466
G1 X105.098 Y137.253 E.0317
G1 X104.444 Y137.253 E.02466
G1 X105.038 Y137.848 E.0317
G1 X104.384 Y137.848 E.02466
G1 X103.789 Y137.253 E.0317
G1 X103.135 Y137.253 E.02466
G1 X103.73 Y137.848 E.0317
G1 X103.076 Y137.848 E.02466
G1 X102.481 Y137.253 E.0317
G1 X101.827 Y137.253 E.02466
G1 X102.421 Y137.848 E.0317
G1 X101.767 Y137.848 E.02466
G1 X101.452 Y137.532 E.01681
; WIPE_START
G1 X101.767 Y137.848 E-.16949
G1 X102.421 Y137.848 E-.2486
G1 X101.827 Y137.253 E-.31959
G1 X101.885 Y137.253 E-.02231
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X100.625 Y143.247 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X101.052 Y143.675 E.02279
G1 X101.052 Y144.329 E.02466
G1 X100.458 Y143.735 E.0317
G1 X100.458 Y144.389 E.02466
G1 X101.052 Y144.983 E.0317
G1 X101.052 Y145.638 E.02466
G1 X100.458 Y145.043 E.0317
G1 X100.458 Y145.697 E.02466
G1 X101.052 Y146.292 E.0317
G1 X101.052 Y146.946 E.02466
G1 X100.458 Y146.351 E.0317
G1 X100.458 Y147.006 E.02466
G1 X101.052 Y147.6 E.0317
G1 X101.052 Y148.254 E.02466
G1 X100.458 Y147.66 E.0317
G1 X100.458 Y148.314 E.02466
G1 X101.052 Y148.909 E.0317
G1 X101.052 Y149.563 E.02466
G1 X100.458 Y148.968 E.0317
G1 X100.458 Y149.622 E.02466
G1 X101.052 Y150.217 E.0317
G1 X101.052 Y150.871 E.02466
G1 X100.458 Y150.277 E.0317
G1 X100.458 Y150.931 E.02466
G1 X101.052 Y151.526 E.0317
G1 X101.052 Y152.18 E.02466
G1 X100.458 Y151.585 E.0317
G1 X100.458 Y152.239 E.02466
G1 X101.052 Y152.834 E.0317
G1 X101.052 Y153.488 E.02466
G1 X100.458 Y152.894 E.0317
G1 X100.458 Y153.548 E.02466
G1 X101.052 Y154.142 E.0317
G1 X101.052 Y154.797 E.02466
G1 X100.458 Y154.202 E.0317
G1 X100.458 Y154.856 E.02466
G1 X101.052 Y155.451 E.0317
G1 X101.052 Y156.105 E.02466
G1 X100.458 Y155.51 E.0317
G1 X100.458 Y156.165 E.02466
G1 X101.052 Y156.759 E.0317
G1 X101.052 Y157.414 E.02466
G1 X100.458 Y156.819 E.0317
G1 X100.458 Y157.473 E.02466
G1 X101.052 Y158.068 E.0317
G1 X101.052 Y158.722 E.02466
G1 X100.458 Y158.127 E.0317
G1 X100.458 Y158.781 E.02466
G1 X101.052 Y159.376 E.0317
G1 X101.052 Y160.03 E.02466
G1 X100.458 Y159.436 E.0317
G1 X100.458 Y160.09 E.02466
G1 X101.052 Y160.685 E.0317
G1 X101.052 Y161.339 E.02466
G1 X100.458 Y160.744 E.0317
G1 X100.458 Y161.398 E.02466
G1 X101.052 Y161.993 E.0317
G1 X101.052 Y162.647 E.02466
G1 X100.458 Y162.053 E.0317
G1 X100.458 Y162.707 E.02466
G1 X101.052 Y163.301 E.0317
G1 X101.052 Y163.956 E.02466
G1 X100.252 Y163.155 E.04267
; WIPE_START
G1 X101.052 Y163.956 E-.43013
G1 X101.052 Y163.301 E-.2486
G1 X100.901 Y163.15 E-.08127
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X105.473 Y157.038 Z.6 F30000
G1 X118.258 Y139.946 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X117.458 Y139.145 E.04267
G1 X117.458 Y139.8 E.02466
G1 X118.052 Y140.394 E.0317
G1 X118.052 Y141.049 E.02466
G1 X117.458 Y140.454 E.0317
G1 X117.458 Y141.108 E.02466
G1 X118.052 Y141.703 E.0317
G1 X118.052 Y142.357 E.02466
G1 X117.458 Y141.762 E.0317
G1 X117.458 Y142.416 E.02466
G1 X118.052 Y143.011 E.0317
G1 X118.052 Y143.665 E.02466
G1 X117.458 Y143.071 E.0317
G1 X117.458 Y143.725 E.02466
G1 X118.052 Y144.32 E.0317
G1 X118.052 Y144.974 E.02466
G1 X117.458 Y144.379 E.0317
G1 X117.458 Y145.033 E.02466
G1 X118.052 Y145.628 E.0317
G1 X118.052 Y146.282 E.02466
G1 X117.458 Y145.688 E.0317
G1 X117.458 Y146.342 E.02466
G1 X118.052 Y146.936 E.0317
G1 X118.052 Y147.591 E.02466
G1 X117.458 Y146.996 E.0317
G1 X117.458 Y147.65 E.02466
G1 X118.052 Y148.245 E.0317
G1 X118.052 Y148.899 E.02466
G1 X117.458 Y148.304 E.0317
G1 X117.458 Y148.959 E.02466
G1 X118.052 Y149.553 E.0317
G1 X118.052 Y150.208 E.02466
G1 X117.458 Y149.613 E.0317
G1 X117.458 Y150.267 E.02466
G1 X118.052 Y150.862 E.0317
G1 X118.052 Y151.516 E.02466
G1 X117.458 Y150.921 E.0317
G1 X117.458 Y151.575 E.02466
G1 X118.052 Y152.17 E.0317
G1 X118.052 Y152.824 E.02466
G1 X117.458 Y152.23 E.0317
M73 P27 R19
G1 X117.458 Y152.884 E.02466
G1 X118.052 Y153.479 E.0317
G1 X118.052 Y154.133 E.02466
G1 X117.458 Y153.538 E.0317
G1 X117.458 Y154.192 E.02466
G1 X118.052 Y154.787 E.0317
G1 X118.052 Y155.441 E.02466
G1 X117.458 Y154.847 E.0317
G1 X117.458 Y155.501 E.02466
G1 X118.052 Y156.095 E.0317
G1 X118.052 Y156.75 E.02466
G1 X117.458 Y156.155 E.0317
G1 X117.458 Y156.809 E.02466
G1 X118.052 Y157.404 E.0317
G1 X118.052 Y158.058 E.02466
G1 X117.458 Y157.463 E.0317
G1 X117.458 Y158.118 E.02466
G1 X118.052 Y158.712 E.0317
G1 X118.052 Y159.367 E.02466
G1 X117.458 Y158.772 E.0317
G1 X117.458 Y159.426 E.02466
G1 X118.052 Y160.021 E.0317
G1 X118.052 Y160.675 E.02466
G1 X117.458 Y160.08 E.0317
G1 X117.458 Y160.735 E.02466
G1 X118.052 Y161.329 E.0317
G1 X118.052 Y161.983 E.02466
G1 X117.458 Y161.389 E.0317
G1 X117.458 Y162.043 E.02466
G1 X118.052 Y162.638 E.0317
G1 X118.052 Y163.292 E.02466
G1 X117.458 Y162.697 E.0317
G1 X117.458 Y163.351 E.02466
G1 X118.052 Y163.946 E.0317
G1 X118.052 Y164.6 E.02466
G1 X117.458 Y164.006 E.0317
G1 X117.458 Y164.66 E.02466
G1 X118.052 Y165.254 E.0317
G1 X118.052 Y165.848 E.02237
G1 X117.991 Y165.848 E.00229
G1 X117.397 Y165.253 E.0317
G1 X116.742 Y165.253 E.02466
G1 X117.337 Y165.848 E.0317
G1 X116.683 Y165.848 E.02466
G1 X116.088 Y165.253 E.0317
G1 X115.434 Y165.253 E.02466
G1 X116.029 Y165.848 E.0317
G1 X115.374 Y165.848 E.02466
G1 X114.78 Y165.253 E.0317
G1 X114.126 Y165.253 E.02466
G1 X114.72 Y165.848 E.0317
G1 X114.066 Y165.848 E.02466
G1 X113.471 Y165.253 E.0317
G1 X112.817 Y165.253 E.02466
G1 X113.412 Y165.848 E.0317
G1 X112.758 Y165.848 E.02466
G1 X112.163 Y165.253 E.0317
G1 X111.509 Y165.253 E.02466
G1 X112.103 Y165.848 E.0317
G1 X111.449 Y165.848 E.02466
G1 X110.854 Y165.253 E.0317
G1 X110.2 Y165.253 E.02466
G1 X110.795 Y165.848 E.0317
G1 X110.141 Y165.848 E.02466
G1 X109.546 Y165.253 E.0317
G1 X108.892 Y165.253 E.02466
G1 X109.487 Y165.848 E.0317
G1 X108.832 Y165.848 E.02466
G1 X108.238 Y165.253 E.0317
G1 X107.583 Y165.253 E.02466
G1 X108.178 Y165.848 E.0317
G1 X107.524 Y165.848 E.02466
G1 X106.929 Y165.253 E.0317
G1 X106.275 Y165.253 E.02466
G1 X106.87 Y165.848 E.0317
G1 X106.215 Y165.848 E.02466
G1 X105.621 Y165.253 E.0317
G1 X104.967 Y165.253 E.02466
G1 X105.561 Y165.848 E.0317
G1 X104.907 Y165.848 E.02466
G1 X104.312 Y165.253 E.0317
G1 X103.658 Y165.253 E.02466
G1 X104.253 Y165.848 E.0317
G1 X103.599 Y165.848 E.02466
G1 X103.004 Y165.253 E.0317
G1 X102.35 Y165.253 E.02466
G1 X102.944 Y165.848 E.0317
G1 X102.29 Y165.848 E.02466
G1 X101.695 Y165.253 E.0317
G1 X101.052 Y165.253 E.02425
G1 X101.052 Y164.61 E.02425
G1 X100.458 Y164.015 E.0317
G1 X100.458 Y164.669 E.02466
G1 X101.636 Y165.848 E.06282
G1 X100.982 Y165.848 E.02466
G1 X100.252 Y165.118 E.03891
; OBJECT_ID: 214
; WIPE_START
G1 X100.982 Y165.848 E-.39227
G1 X101.636 Y165.848 E-.2486
G1 X101.414 Y165.626 E-.11913
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
M204 S6000
G1 X99.145 Y158.339 Z.6 F30000
G1 X94.441 Y143.233 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X94.441 Y147.062 E.14259
G1 X95.441 Y147.062 E.03725
G1 X95.441 Y162.833 E.58744
G1 X80.069 Y162.833 E.57254
G1 X80.069 Y141.462 E.79602
G1 X95.441 Y141.462 E.57254
G1 X95.441 Y143.233 E.06599
G1 X94.501 Y143.233 E.03501
M204 S6000
G1 X94.898 Y143.69 F30000
G1 F3000
M204 S500
G1 X94.898 Y146.604 E.10854
G1 X95.898 Y146.604 E.03725
G1 X95.898 Y163.29 E.62149
G1 X79.612 Y163.29 E.60659
G1 X79.612 Y141.004 E.83006
G1 X95.898 Y141.004 E.60659
G1 X95.898 Y143.69 E.10004
G1 X94.958 Y143.69 E.03501
M204 S6000
G1 X95.355 Y144.147 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X95.355 Y146.147 E.07449
G1 X96.355 Y146.147 E.03725
G1 X96.355 Y163.747 E.65553
G1 X79.155 Y163.747 E.64064
G1 X79.155 Y140.547 E.86411
G1 X96.355 Y140.547 E.64064
G1 X96.355 Y144.147 E.13409
G1 X95.415 Y144.147 E.03501
; WIPE_START
G1 X95.355 Y146.146 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X94.319 Y141.644 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50708
M73 P28 R19
G1 F6300
M204 S500
G1 X95.052 Y142.378 E.03923
G1 X95.052 Y142.845 E.01767
G1 X94.863 Y142.845 E.00716
G1 X93.868 Y141.85 E.05321
G1 X93.212 Y141.85 E.02483
G1 X94.206 Y142.845 E.05321
G1 X94.052 Y142.845 E.00583
G1 X94.052 Y143.347 E.01899
G1 X92.555 Y141.85 E.08007
G1 X91.899 Y141.85 E.02483
G1 X94.052 Y144.003 E.11518
G1 X94.052 Y144.66 E.02483
G1 X91.243 Y141.85 E.15029
G1 X90.586 Y141.85 E.02483
G1 X94.052 Y145.316 E.18541
G1 X94.052 Y145.973 E.02483
G1 X89.93 Y141.85 E.22052
G1 X89.273 Y141.85 E.02483
G1 X94.258 Y146.835 E.26663
M204 S6000
G1 X94.668 Y147.244 F30000
G1 F6300
M204 S500
G1 X95.052 Y147.629 E.02058
G1 X95.052 Y148.285 E.02483
G1 X88.617 Y141.85 E.34423
G1 X87.96 Y141.85 E.02483
G1 X95.052 Y148.942 E.37934
G1 X95.052 Y149.598 E.02483
G1 X87.304 Y141.85 E.41446
G1 X86.648 Y141.85 E.02483
G1 X95.052 Y150.255 E.44957
G1 X95.052 Y150.911 E.02483
G1 X85.991 Y141.85 E.48468
G1 X85.335 Y141.85 E.02483
G1 X95.052 Y151.568 E.51979
G1 X95.052 Y152.224 E.02483
G1 X84.678 Y141.85 E.5549
G1 X84.022 Y141.85 E.02483
G1 X95.052 Y152.88 E.59001
G1 X95.052 Y153.537 E.02483
G1 X83.365 Y141.85 E.62513
G1 X82.709 Y141.85 E.02483
G1 X95.052 Y154.193 E.66024
G1 X95.052 Y154.85 E.02483
G1 X82.053 Y141.85 E.69535
G1 X81.396 Y141.85 E.02483
G1 X95.052 Y155.506 E.73046
G1 X95.052 Y156.163 E.02483
G1 X80.74 Y141.85 E.76557
G1 X80.458 Y141.85 E.01068
G1 X80.458 Y142.224 E.01415
G1 X95.052 Y156.819 E.78067
G1 X95.052 Y157.475 E.02483
G1 X80.458 Y142.881 E.78067
G1 X80.458 Y143.537 E.02483
G1 X95.052 Y158.132 E.78067
G1 X95.052 Y158.788 E.02483
G1 X80.458 Y144.193 E.78067
G1 X80.458 Y144.85 E.02483
G1 X95.052 Y159.445 E.78067
G1 X95.052 Y160.101 E.02483
G1 X80.458 Y145.506 E.78067
G1 X80.458 Y146.163 E.02483
G1 X95.052 Y160.757 E.78067
G1 X95.052 Y161.414 E.02483
G1 X80.458 Y146.819 E.78067
G1 X80.458 Y147.476 E.02483
G1 X95.052 Y162.07 E.78067
G1 X95.052 Y162.445 E.01416
G1 X94.77 Y162.445 E.01067
G1 X80.458 Y148.132 E.76559
G1 X80.458 Y148.788 E.02483
G1 X94.114 Y162.445 E.73048
G1 X93.457 Y162.445 E.02483
G1 X80.458 Y149.445 E.69536
G1 X80.458 Y150.101 E.02483
G1 X92.801 Y162.445 E.66025
G1 X92.145 Y162.445 E.02483
G1 X80.458 Y150.758 E.62514
G1 X80.458 Y151.414 E.02483
G1 X91.488 Y162.445 E.59003
G1 X90.832 Y162.445 E.02483
G1 X80.458 Y152.071 E.55492
G1 X80.458 Y152.727 E.02483
G1 X90.175 Y162.445 E.5198
G1 X89.519 Y162.445 E.02483
G1 X80.458 Y153.383 E.48469
G1 X80.458 Y154.04 E.02483
G1 X88.862 Y162.445 E.44958
G1 X88.206 Y162.445 E.02483
G1 X80.458 Y154.696 E.41447
G1 X80.458 Y155.353 E.02483
G1 X87.55 Y162.445 E.37936
G1 X86.893 Y162.445 E.02483
G1 X80.458 Y156.009 E.34424
G1 X80.458 Y156.665 E.02483
G1 X86.237 Y162.445 E.30913
G1 X85.58 Y162.445 E.02483
G1 X80.458 Y157.322 E.27402
G1 X80.458 Y157.978 E.02483
G1 X84.924 Y162.445 E.23891
G1 X84.268 Y162.445 E.02483
G1 X80.458 Y158.635 E.2038
G1 X80.458 Y159.291 E.02483
G1 X83.611 Y162.445 E.16868
G1 X82.955 Y162.445 E.02483
G1 X80.458 Y159.948 E.13357
G1 X80.458 Y160.604 E.02483
G1 X82.298 Y162.445 E.09846
G1 X81.642 Y162.445 E.02483
G1 X80.458 Y161.26 E.06335
G1 X80.458 Y161.917 E.02483
G1 X81.191 Y162.65 E.03924
; OBJECT_ID: 236
; WIPE_START
G1 X80.458 Y161.917 E-.39422
G1 X80.458 Y161.26 E-.24944
G1 X80.674 Y161.477 E-.11634
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
M204 S6000
G1 X83.025 Y154.216 Z.6 F30000
M73 P29 R19
G1 X95.881 Y114.504 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X97.093 Y115.716 E.06384
G1 X98.588 Y117.211 E.07874
G1 X99.295 Y116.504 E.03725
G1 X106.205 Y123.413 E.36396
G1 X95.336 Y134.283 E.57254
G1 X80.224 Y119.171 E.79601
G1 X91.093 Y108.301 E.57254
G1 X92.346 Y109.554 E.06599
G1 X91.639 Y110.261 E.03725
G1 X95.839 Y114.461 E.22124
M204 S6000
G1 X96.528 Y114.504 F30000
G1 F3000
M204 S500
G1 X97.417 Y115.393 E.04682
G1 X98.588 Y116.564 E.06172
G1 X99.295 Y115.857 E.03725
G1 X106.851 Y123.413 E.39801
G1 X95.336 Y134.929 E.60659
G1 X79.577 Y119.171 E.83006
G1 X91.093 Y107.655 E.60659
G1 X92.992 Y109.554 E.10004
G1 X92.285 Y110.261 E.03725
G1 X96.485 Y114.461 E.22124
M204 S6000
G1 X97.174 Y114.504 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X97.74 Y115.07 E.0298
G1 X98.588 Y115.918 E.0447
G1 X99.295 Y115.211 E.03725
G1 X107.498 Y123.413 E.43206
G1 X95.336 Y135.576 E.64063
G1 X78.931 Y119.171 E.86411
G1 X91.093 Y107.009 E.64063
G1 X93.23 Y109.146 E.11257
G1 X93.639 Y109.554 E.02152
G1 X92.931 Y110.261 E.03725
G1 X94.346 Y111.675 E.07449
G1 X95.053 Y110.968 E.03725
G1 X95.76 Y111.675 E.03725
G1 X95.053 Y112.383 E.03725
G1 X96.467 Y113.797 E.07449
G1 X97.174 Y113.09 E.03725
G1 X97.881 Y113.797 E.03725
G1 X97.217 Y114.461 E.03501
; WIPE_START
G1 X97.74 Y115.07 E-.30485
G1 X98.587 Y115.917 E-.45515
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X99.145 Y116.912 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51328
G1 F6300
M204 S500
G1 X105.651 Y123.418 E.35264
G1 X105.318 Y123.751 E.01803
G1 X98.813 Y117.245 E.35264
; WIPE_START
G1 X100.227 Y118.659 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X95.042 Y113.058 Z.6 F30000
G1 X91.937 Y109.704 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X91.088 Y108.855 E.04601
G1 X90.756 Y109.188 E.01803
G1 X91.604 Y110.037 E.04601
; WIPE_START
G1 X90.756 Y109.188 E-.45614
G1 X91.088 Y108.855 E-.17874
G1 X91.321 Y109.088 E-.12512
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X90.278 Y109.375 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X104.986 Y124.083 E.79724
G1 X104.653 Y124.416 E.01803
G1 X90.09 Y109.853 E.78936
G1 X89.758 Y110.186 E.01803
G1 X104.321 Y124.749 E.78936
G1 X103.988 Y125.081 E.01803
G1 X89.425 Y110.518 E.78936
G1 X89.093 Y110.851 E.01803
G1 X103.655 Y125.414 E.78936
G1 X103.323 Y125.746 E.01803
G1 X88.76 Y111.184 E.78936
G1 X88.428 Y111.516 E.01803
G1 X102.99 Y126.079 E.78936
G1 X102.658 Y126.411 E.01803
G1 X88.095 Y111.849 E.78936
G1 X87.762 Y112.181 E.01803
G1 X102.325 Y126.744 E.78936
G1 X101.992 Y127.077 E.01803
G1 X87.43 Y112.514 E.78936
G1 X87.097 Y112.847 E.01803
G1 X101.66 Y127.409 E.78936
G1 X101.327 Y127.742 E.01803
G1 X86.765 Y113.179 E.78936
G1 X86.432 Y113.512 E.01803
G1 X100.995 Y128.074 E.78936
G1 X100.662 Y128.407 E.01803
G1 X86.099 Y113.844 E.78936
G1 X85.767 Y114.177 E.01803
G1 X100.329 Y128.74 E.78936
G1 X99.997 Y129.072 E.01803
G1 X85.434 Y114.51 E.78936
G1 X85.102 Y114.842 E.01803
G1 X99.664 Y129.405 E.78936
G1 X99.332 Y129.737 E.01803
G1 X84.769 Y115.175 E.78936
G1 X84.436 Y115.507 E.01803
G1 X98.999 Y130.07 E.78936
G1 X98.666 Y130.403 E.01803
G1 X84.104 Y115.84 E.78936
G1 X83.771 Y116.173 E.01803
G1 X98.334 Y130.735 E.78936
G1 X98.001 Y131.068 E.01803
G1 X83.439 Y116.505 E.78936
G1 X83.106 Y116.838 E.01803
G1 X97.669 Y131.4 E.78936
G1 X97.336 Y131.733 E.01803
G1 X82.773 Y117.17 E.78936
G1 X82.441 Y117.503 E.01803
G1 X97.003 Y132.066 E.78936
G1 X96.671 Y132.398 E.01803
G1 X82.108 Y117.836 E.78936
G1 X81.776 Y118.168 E.01803
G1 X96.338 Y132.731 E.78936
G1 X96.006 Y133.063 E.01803
G1 X81.443 Y118.501 E.78936
G1 X81.11 Y118.833 E.01803
G1 X95.673 Y133.396 E.78936
G1 X95.34 Y133.729 E.01803
G1 X80.632 Y119.02 E.79724
; OBJECT_ID: 181
; WIPE_START
M73 P30 R19
G1 X82.047 Y120.435 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
M204 S6000
G1 X89.679 Y120.39 Z.6 F30000
G1 X130.818 Y120.147 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X121.444 Y129.521 E.49378
G1 X103.969 Y112.045 E.92051
G1 X112.709 Y103.304 E.46042
G1 X113.666 Y102.348 E.05038
G1 X131.141 Y119.823 E.92051
G1 X130.861 Y120.104 E.01479
M204 S6000
G1 X130.495 Y119.823 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X121.444 Y128.874 E.47675
G1 X104.615 Y112.045 E.88646
G1 X113.033 Y103.628 E.44339
G1 X113.666 Y102.994 E.03336
G1 X130.453 Y119.781 E.88422
; WIPE_START
G1 X129.045 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X121.894 Y118.534 Z.6 F30000
G1 X102.231 Y111.197 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X113.666 Y99.762 E.60233
G1 X133.728 Y119.823 E1.05674
G1 X121.444 Y132.107 E.64703
G1 X103.645 Y114.308 E.93755
G1 X104.615 Y113.338 E.05109
G1 X121.444 Y130.167 E.88646
G1 X131.788 Y119.823 E.54485
G1 X113.666 Y101.701 E.95456
G1 X103.201 Y112.167 E.55124
G1 X102.273 Y111.239 E.04886
M204 S6000
G1 X101.787 Y111.399 F30000
G1 F3000
M204 S500
G1 X100.938 Y112.247 E.0447
G1 X100.736 Y112.045 E.01065
G1 X113.666 Y99.115 E.68108
G1 X134.374 Y119.823 E1.09079
G1 X121.444 Y132.753 E.68108
G1 X102.999 Y114.308 E.9716
G1 X103.847 Y113.459 E.0447
G1 X101.829 Y111.441 E.1063
M204 S6000
G1 X101.787 Y112.045 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X100.938 Y112.894 E.0447
G1 X100.089 Y112.045 E.0447
G1 X113.666 Y98.469 E.71513
G1 X135.021 Y119.823 E1.12484
G1 X121.444 Y133.4 E.71513
G1 X102.352 Y114.308 E1.00565
G1 X103.201 Y113.459 E.0447
G1 X101.829 Y112.088 E.07226
; WIPE_START
G1 X100.938 Y112.894 E-.45658
G1 X100.373 Y112.329 E-.30342
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X103.423 Y112.268 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.671716
G1 F3000
M204 S500
G1 X104.393 Y113.237 E.07025
; WIPE_START
G1 X103.423 Y112.268 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X110.814 Y114.172 Z.6 F30000
G1 X133.322 Y119.97 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50377
G1 F6300
M204 S500
G1 X113.665 Y100.312 E1.044
G1 X113.339 Y100.638 E.01731
G1 X132.851 Y120.151 E1.03628
G1 X132.525 Y120.477 E.01731
G1 X132.105 Y120.056 E.02233
G1 X132.337 Y119.823 E.01235
G1 X113.666 Y101.152 E.99161
G1 X113.433 Y101.385 E.01235
G1 X113.013 Y100.964 E.02233
G1 X112.687 Y101.29 E.01731
M73 P31 R19
G1 X113.107 Y101.711 E.02233
G1 X112.782 Y102.036 E.01731
G1 X112.361 Y101.616 E.02233
G1 X112.035 Y101.942 E.01731
G1 X112.456 Y102.362 E.02233
G1 X112.13 Y102.688 E.01731
G1 X111.709 Y102.268 E.02233
G1 X111.383 Y102.594 E.01731
G1 X111.804 Y103.014 E.02233
G1 X111.478 Y103.34 E.01731
G1 X111.058 Y102.919 E.02233
G1 X110.732 Y103.245 E.01731
G1 X111.152 Y103.666 E.02233
M73 P31 R18
G1 X110.826 Y103.992 E.01731
G1 X110.406 Y103.571 E.02233
G1 X110.08 Y103.897 E.01731
G1 X110.5 Y104.317 E.02233
G1 X110.175 Y104.643 E.01731
G1 X109.754 Y104.223 E.02233
G1 X109.428 Y104.549 E.01731
G1 X109.849 Y104.969 E.02233
G1 X109.523 Y105.295 E.01731
G1 X109.102 Y104.875 E.02233
G1 X108.776 Y105.2 E.01731
G1 X109.197 Y105.621 E.02233
G1 X108.871 Y105.947 E.01731
G1 X108.451 Y105.526 E.02233
G1 X108.125 Y105.852 E.01731
G1 X108.545 Y106.273 E.02233
G1 X108.219 Y106.599 E.01731
G1 X107.799 Y106.178 E.02233
G1 X107.473 Y106.504 E.01731
G1 X107.894 Y106.924 E.02233
G1 X107.568 Y107.25 E.01731
G1 X107.147 Y106.83 E.02233
G1 X106.821 Y107.156 E.01731
G1 X107.242 Y107.576 E.02233
G1 X106.916 Y107.902 E.01731
G1 X106.495 Y107.482 E.02233
G1 X106.17 Y107.807 E.01731
G1 X106.59 Y108.228 E.02233
G1 X106.264 Y108.554 E.01731
G1 X105.844 Y108.133 E.02233
G1 X105.518 Y108.459 E.01731
G1 X105.938 Y108.88 E.02233
G1 X105.612 Y109.206 E.01731
G1 X105.192 Y108.785 E.02233
G1 X104.866 Y109.111 E.01731
G1 X105.287 Y109.531 E.02233
G1 X104.961 Y109.857 E.01731
G1 X104.54 Y109.437 E.02233
G1 X104.214 Y109.763 E.01731
G1 X104.635 Y110.183 E.02233
G1 X104.309 Y110.509 E.01731
G1 X103.888 Y110.089 E.02233
G1 X103.563 Y110.414 E.01731
G1 X103.983 Y110.835 E.02233
G1 X103.657 Y111.161 E.01731
G1 X103.237 Y110.74 E.02233
G1 X102.911 Y111.066 E.01731
G1 X103.477 Y111.632 E.03006
; WIPE_START
G1 X102.911 Y111.066 E-.30415
G1 X103.237 Y110.74 E-.17512
G1 X103.657 Y111.161 E-.22599
G1 X103.759 Y111.059 E-.05474
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X110.972 Y113.554 Z.6 F30000
G1 X132.345 Y120.948 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X131.779 Y120.382 E.03006
G1 X131.453 Y120.708 E.01731
G1 X131.873 Y121.128 E.02233
G1 X131.548 Y121.454 E.01731
G1 X131.127 Y121.034 E.02233
G1 X130.801 Y121.36 E.01731
G1 X131.222 Y121.78 E.02233
G1 X130.896 Y122.106 E.01731
G1 X130.475 Y121.685 E.02233
G1 X130.149 Y122.011 E.01731
G1 X130.57 Y122.432 E.02233
G1 X130.244 Y122.758 E.01731
G1 X129.824 Y122.337 E.02233
G1 X129.498 Y122.663 E.01731
G1 X129.918 Y123.084 E.02233
G1 X129.592 Y123.409 E.01731
G1 X129.172 Y122.989 E.02233
G1 X128.846 Y123.315 E.01731
G1 X129.266 Y123.735 E.02233
G1 X128.941 Y124.061 E.01731
G1 X128.52 Y123.641 E.02233
G1 X128.194 Y123.966 E.01731
G1 X128.615 Y124.387 E.02233
G1 X128.289 Y124.713 E.01731
G1 X127.868 Y124.292 E.02233
G1 X127.542 Y124.618 E.01731
G1 X127.963 Y125.039 E.02233
G1 X127.637 Y125.365 E.01731
G1 X127.217 Y124.944 E.02233
G1 X126.891 Y125.27 E.01731
G1 X127.311 Y125.69 E.02233
G1 X126.985 Y126.016 E.01731
G1 X126.565 Y125.596 E.02233
G1 X126.239 Y125.922 E.01731
G1 X126.66 Y126.342 E.02233
G1 X126.334 Y126.668 E.01731
G1 X125.913 Y126.248 E.02233
G1 X125.587 Y126.573 E.01731
G1 X126.008 Y126.994 E.02233
G1 X125.682 Y127.32 E.01731
G1 X125.261 Y126.899 E.02233
G1 X124.936 Y127.225 E.01731
G1 X125.356 Y127.646 E.02233
G1 X125.03 Y127.972 E.01731
G1 X124.61 Y127.551 E.02233
G1 X124.284 Y127.877 E.01731
G1 X124.704 Y128.297 E.02233
G1 X124.378 Y128.623 E.01731
G1 X123.958 Y128.203 E.02233
G1 X123.632 Y128.529 E.01731
G1 X124.053 Y128.949 E.02233
G1 X123.727 Y129.275 E.01731
G1 X123.306 Y128.855 E.02233
G1 X122.98 Y129.18 E.01731
G1 X123.401 Y129.601 E.02233
G1 X123.075 Y129.927 E.01731
G1 X122.654 Y129.506 E.02233
G1 X122.329 Y129.832 E.01731
G1 X122.749 Y130.253 E.02233
G1 X122.423 Y130.579 E.01731
G1 X122.003 Y130.158 E.02233
G1 X121.677 Y130.484 E.01731
G1 X122.097 Y130.904 E.02233
G1 X121.771 Y131.23 E.01731
G1 X104.522 Y113.981 E.91611
G1 X104.196 Y114.306 E.01731
G1 X121.591 Y131.702 E.92383
; OBJECT_ID: 247
; WIPE_START
G1 X120.177 Y130.287 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
M204 S6000
G1 X123.021 Y123.205 Z.6 F30000
G1 X135.163 Y92.974 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X124.293 Y103.844 E.57254
G1 X109.181 Y88.732 E.79601
G1 X120.051 Y77.862 E.57254
G1 X135.12 Y92.932 E.79378
M204 S6000
G1 X135.809 Y92.974 F30000
G1 F3000
M204 S500
G1 X124.293 Y104.49 E.60659
G1 X108.535 Y88.732 E.83006
G1 X120.051 Y77.216 E.60659
G1 X135.767 Y92.932 E.82783
M204 S6000
G1 X136.456 Y92.974 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X124.293 Y105.136 E.64063
G1 X107.888 Y88.732 E.86411
G1 X120.051 Y76.569 E.64063
G1 X136.413 Y92.932 E.86188
; WIPE_START
G1 X135.004 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X129.778 Y88.788 Z.6 F30000
G1 X119.9 Y78.271 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51328
G1 F6300
M204 S500
G1 X134.609 Y92.979 E.79724
G1 X134.276 Y93.312 E.01803
G1 X119.713 Y78.749 E.78936
G1 X119.381 Y79.081 E.01803
G1 X133.943 Y93.644 E.78936
G1 X133.611 Y93.977 E.01803
G1 X119.048 Y79.414 E.78936
G1 X118.716 Y79.747 E.01803
G1 X133.278 Y94.309 E.78936
G1 X132.946 Y94.642 E.01803
G1 X118.383 Y80.079 E.78936
G1 X118.05 Y80.412 E.01803
G1 X132.613 Y94.975 E.78936
G1 X132.28 Y95.307 E.01803
G1 X117.718 Y80.744 E.78936
G1 X117.385 Y81.077 E.01803
G1 X131.948 Y95.64 E.78936
G1 X131.615 Y95.972 E.01803
G1 X117.053 Y81.41 E.78936
G1 X116.72 Y81.742 E.01803
G1 X131.283 Y96.305 E.78936
G1 X130.95 Y96.637 E.01803
G1 X116.387 Y82.075 E.78936
G1 X116.055 Y82.407 E.01803
G1 X130.617 Y96.97 E.78936
G1 X130.285 Y97.303 E.01803
G1 X115.722 Y82.74 E.78936
G1 X115.39 Y83.073 E.01803
G1 X129.952 Y97.635 E.78936
G1 X129.62 Y97.968 E.01803
M73 P32 R18
G1 X115.057 Y83.405 E.78936
G1 X114.724 Y83.738 E.01803
G1 X129.287 Y98.3 E.78936
G1 X128.954 Y98.633 E.01803
G1 X114.392 Y84.07 E.78936
G1 X114.059 Y84.403 E.01803
G1 X128.622 Y98.966 E.78936
G1 X128.289 Y99.298 E.01803
G1 X113.727 Y84.736 E.78936
G1 X113.394 Y85.068 E.01803
G1 X127.957 Y99.631 E.78936
G1 X127.624 Y99.963 E.01803
G1 X113.061 Y85.401 E.78936
G1 X112.729 Y85.733 E.01803
G1 X127.291 Y100.296 E.78936
G1 X126.959 Y100.629 E.01803
G1 X112.396 Y86.066 E.78936
G1 X112.064 Y86.399 E.01803
G1 X126.626 Y100.961 E.78936
G1 X126.294 Y101.294 E.01803
G1 X111.731 Y86.731 E.78936
G1 X111.398 Y87.064 E.01803
G1 X125.961 Y101.626 E.78936
G1 X125.628 Y101.959 E.01803
G1 X111.066 Y87.396 E.78936
G1 X110.733 Y87.729 E.01803
G1 X125.296 Y102.292 E.78936
G1 X124.963 Y102.624 E.01803
G1 X110.401 Y88.062 E.78936
G1 X110.068 Y88.394 E.01803
G1 X124.631 Y102.957 E.78936
G1 X124.298 Y103.289 E.01803
G1 X109.59 Y88.581 E.79724
; OBJECT_ID: 258
; WIPE_START
G1 X111.004 Y89.996 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
M204 S6000
G1 X106.053 Y95.804 Z.6 F30000
G1 X100.208 Y102.659 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X100.15 Y102.62 E.00259
G3 X101.27 Y97.023 I1.509 J-2.609 E.27922
G1 X101.654 Y96.998 E.01436
G3 X100.495 Y102.791 I.005 J3.014 E.39733
G1 X100.263 Y102.684 E.00951
M204 S6000
G1 X100.41 Y102.249 F30000
G1 F3000
M204 S500
G1 X100.379 Y102.225 E.00149
G3 X101.329 Y97.478 I1.28 J-2.212 E.23683
G1 X101.654 Y97.456 E.01216
G3 X100.67 Y102.369 I.004 J2.556 E.33705
G1 X100.465 Y102.274 E.00843
M204 S6000
G1 X100.613 Y101.839 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X100.607 Y101.829 E.00042
G3 X101.388 Y97.932 I1.051 J-1.816 E.19444
G1 X101.654 Y97.914 E.00996
G3 X100.846 Y101.948 I.004 J2.098 E.27676
G1 X100.667 Y101.864 E.00735
; WIPE_START
G1 X100.607 Y101.829 E-.02642
G1 X100.375 Y101.682 E-.10427
G1 X100.169 Y101.501 E-.10446
G1 X99.988 Y101.294 E-.10438
G1 X99.835 Y101.066 E-.10443
G1 X99.713 Y100.819 E-.10442
G1 X99.625 Y100.559 E-.10441
G1 X99.571 Y100.289 E-.10473
G1 X99.571 Y100.282 E-.00247
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X97.517 Y93.626 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X97.498 Y93.723 E.00368
G3 X94.199 Y89.952 I-2.91 J-.782 E.48496
G1 X94.583 Y89.927 E.01435
G3 X97.576 Y93.329 I.004 J3.014 E.19097
G1 X97.529 Y93.567 E.00904
M204 S6000
G1 X97.069 Y93.538 F30000
M73 P33 R18
G1 F3000
M204 S500
G1 X97.056 Y93.605 E.00253
G3 X94.258 Y90.407 I-2.468 J-.664 E.41132
G1 X94.583 Y90.385 E.01215
G3 X97.122 Y93.27 I.004 J2.556 E.16197
G1 X97.08 Y93.48 E.00796
M204 S6000
G1 X96.62 Y93.451 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X96.613 Y93.487 E.00138
G3 X94.317 Y90.861 I-2.026 J-.546 E.33767
G1 X94.583 Y90.843 E.00996
G3 X96.668 Y93.211 I.004 J2.098 E.13297
G1 X96.632 Y93.392 E.00688
; WIPE_START
G1 X96.613 Y93.487 E-.03685
G1 X96.524 Y93.748 E-.10472
G1 X96.403 Y93.995 E-.10443
G1 X96.25 Y94.223 E-.10442
G1 X96.069 Y94.43 E-.10439
G1 X95.862 Y94.611 E-.10446
G1 X95.634 Y94.764 E-.10442
G1 X95.406 Y94.876 E-.09631
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X102.738 Y96.997 Z.6 F30000
G1 X108.281 Y98.601 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X100.24 Y106.642 E.42355
G1 X87.956 Y94.358 E.64703
G1 X95.998 Y86.317 E.42355
G1 X97.502 Y87.822 E.07924
G1 X108.239 Y98.559 E.56555
M204 S6000
G1 X108.928 Y98.601 F30000
G1 F3000
M204 S500
G1 X100.24 Y107.288 E.4576
G1 X87.31 Y94.358 E.68108
G1 X95.998 Y85.671 E.4576
G1 X97.825 Y87.499 E.09627
G1 X108.885 Y98.559 E.58258
M204 S6000
G1 X109.574 Y98.601 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X100.24 Y107.935 E.49165
G1 X86.664 Y94.358 E.71513
G1 X95.998 Y85.025 E.49165
G1 X98.148 Y87.175 E.11329
G1 X109.532 Y98.559 E.5996
; WIPE_START
G1 X108.124 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X107.876 Y98.748 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5034
G1 F6300
M204 S500
G1 X95.996 Y86.868 E.63041
G1 X95.671 Y87.194 E.01728
G1 X107.405 Y98.928 E.62269
G1 X107.079 Y99.253 E.01728
G1 X95.345 Y87.519 E.62269
G1 X95.019 Y87.845 E.01728
G1 X106.754 Y99.579 E.62269
G1 X106.428 Y99.905 E.01728
G1 X94.694 Y88.17 E.62269
G1 X94.368 Y88.496 E.01728
G1 X95.557 Y89.685 E.06311
G3 X97.842 Y91.97 I-.943 J3.228 E.12646
G1 X102.629 Y96.756 E.254
G3 X104.913 Y99.041 I-.943 J3.228 E.12646
G1 X106.102 Y100.23 E.06311
G1 X105.777 Y100.556 E.01728
G1 X105.048 Y99.827 E.03866
G3 X105.031 Y100.461 I-5.23 J.176 E.02382
G1 X105.597 Y101.027 E.03001
; WIPE_START
G1 X105.031 Y100.461 E-.30388
G1 X105.061 Y100.015 E-.16995
G1 X105.048 Y99.827 E-.07152
G1 X105.448 Y100.227 E-.21464
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X102.666 Y103.957 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X102.101 Y103.392 E.02999
G3 X101.467 Y103.409 I-.382 J-2.404 E.02388
G1 X102.341 Y104.283 E.04637
; WIPE_START
G1 X101.467 Y103.409 E-.4696
G1 X101.654 Y103.421 E-.07143
G1 X102.101 Y103.392 E-.1701
G1 X102.192 Y103.483 E-.04886
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X102.063 Y96.842 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X97.977 Y92.756 E.2168
G3 X97.959 Y93.389 I-4.762 J.18 E.02378
G1 X101.209 Y96.639 E.17247
G1 X100.676 Y96.758 E.02048
G1 X97.841 Y93.922 E.15047
G3 X97.659 Y94.392 I-1.876 J-.455 E.01895
G1 X100.207 Y96.939 E.13518
G2 X99.789 Y97.173 I.68 J1.701 E.018
G1 X97.425 Y94.809 E.12546
G3 X97.144 Y95.179 I-1.548 J-.883 E.01749
G1 X99.419 Y97.454 E.12073
G2 X99.094 Y97.78 I1.074 J1.399 E.01733
G1 X96.818 Y95.505 E.12073
G3 X96.448 Y95.786 I-1.253 J-1.265 E.01749
G1 X98.813 Y98.15 E.12546
G2 X98.579 Y98.567 I1.467 J1.098 E.018
G1 X96.031 Y96.02 E.13518
G3 X95.562 Y96.202 I-.925 J-1.693 E.01895
G1 X98.397 Y99.037 E.15046
G1 X98.278 Y99.569 E.02045
G1 X95.03 Y96.321 E.17234
G3 X94.396 Y96.338 I-.382 J-2.4 E.02388
G1 X98.481 Y100.423 E.21677
; WIPE_START
G1 X97.066 Y99.009 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X95.394 Y91.562 Z.6 F30000
G1 X94.992 Y89.771 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X94.043 Y88.822 E.05036
G1 X93.717 Y89.147 E.01728
G1 X94.33 Y89.761 E.03254
; WIPE_START
G1 X93.717 Y89.147 E-.32958
G1 X94.043 Y88.822 E-.17498
G1 X94.518 Y89.297 E-.25544
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X91.4 Y92.691 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X90.787 Y92.078 E.03254
G1 X90.461 Y92.403 E.01728
G1 X91.41 Y93.352 E.05036
; WIPE_START
G1 X90.461 Y92.403 E-.50997
G1 X90.787 Y92.078 E-.17498
G1 X90.926 Y92.217 E-.07505
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X89.99 Y92.584 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X91.324 Y93.918 E.07082
G2 X93.61 Y96.203 I3.228 J-.943 E.12649
G1 X98.396 Y100.989 E.25397
G2 X100.681 Y103.274 I3.228 J-.943 E.12649
G1 X101.87 Y104.463 E.06309
G1 X101.544 Y104.789 E.01728
G1 X89.81 Y93.055 E.62269
G1 X89.484 Y93.38 E.01728
G1 X101.218 Y105.114 E.62269
G1 X100.893 Y105.44 E.01728
G1 X89.158 Y93.706 E.62269
G1 X88.833 Y94.031 E.01728
G1 X100.567 Y105.766 E.62269
G1 X100.241 Y106.091 E.01728
G1 X88.362 Y94.212 E.63041
; WIPE_START
G1 X89.776 Y95.626 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X91.508 Y91.887 Z.6 F30000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.408106
G1 F3000
M204 S500
G1 X91.411 Y91.616 E.00856
; LINE_WIDTH: 0.476112
G1 X91.395 Y91.567 E.00182
G1 X91.471 Y91.461 E.00462
; LINE_WIDTH: 0.43759
G1 X91.548 Y91.354 E.00421
; LINE_WIDTH: 0.394951
G1 X91.624 Y91.248 E.00376
; LINE_WIDTH: 0.349108
G3 X91.773 Y91.065 I2.87 J2.189 E.0059
; LINE_WIDTH: 0.304819
G1 X91.91 Y90.899 E.00458
; LINE_WIDTH: 0.268602
G3 X92.528 Y90.279 I7.495 J6.864 E.01612
; LINE_WIDTH: 0.303762
G3 X92.705 Y90.133 I2.325 J2.64 E.00487
; LINE_WIDTH: 0.347069
G1 X92.87 Y89.998 E.00529
; LINE_WIDTH: 0.391533
G1 X92.994 Y89.908 E.00434
; LINE_WIDTH: 0.437639
G1 X93.1 Y89.832 E.00421
; LINE_WIDTH: 0.480318
G1 X93.207 Y89.756 E.00467
; LINE_WIDTH: 0.483773
G1 X93.231 Y89.764 E.00092
; LINE_WIDTH: 0.448025
G1 X93.255 Y89.772 E.00085
; LINE_WIDTH: 0.408432
G1 X93.526 Y89.868 E.00857
; WIPE_START
G1 X93.255 Y89.772 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X98.694 Y95.127 Z.6 F30000
G1 X104.73 Y101.072 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.407908
G1 F3000
M204 S500
G1 X104.827 Y101.343 E.00855
; LINE_WIDTH: 0.447545
G1 X104.835 Y101.367 E.00085
; LINE_WIDTH: 0.483568
G1 X104.842 Y101.392 E.00093
; LINE_WIDTH: 0.480256
G1 X104.766 Y101.499 E.00466
; LINE_WIDTH: 0.43761
G1 X104.69 Y101.605 E.00421
; LINE_WIDTH: 0.391534
G1 X104.601 Y101.729 E.00433
; LINE_WIDTH: 0.347074
G1 X104.465 Y101.893 E.00529
; LINE_WIDTH: 0.303751
G3 X104.32 Y102.07 I-2.779 J-2.142 E.00487
; LINE_WIDTH: 0.268448
G3 X103.698 Y102.691 I-7.248 J-6.643 E.01615
; LINE_WIDTH: 0.305244
G1 X103.533 Y102.826 E.00456
; LINE_WIDTH: 0.349247
G3 X103.351 Y102.975 I-2.364 J-2.712 E.00587
; LINE_WIDTH: 0.39486
G1 X103.245 Y103.051 E.00374
; LINE_WIDTH: 0.437347
G1 X103.139 Y103.127 E.00419
; LINE_WIDTH: 0.475148
G1 X103.033 Y103.202 E.00459
G1 X102.981 Y103.186 E.00189
; LINE_WIDTH: 0.405032
M73 P34 R18
G1 X102.712 Y103.09 E.00843
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X102.981 Y103.186 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 2/30
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S163.2
M106 P2 S178
; open powerlost recovery
M1003 S1
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I.636 J1.038 P1  F30000
G1 X145.197 Y77.326 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X145.197 Y78.125 E.02651
G1 X151.416 Y78.125 E.20627
G1 X151.416 Y77.125 E.03317
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.266 E.00467
G1 X145.604 Y77.326 F30000
G1 F8843.478
G1 X145.604 Y77.718 E.01301
G1 X148.009 Y77.718 E.07975
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.266 E.01818
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
; WIPE_START
M204 S10000
G1 X147.616 Y77.326 E-.61602
G1 X147.616 Y76.947 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X143.743 Y77.289 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X143.149 Y77.883 E.02584
G1 X143.149 Y78.417 E.01643
G1 X144.107 Y77.459 E.0417
G1 X144.641 Y77.459 E.01643
G1 X143.149 Y78.951 E.06494
G1 X143.149 Y79.485 E.01643
G1 X144.864 Y77.77 E.07465
G1 X144.864 Y78.304 E.01643
G1 X143.149 Y80.019 E.07464
G1 X143.149 Y80.553 E.01643
G1 X145.243 Y78.459 E.09115
G1 X145.777 Y78.459 E.01643
G1 X143.149 Y81.087 E.11439
G1 X143.149 Y81.621 E.01643
G1 X146.311 Y78.459 E.13763
G1 X146.845 Y78.459 E.01643
G1 X143.149 Y82.155 E.16087
G1 X143.149 Y82.689 E.01643
G1 X147.38 Y78.459 E.18412
G1 X147.914 Y78.459 E.01643
G1 X143.149 Y83.223 E.20736
G1 X143.149 Y83.758 E.01643
G1 X148.448 Y78.459 E.2306
G1 X148.982 Y78.459 E.01643
G1 X143.149 Y84.292 E.25384
G1 X143.149 Y84.826 E.01643
G1 X149.516 Y78.459 E.27708
G1 X150.05 Y78.459 E.01643
G1 X143.149 Y85.36 E.30033
G1 X143.149 Y85.894 E.01643
G1 X150.584 Y78.459 E.32357
G1 X151.118 Y78.459 E.01643
G1 X142.979 Y86.597 E.35419
; WIPE_START
G1 X144.393 Y85.183 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.661 Y78.285 Z.8 F30000
G1 X148.306 Y76.922 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X148.306 Y77.922 E.01538
; WIPE_START
G1 X148.306 Y76.922 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X151.579 Y77.997 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X152.118 Y77.459 E.02345
G1 X152.652 Y77.459 E.01643
G1 X143.149 Y86.962 E.41357
G1 X143.149 Y87.496 E.01643
G1 X153.186 Y77.459 E.43681
G1 X153.72 Y77.459 E.01643
G1 X143.149 Y88.03 E.46006
G1 X143.149 Y88.564 E.01643
G1 X154.254 Y77.459 E.4833
G1 X154.788 Y77.459 E.01643
G1 X143.149 Y89.098 E.50654
G1 X143.149 Y89.632 E.01643
G1 X155.322 Y77.459 E.52978
G1 X155.856 Y77.459 E.01643
G1 X143.149 Y90.166 E.55302
G1 X143.149 Y90.7 E.01643
G1 X156.39 Y77.459 E.57627
G1 X156.925 Y77.459 E.01643
G1 X143.149 Y91.234 E.59951
G1 X143.149 Y91.768 E.01643
G1 X157.459 Y77.459 E.62275
G1 X157.993 Y77.459 E.01643
G1 X143.149 Y92.303 E.64599
G1 X143.149 Y92.774 E.01451
G1 X143.212 Y92.774 E.00193
G1 X158.527 Y77.459 E.66651
G1 X159.061 Y77.459 E.01643
G1 X143.746 Y92.774 E.66651
G1 X144.28 Y92.774 E.01643
G1 X159.595 Y77.459 E.66651
G1 X160.129 Y77.459 E.01643
G1 X144.814 Y92.774 E.66651
G1 X145.348 Y92.774 E.01643
G1 X160.663 Y77.459 E.66651
G1 X161.197 Y77.459 E.01643
G1 X145.882 Y92.774 E.66651
G1 X146.416 Y92.774 E.01643
G1 X161.731 Y77.459 E.66651
G1 X162.265 Y77.459 E.01643
G1 X146.95 Y92.774 E.66651
G1 X147.484 Y92.774 E.01643
G1 X162.799 Y77.459 E.66651
G1 X163.333 Y77.459 E.01643
G1 X148.018 Y92.774 E.66651
G1 X148.552 Y92.774 E.01643
G1 X163.867 Y77.459 E.66651
G1 X164.401 Y77.459 E.01643
G1 X149.086 Y92.774 E.66651
G1 X149.62 Y92.774 E.01643
G1 X164.464 Y77.93 E.64599
G1 X164.464 Y78.464 E.01643
G1 X150.154 Y92.774 E.62275
G1 X150.688 Y92.774 E.01643
G1 X164.464 Y78.998 E.59951
G1 X164.464 Y79.532 E.01643
G1 X151.222 Y92.774 E.57627
G1 X151.757 Y92.774 E.01643
G1 X164.464 Y80.066 E.55303
G1 X164.464 Y80.6 E.01643
G1 X152.291 Y92.774 E.52978
G1 X152.825 Y92.774 E.01643
G1 X164.464 Y81.135 E.50654
G1 X164.464 Y81.669 E.01643
G1 X153.359 Y92.774 E.4833
G1 X153.893 Y92.774 E.01643
G1 X164.464 Y82.203 E.46006
G1 X164.464 Y82.737 E.01643
G1 X154.427 Y92.774 E.43682
G1 X154.961 Y92.774 E.01643
G1 X164.464 Y83.271 E.41357
G1 X164.464 Y83.805 E.01643
G1 X155.495 Y92.774 E.39033
G1 X156.029 Y92.774 E.01643
G1 X164.464 Y84.339 E.36709
G1 X164.464 Y84.873 E.01643
G1 X156.563 Y92.774 E.34385
G1 X157.097 Y92.774 E.01643
G1 X164.464 Y85.407 E.3206
G1 X164.464 Y85.941 E.01643
G1 X157.631 Y92.774 E.29736
G1 X158.165 Y92.774 E.01643
G1 X164.464 Y86.475 E.27412
G1 X164.464 Y87.009 E.01643
G1 X158.699 Y92.774 E.25088
G1 X159.233 Y92.774 E.01643
G1 X164.464 Y87.543 E.22764
G1 X164.464 Y88.077 E.01643
G1 X159.767 Y92.774 E.20439
G1 X160.302 Y92.774 E.01643
G1 X164.464 Y88.611 E.18115
G1 X164.464 Y89.145 E.01643
G1 X160.836 Y92.774 E.15791
G1 X161.37 Y92.774 E.01643
G1 X164.464 Y89.68 E.13467
G1 X164.464 Y90.214 E.01643
G1 X161.904 Y92.774 E.11143
G1 X162.438 Y92.774 E.01643
G1 X164.464 Y90.748 E.08818
G1 X164.464 Y91.282 E.01643
G1 X162.972 Y92.774 E.06494
G1 X163.506 Y92.774 E.01643
G1 X164.464 Y91.816 E.0417
G1 X164.464 Y92.35 E.01643
G1 X163.87 Y92.944 E.02584
; OBJECT_ID: 203
; WIPE_START
G1 X164.464 Y92.35 E-.3191
G1 X164.464 Y91.816 E-.20295
G1 X164.021 Y92.259 E-.23796
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X164.652 Y99.865 Z.8 F30000
G1 X165.917 Y115.125 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z.8 F30000
G1 X140.698 Y115.907 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
M73 P34 R17
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.707 Y117.311 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.139 Y113.201 Z.8 F30000
G1 X167.593 Y98.215 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.53 Y98.251 E.002
G1 X167.578 Y98.279 E.00151
G1 X167.593 Y115.945 F30000
G1 F10696.458
G1 X167.53 Y115.981 E.002
G1 X167.578 Y116.009 E.00151
G1 X147.906 Y115.911 F30000
; LINE_WIDTH: 0.452305
G1 F8793.689
G1 X147.889 Y116.067 E.00524
G1 X147.728 Y116.321 E.01003
M73 P35 R17
G1 X166.92 Y116.321 E.64025
G2 X167.929 Y116.338 I.831 J-19.816 E.03367
G3 X167.913 Y115.329 I11.402 J-.692 E.03368
G1 X167.913 Y98.904 E.54794
G2 X167.929 Y97.895 I-19.816 J-.831 E.03367
G1 X166.92 Y97.911 E.03367
G1 X139.495 Y97.911 E.9149
G2 X138.486 Y97.895 I-.831 J19.816 E.03367
G1 X138.502 Y98.904 E.03367
G1 X138.502 Y115.121 E.54102
G1 X138.709 Y115.104 E.00692
G1 X138.86 Y114.713 E.01396
G1 X138.913 Y114.69 E.00193
G1 X138.913 Y98.904 E.52662
G1 X139.095 Y98.504 E.01466
G1 X139.394 Y98.327 E.01158
G1 X166.92 Y98.321 E.91827
G1 X167.32 Y98.504 E.01466
G1 X167.502 Y98.904 E.01466
G1 X167.502 Y115.329 E.54794
G1 X167.497 Y115.43 E.00338
G1 X167.32 Y115.729 E.01158
G1 X167.021 Y115.905 E.01158
G1 X166.92 Y115.911 E.00338
G1 X147.966 Y115.911 E.63231
G1 X147.512 Y115.518 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.103 Y115.515 E.03055
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.572 Y115.518 E.5945
; WIPE_START
G1 X149.572 Y115.518 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.555 Y109.027 Z.8 F30000
G1 X138.864 Y98.215 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X138.801 Y98.251 E.002
G1 X138.848 Y98.279 E.00151
; OBJECT_ID: 269
; WIPE_START
G1 X138.801 Y98.251 E-.32672
G1 X138.864 Y98.215 E-.43328
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.144 Y104.534 Z.8 F30000
G1 X176.182 Y153.302 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00074
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11716
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X161.638 Y172.275 E.11717
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X125.476 Y160 E.11717
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X126.964 Y133.537 E.09868
G1 X127.242 Y133.054 E.01849
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X148.486 Y121.111 E.01849
G1 X151.461 Y121.111 E.09868
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X162.121 Y124.116 E.01849
G1 X164.697 Y125.604 E.09868
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.913 Y136.113 E.11717
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.19 Y153.243 E.11445
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10695
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10695
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X125.829 Y159.826 E.10696
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X127.303 Y133.733 E.09062
G1 X127.569 Y133.272 E.01634
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X137.925 Y124.19 E.10696
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10695
G1 X147.954 Y121.503 E.10696
G1 X148.486 Y121.503 E.01634
G1 X151.435 Y121.503 E.09062
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X161.925 Y124.456 E.01634
G1 X164.479 Y125.931 E.09062
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10695
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.289 Y155.121 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z.8 F30000
G1 X155.04 Y121.186 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11887
G1 X169.932 Y129.632 E.10196
G1 X170.293 Y129.992 E.01692
G1 X172.474 Y132.835 E.11887
G1 X174.266 Y135.939 E.11888
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X168.119 Y168.294 E.10196
G1 X167.759 Y168.654 E.01692
; object ids of layer 2 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer2 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X161.812 Y172.628 E.11888
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.458 Y166.481 E.10196
G1 X129.097 Y166.12 E.01692
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y146.265 E.11887
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X124.928 Y136.41 E.10196
G1 X125.124 Y135.939 E.01691
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11887
G1 X131.27 Y127.819 E.10196
G1 X131.631 Y127.458 E.01692
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X154.534 Y121.12 E.10196
G1 X154.98 Y121.178 E.01492
M204 S250
G1 X155.12 Y120.802 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X158.627 Y121.742 E.11158
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.209 Y129.355 E.09524
G1 X170.588 Y129.733 E.01646
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.397 Y168.571 E.09524
G1 X168.018 Y168.95 E.01646
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X129.18 Y166.758 E.09524
G1 X128.802 Y166.379 E.01646
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.566 Y136.26 E.09524
G1 X124.771 Y135.765 E.01646
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X130.993 Y127.542 E.09524
G1 X131.372 Y127.163 E.01646
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X154.585 Y120.731 E.09524
G1 X155.06 Y120.793 E.01472
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X156.993 Y121.307 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.743 Y126.847 Z.8 F30000
G1 X116.764 Y163.76 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z.8 F30000
G1 X100.964 Y139.541 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.617 Y143.137 Z.8 F30000
G1 X117.641 Y165.379 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y165.415 E.002
G1 X117.625 Y165.443 E.00151
G1 X100.911 Y165.379 F30000
G1 F10696.458
G1 X100.848 Y165.415 E.002
G1 X100.895 Y165.443 E.00151
G1 X100.96 Y143.749 F30000
; LINE_WIDTH: 0.452293
G1 F8793.946
G1 X100.804 Y143.732 E.00524
G1 X100.55 Y143.571 E.01003
G1 X100.55 Y164.763 E.70695
G2 X100.533 Y165.772 I19.816 J.831 E.03367
G1 X101.542 Y165.756 E.03367
G1 X116.968 Y165.756 E.51457
G2 X117.977 Y165.772 I.831 J-19.816 E.03367
G3 X117.96 Y164.763 I11.402 J-.692 E.03368
G1 X117.96 Y138.338 E.88151
G2 X117.977 Y137.329 I-19.816 J-.831 E.03367
G1 X116.968 Y137.345 E.03367
G1 X101.75 Y137.345 E.50765
G1 X101.767 Y137.552 E.00692
G1 X102.158 Y137.703 E.01396
G1 X102.181 Y137.756 E.00193
G1 X116.968 Y137.756 E.49325
G1 X117.367 Y137.938 E.01466
G1 X117.55 Y138.338 E.01466
G1 X117.55 Y164.763 E.88151
G1 X117.544 Y164.864 E.00338
G1 X117.367 Y165.163 E.01158
G1 X117.069 Y165.34 E.01158
G1 X101.542 Y165.345 E.51794
G1 X101.142 Y165.163 E.01466
G1 X100.966 Y164.864 E.01158
G1 X100.96 Y164.763 E.00338
G1 X100.96 Y143.809 E.69901
G1 X101.354 Y143.355 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
M73 P36 R17
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.243 Y142.13 Z.8 F30000
G1 X117.641 Y137.649 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y137.686 E.002
G1 X117.625 Y137.713 E.00151
; OBJECT_ID: 214
; WIPE_START
G1 X117.578 Y137.686 E-.32669
G1 X117.641 Y137.649 E-.43331
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X110.249 Y139.55 Z.8 F30000
G1 X94.746 Y143.538 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.746 Y146.757 E.10676
G1 X95.746 Y146.757 E.03317
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X94.806 Y143.538 E.03118
G1 X95.153 Y143.945 F30000
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
; WIPE_START
M204 S10000
G1 X95.545 Y145.957 E-.61602
G1 X95.924 Y145.957 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X95.582 Y142.985 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X95.362 Y143.205 E.00958
G1 X94.828 Y143.205 E.01643
G1 X95.413 Y142.621 E.02543
G1 X95.413 Y142.086 E.01643
G1 X80.097 Y157.402 E.66651
G1 X80.097 Y157.936 E.01643
G1 X94.413 Y143.621 E.62299
G1 X94.413 Y144.155 E.01643
G1 X80.097 Y158.47 E.62299
G1 X80.097 Y159.004 E.01643
G1 X94.413 Y144.689 E.62299
G1 X94.413 Y145.223 E.01643
G1 X80.097 Y159.538 E.62299
G1 X80.097 Y160.072 E.01643
G1 X94.413 Y145.757 E.62299
G1 X94.413 Y146.291 E.01643
G1 X80.097 Y160.606 E.62299
G1 X80.097 Y161.14 E.01643
G1 X94.413 Y146.825 E.62299
G1 X94.413 Y147.09 E.00815
G1 X94.682 Y147.09 E.00828
G1 X80.097 Y161.674 E.63471
G1 X80.097 Y162.208 E.01643
G1 X95.216 Y147.09 E.65795
G1 X95.413 Y147.09 E.00605
G1 X95.413 Y147.427 E.01038
G1 X80.097 Y162.742 E.66651
G1 X80.097 Y162.805 E.00193
G1 X80.569 Y162.805 E.01451
G1 X95.413 Y147.961 E.64599
G1 X95.413 Y148.495 E.01643
G1 X81.103 Y162.805 E.62275
G1 X81.637 Y162.805 E.01643
G1 X95.413 Y149.029 E.59951
G1 X95.413 Y149.563 E.01643
G1 X82.171 Y162.805 E.57627
G1 X82.705 Y162.805 E.01643
G1 X95.413 Y150.097 E.55303
G1 X95.413 Y150.631 E.01643
G1 X83.239 Y162.805 E.52978
G1 X83.773 Y162.805 E.01643
G1 X95.413 Y151.166 E.50654
G1 X95.413 Y151.7 E.01643
G1 X84.307 Y162.805 E.4833
G1 X84.841 Y162.805 E.01643
G1 X95.413 Y152.234 E.46006
G1 X95.413 Y152.768 E.01643
G1 X85.375 Y162.805 E.43682
G1 X85.909 Y162.805 E.01643
G1 X95.413 Y153.302 E.41357
G1 X95.413 Y153.836 E.01643
G1 X86.443 Y162.805 E.39033
G1 X86.977 Y162.805 E.01643
G1 X95.413 Y154.37 E.36709
G1 X95.413 Y154.904 E.01643
G1 X87.512 Y162.805 E.34385
G1 X88.046 Y162.805 E.01643
G1 X95.413 Y155.438 E.3206
G1 X95.413 Y155.972 E.01643
G1 X88.58 Y162.805 E.29736
G1 X89.114 Y162.805 E.01643
G1 X95.413 Y156.506 E.27412
G1 X95.413 Y157.04 E.01643
G1 X89.648 Y162.805 E.25088
G1 X90.182 Y162.805 E.01643
G1 X95.413 Y157.574 E.22764
G1 X95.413 Y158.108 E.01643
G1 X90.716 Y162.805 E.20439
G1 X91.25 Y162.805 E.01643
G1 X95.413 Y158.642 E.18115
G1 X95.413 Y159.177 E.01643
G1 X91.784 Y162.805 E.15791
G1 X92.318 Y162.805 E.01643
G1 X95.413 Y159.711 E.13467
G1 X95.413 Y160.245 E.01643
G1 X92.852 Y162.805 E.11143
G1 X93.386 Y162.805 E.01643
G1 X95.413 Y160.779 E.08818
G1 X95.413 Y161.313 E.01643
G1 X93.92 Y162.805 E.06494
G1 X94.454 Y162.805 E.01643
G1 X95.413 Y161.847 E.0417
G1 X95.413 Y162.381 E.01643
G1 X94.819 Y162.975 E.02584
G1 X79.928 Y157.037 F30000
G1 F9532.888
G1 X95.413 Y141.552 E.67389
G1 X95.413 Y141.49 E.00193
G1 X94.941 Y141.49 E.01451
G1 X80.097 Y156.334 E.64599
G1 X80.097 Y155.8 E.01643
G1 X94.407 Y141.49 E.62275
G1 X93.873 Y141.49 E.01643
G1 X80.097 Y155.265 E.59951
G1 X80.097 Y154.731 E.01643
G1 X93.339 Y141.49 E.57627
G1 X92.805 Y141.49 E.01643
G1 X80.097 Y154.197 E.55302
G1 X80.097 Y153.663 E.01643
G1 X92.271 Y141.49 E.52978
G1 X91.737 Y141.49 E.01643
G1 X80.097 Y153.129 E.50654
G1 X80.097 Y152.595 E.01643
G1 X91.203 Y141.49 E.4833
G1 X90.669 Y141.49 E.01643
G1 X80.097 Y152.061 E.46006
G1 X80.097 Y151.527 E.01643
G1 X90.135 Y141.49 E.43681
G1 X89.6 Y141.49 E.01643
G1 X80.097 Y150.993 E.41357
G1 X80.097 Y150.459 E.01643
G1 X89.066 Y141.49 E.39033
G1 X88.532 Y141.49 E.01643
G1 X80.097 Y149.925 E.36709
G1 X80.097 Y149.391 E.01643
G1 X87.998 Y141.49 E.34385
G1 X87.464 Y141.49 E.01643
G1 X80.097 Y148.857 E.3206
G1 X80.097 Y148.323 E.01643
G1 X86.93 Y141.49 E.29736
G1 X86.396 Y141.49 E.01643
G1 X80.097 Y147.789 E.27412
G1 X80.097 Y147.254 E.01643
G1 X85.862 Y141.49 E.25088
G1 X85.328 Y141.49 E.01643
G1 X80.097 Y146.72 E.22763
G1 X80.097 Y146.186 E.01643
G1 X84.794 Y141.49 E.20439
G1 X84.26 Y141.49 E.01643
G1 X80.097 Y145.652 E.18115
G1 X80.097 Y145.118 E.01643
G1 X83.726 Y141.49 E.15791
G1 X83.192 Y141.49 E.01643
G1 X80.097 Y144.584 E.13467
G1 X80.097 Y144.05 E.01643
G1 X82.658 Y141.49 E.11142
G1 X82.124 Y141.49 E.01643
G1 X80.097 Y143.516 E.08818
G1 X80.097 Y142.982 E.01643
G1 X81.589 Y141.49 E.06494
G1 X81.055 Y141.49 E.01643
G1 X80.097 Y142.448 E.0417
G1 X80.097 Y141.914 E.01643
G1 X80.691 Y141.32 E.02584
; OBJECT_ID: 236
; WIPE_START
G1 X80.097 Y141.914 E-.31909
G1 X80.097 Y142.448 E-.20294
G1 X80.54 Y142.005 E-.23797
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X84.337 Y135.384 Z.8 F30000
G1 X96.313 Y114.504 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.78 E.10676
G1 X99.295 Y116.072 E.03317
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.07 Y110.261 E.03317
G1 X96.27 Y114.461 E.19704
G1 X96.888 Y114.504 F30000
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.534 Y114.437 E.01538
G1 X94.412 Y112.316 F30000
; LINE_WIDTH: 0.231696
G1 F15000
G1 X95.12 Y111.609 E.01538
; WIPE_START
G1 X94.412 Y112.316 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X91.214 Y108.223 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42348
G1 F9459.743
G1 X80.265 Y119.172 E.4802
G1 X80.534 Y119.441 E.0118
G1 X91.364 Y108.612 E.47494
G1 X91.633 Y108.881 E.0118
G1 X80.803 Y119.71 E.47494
G1 X81.072 Y119.98 E.0118
G1 X91.902 Y109.15 E.47494
G1 X92.171 Y109.419 E.0118
G1 X81.341 Y120.249 E.47494
G1 X81.61 Y120.518 E.0118
G1 X91.733 Y110.395 E.44393
G1 X92.002 Y110.664 E.0118
G1 X81.88 Y120.787 E.44393
G1 X82.149 Y121.056 E.0118
G1 X92.271 Y110.934 E.44393
G1 X92.54 Y111.203 E.0118
G1 X82.418 Y121.325 E.44393
G1 X82.687 Y121.594 E.0118
G1 X92.809 Y111.472 E.44393
G1 X93.078 Y111.741 E.0118
G1 X82.956 Y121.863 E.44393
G1 X83.225 Y122.132 E.0118
G1 X93.347 Y112.01 E.44393
G1 X93.616 Y112.279 E.0118
G1 X83.494 Y122.401 E.44393
G1 X83.763 Y122.67 E.0118
G1 X93.886 Y112.548 E.44393
G1 X94.155 Y112.817 E.0118
G1 X84.032 Y122.94 E.44393
G1 X84.301 Y123.209 E.0118
G1 X94.424 Y113.086 E.44393
G1 X94.693 Y113.355 E.0118
G1 X84.57 Y123.478 E.44393
G1 X84.84 Y123.747 E.0118
G1 X94.962 Y113.624 E.44393
G1 X95.231 Y113.894 E.0118
G1 X85.109 Y124.016 E.44393
G1 X85.378 Y124.285 E.0118
G1 X95.5 Y114.163 E.44393
G1 X95.769 Y114.432 E.0118
G1 X85.647 Y124.554 E.44393
G1 X85.916 Y124.823 E.0118
G1 X96.038 Y114.701 E.44393
G1 X96.307 Y114.97 E.0118
G1 X86.185 Y125.092 E.44393
G1 X86.454 Y125.361 E.0118
G1 X96.577 Y115.239 E.44393
G1 X96.846 Y115.508 E.0118
G1 X86.723 Y125.631 E.44393
G1 X86.992 Y125.9 E.0118
G1 X97.115 Y115.777 E.44393
G1 X97.384 Y116.046 E.0118
G1 X87.261 Y126.169 E.44393
G1 X87.531 Y126.438 E.0118
G1 X97.653 Y116.315 E.44393
G1 X97.922 Y116.585 E.0118
G1 X87.8 Y126.707 E.44393
G1 X88.069 Y126.976 E.0118
G1 X98.191 Y116.854 E.44393
G1 X98.46 Y117.123 E.0118
G1 X88.338 Y127.245 E.44393
G1 X88.607 Y127.514 E.0118
G1 X99.436 Y116.685 E.47494
G1 X99.706 Y116.954 E.0118
G1 X88.876 Y127.783 E.47494
G1 X89.145 Y128.052 E.0118
G1 X99.975 Y117.223 E.47494
G1 X100.244 Y117.492 E.0118
G1 X89.414 Y128.321 E.47494
G1 X89.683 Y128.591 E.0118
G1 X100.513 Y117.761 E.47494
M73 P37 R17
G1 X100.782 Y118.03 E.0118
G1 X89.952 Y128.86 E.47494
G1 X90.222 Y129.129 E.0118
G1 X101.051 Y118.299 E.47494
G1 X101.32 Y118.568 E.0118
G1 X90.491 Y129.398 E.47494
G1 X90.76 Y129.667 E.0118
G1 X101.589 Y118.838 E.47494
G1 X101.858 Y119.107 E.0118
G1 X91.029 Y129.936 E.47494
G1 X91.298 Y130.205 E.0118
G1 X102.127 Y119.376 E.47494
G1 X102.396 Y119.645 E.0118
G1 X91.567 Y130.474 E.47494
G1 X91.836 Y130.743 E.0118
G1 X102.666 Y119.914 E.47494
G1 X102.935 Y120.183 E.0118
G1 X92.105 Y131.012 E.47494
G1 X92.374 Y131.282 E.0118
G1 X103.204 Y120.452 E.47494
G1 X103.473 Y120.721 E.0118
G1 X92.643 Y131.551 E.47494
G1 X92.912 Y131.82 E.0118
G1 X103.742 Y120.99 E.47494
G1 X104.011 Y121.259 E.0118
G1 X93.182 Y132.089 E.47494
G1 X93.451 Y132.358 E.0118
G1 X104.28 Y121.528 E.47494
G1 X104.549 Y121.798 E.0118
G1 X93.72 Y132.627 E.47494
G1 X93.989 Y132.896 E.0118
G1 X104.818 Y122.067 E.47494
G1 X105.087 Y122.336 E.0118
G1 X94.258 Y133.165 E.47494
G1 X94.527 Y133.434 E.0118
G1 X105.357 Y122.605 E.47494
G1 X105.626 Y122.874 E.0118
G1 X94.796 Y133.703 E.47494
G1 X95.065 Y133.973 E.0118
G1 X105.895 Y123.143 E.47494
G1 X106.164 Y123.412 E.0118
G1 X95.214 Y134.362 E.4802
; OBJECT_ID: 181
; WIPE_START
G1 X96.629 Y132.947 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X103.792 Y130.314 Z.8 F30000
G1 X130.791 Y120.389 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X105.74 Y110.059 E.09319
G1 X113.666 Y102.133 E.37183
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X106.028 Y110.347 E.07968
G1 X113.666 Y102.709 E.35832
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X106.305 Y110.624 E.06176
G1 X113.666 Y103.263 E.31987
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z.8 F30000
G1 X101.799 Y111.197 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.72 Y114.099 Z.8 F30000
G1 X132.588 Y119.787 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.525 Y119.823 E.002
G1 X132.572 Y119.851 E.00151
G1 X121.465 Y130.91 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.402 Y130.946 E.002
G1 X121.45 Y130.974 E.00151
G1 X104.759 Y114.162 F30000
; LINE_WIDTH: 0.452271
G1 F8794.426
G1 X104.636 Y114.26 E.00524
G1 X104.343 Y114.326 E.01003
G1 X120.742 Y130.725 E.77362
G2 X121.444 Y131.451 I14.602 J-13.428 E.03367
G3 X122.146 Y130.725 I8.557 J7.578 E.03367
G1 X132.346 Y120.525 E.48118
G2 X133.071 Y119.823 I-13.416 J-14.591 E.03367
G1 X132.346 Y119.122 E.03366
G1 X114.368 Y101.143 E.84811
G2 X113.666 Y100.418 I-14.62 J13.445 E.03367
G1 X112.964 Y101.143 E.03366
G1 X102.911 Y111.197 E.47426
G1 X103.069 Y111.331 E.00692
G1 X103.452 Y111.161 E.01396
G1 X103.506 Y111.182 E.00193
G1 X113.254 Y101.433 E.45986
G1 X113.666 Y101.279 E.01466
G1 X114.078 Y101.433 E.01466
G1 X132.056 Y119.412 E.84811
G1 X132.21 Y119.823 E.01466
G1 X132.123 Y120.16 E.01158
G1 X121.856 Y130.435 E.48456
G1 X121.78 Y130.503 E.00338
G1 X121.444 Y130.589 E.01158
G1 X121.108 Y130.503 E.01158
G1 X121.032 Y130.435 E.00338
G1 X104.801 Y114.204 E.76568
G1 X104.759 Y113.605 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.432 Y113.924 E.01402
G1 X104.315 Y113.95 E.0037
G1 X104.18 Y113.896 E.00446
G1 X103.768 Y114.308 E.01791
G1 X121.444 Y131.984 E.76809
G1 X133.605 Y119.823 E.52842
G1 X113.666 Y99.885 E.86641
G1 X102.354 Y111.197 E.49155
G1 X103.057 Y111.9 E.03055
G1 X103.366 Y111.593 E.01338
G1 X103.472 Y111.554 E.00346
G1 X103.635 Y111.609 E.00531
G1 X113.533 Y101.712 E.43007
G1 X113.666 Y101.656 E.00443
G1 X113.799 Y101.712 E.00443
G1 X131.778 Y119.69 E.78123
G1 X131.833 Y119.823 E.00443
G3 X131.778 Y119.957 I-.188 J0 E.00455
G1 X121.577 Y130.157 E.44324
G1 X121.444 Y130.212 E.00443
G1 X121.311 Y130.157 E.00443
G1 X104.801 Y113.647 E.7174
; WIPE_START
G1 X106.215 Y115.062 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.774 Y108.31 Z.8 F30000
G1 X113.687 Y100.886 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X113.624 Y100.923 E.002
G1 X113.671 Y100.95 E.00151
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.32668
G1 X113.687 Y100.886 E-.43332
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.866 Y98.294 Z.8 F30000
G1 X135.594 Y92.974 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.492 Y99.335 Z.8 F30000
G1 X124.172 Y103.922 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42348
G1 F9459.743
G1 X135.121 Y92.973 E.4802
G1 X134.852 Y92.704 E.0118
G1 X124.023 Y103.533 E.47494
G1 X123.754 Y103.264 E.0118
G1 X134.583 Y92.435 E.47494
G1 X134.314 Y92.166 E.0118
G1 X123.485 Y102.995 E.47494
G1 X123.216 Y102.726 E.0118
G1 X134.045 Y91.897 E.47494
G1 X133.776 Y91.627 E.0118
G1 X122.947 Y102.457 E.47494
G1 X122.677 Y102.188 E.0118
G1 X133.507 Y91.358 E.47494
G1 X133.238 Y91.089 E.0118
G1 X122.408 Y101.919 E.47494
G1 X122.139 Y101.65 E.0118
G1 X132.969 Y90.82 E.47494
G1 X132.7 Y90.551 E.0118
G1 X121.87 Y101.381 E.47494
G1 X121.601 Y101.111 E.0118
G1 X132.431 Y90.282 E.47494
G1 X132.161 Y90.013 E.0118
G1 X121.332 Y100.842 E.47494
G1 X121.063 Y100.573 E.0118
G1 X131.892 Y89.744 E.47494
G1 X131.623 Y89.475 E.0118
G1 X120.794 Y100.304 E.47494
G1 X120.525 Y100.035 E.0118
G1 X131.354 Y89.206 E.47494
G1 X131.085 Y88.936 E.0118
G1 X120.256 Y99.766 E.47494
G1 X119.986 Y99.497 E.0118
G1 X130.816 Y88.667 E.47494
G1 X130.547 Y88.398 E.0118
G1 X119.717 Y99.228 E.47494
G1 X119.448 Y98.959 E.0118
G1 X130.278 Y88.129 E.47494
G1 X130.009 Y87.86 E.0118
G1 X119.179 Y98.69 E.47494
G1 X118.91 Y98.42 E.0118
G1 X129.74 Y87.591 E.47494
G1 X129.47 Y87.322 E.0118
G1 X118.641 Y98.151 E.47494
G1 X118.372 Y97.882 E.0118
G1 X129.201 Y87.053 E.47494
G1 X128.932 Y86.784 E.0118
G1 X118.103 Y97.613 E.47494
G1 X117.834 Y97.344 E.0118
G1 X128.663 Y86.515 E.47494
G1 X128.394 Y86.246 E.0118
G1 X117.565 Y97.075 E.47494
G1 X117.295 Y96.806 E.0118
G1 X128.125 Y85.976 E.47494
G1 X127.856 Y85.707 E.0118
G1 X117.026 Y96.537 E.47494
G1 X116.757 Y96.268 E.0118
G1 X127.587 Y85.438 E.47494
G1 X127.318 Y85.169 E.0118
G1 X116.488 Y95.999 E.47494
G1 X116.219 Y95.73 E.0118
G1 X127.049 Y84.9 E.47494
G1 X126.779 Y84.631 E.0118
G1 X115.95 Y95.46 E.47494
M73 P38 R17
G1 X115.681 Y95.191 E.0118
G1 X126.51 Y84.362 E.47494
G1 X126.241 Y84.093 E.0118
G1 X115.412 Y94.922 E.47494
G1 X115.143 Y94.653 E.0118
G1 X125.972 Y83.824 E.47494
G1 X125.703 Y83.555 E.0118
G1 X114.874 Y94.384 E.47494
G1 X114.605 Y94.115 E.0118
G1 X125.434 Y83.285 E.47494
G1 X125.165 Y83.016 E.0118
G1 X114.335 Y93.846 E.47494
G1 X114.066 Y93.577 E.0118
G1 X124.896 Y82.747 E.47494
G1 X124.627 Y82.478 E.0118
G1 X113.797 Y93.308 E.47494
G1 X113.528 Y93.039 E.0118
G1 X124.358 Y82.209 E.47494
G1 X124.089 Y81.94 E.0118
G1 X113.259 Y92.769 E.47494
G1 X112.99 Y92.5 E.0118
G1 X123.819 Y81.671 E.47494
G1 X123.55 Y81.402 E.0118
G1 X112.721 Y92.231 E.47494
G1 X112.452 Y91.962 E.0118
G1 X123.281 Y81.133 E.47494
G1 X123.012 Y80.864 E.0118
G1 X112.183 Y91.693 E.47494
G1 X111.914 Y91.424 E.0118
G1 X122.743 Y80.594 E.47494
G1 X122.474 Y80.325 E.0118
G1 X111.644 Y91.155 E.47494
G1 X111.375 Y90.886 E.0118
G1 X122.205 Y80.056 E.47494
G1 X121.936 Y79.787 E.0118
G1 X111.106 Y90.617 E.47494
G1 X110.837 Y90.348 E.0118
G1 X121.667 Y79.518 E.47494
G1 X121.398 Y79.249 E.0118
G1 X110.568 Y90.078 E.47494
G1 X110.299 Y89.809 E.0118
G1 X121.128 Y78.98 E.47494
G1 X120.859 Y78.711 E.0118
G1 X110.03 Y89.54 E.47494
G1 X109.761 Y89.271 E.0118
G1 X120.59 Y78.442 E.47494
G1 X120.321 Y78.173 E.0118
G1 X109.492 Y89.002 E.47494
G1 X109.223 Y88.733 E.0118
G1 X120.172 Y77.784 E.4802
; OBJECT_ID: 258
; WIPE_START
G1 X118.758 Y79.198 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X113.991 Y85.159 Z.8 F30000
G1 X100.257 Y102.335 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.008 Y102.161 E.01009
G3 X101.326 Y97.325 I1.653 J-2.147 E.21226
G3 X102.008 Y97.327 I.335 J2.587 E.02269
G3 X100.31 Y102.363 I-.348 J2.687 E.31766
G1 X100.524 Y102.02 F30000
G1 F8843.478
G1 X100.506 Y102.005 E.00079
G3 X101.377 Y97.73 I1.155 J-1.991 E.19032
G3 X101.955 Y97.732 I.283 J2.191 E.01922
G3 X100.753 Y102.129 I-.295 J2.283 E.26095
G1 X100.578 Y102.046 E.00644
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.426 Y98.12 I.958 J-1.651 E.14625
G3 X101.904 Y98.121 I.233 J1.81 E.01471
G3 X100.754 Y101.695 I-.244 J1.893 E.20572
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11761
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09492
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09497
G1 X99.76 Y100.265 E-.09495
G1 X99.748 Y100.074 E-.07261
; WIPE_END
G1 E-.04 F1800
G1 X97.216 Y93.575 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.206 Y93.647 E.0024
G3 X94.255 Y90.254 I-2.616 J-.704 E.38876
G3 X94.937 Y90.256 I.335 J2.594 E.02269
G3 X97.275 Y93.299 I-.348 J2.687 E.14144
G1 X97.229 Y93.517 E.0074
G1 X96.817 Y93.496 F30000
G1 F8843.478
G1 X96.811 Y93.541 E.00151
G3 X94.306 Y90.659 I-2.222 J-.598 E.33029
G3 X94.884 Y90.66 I.283 J2.198 E.01922
G3 X96.871 Y93.245 I-.295 J2.283 E.12016
G1 X96.83 Y93.437 E.00651
M204 S250
G1 X96.432 Y93.419 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X96.432 Y93.439 E.00061
G3 X94.355 Y91.049 I-1.843 J-.496 E.25378
G3 X94.833 Y91.05 I.233 J1.816 E.01471
G3 X96.481 Y93.194 I-.244 J1.893 E.09233
G1 X96.445 Y93.361 E.00524
; WIPE_START
M204 S10000
G1 X96.432 Y93.439 E-.03029
G1 X96.348 Y93.675 E-.09504
G1 X96.238 Y93.899 E-.09499
G1 X96.099 Y94.107 E-.09492
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09495
G1 X95.314 Y94.709 E-.09496
G1 X95.153 Y94.764 E-.06489
; WIPE_END
G1 E-.04 F1800
G1 X102.497 Y96.842 Z.8 F30000
G1 X108.713 Y98.601 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X108.67 Y98.559 E.5945
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X109.007 Y98.32 E.61029
G1 X109.246 Y98.559 E.01121
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X109.284 Y98.042 E.57736
G1 X109.8 Y98.559 E.02243
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.671 Y103.595 Z.8 F30000
G1 X100.263 Y104.352 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41194
G1 F9755.57
G1 X100.194 Y104.392 E.0024
G1 X100.251 Y104.425 E.00198
; WIPE_START
G1 X100.194 Y104.392 E-.34381
G1 X100.263 Y104.352 E-.41619
; WIPE_END
G1 E-.04 F1800
G1 X105.657 Y98.952 Z.8 F30000
G1 X106.048 Y98.56 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X105.977 Y98.601 E.00251
G1 X106.037 Y98.635 E.00212
; WIPE_START
G1 X105.977 Y98.601 E-.34769
G1 X106.048 Y98.56 E-.41231
; WIPE_END
G1 E-.04 F1800
G1 X99.672 Y97.644 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.419989
G1 F9547.323
G1 X99.867 Y97.492 E.0076
G1 X100.445 Y97.159 E.02049
G1 X100.882 Y97.01 E.01419
G1 X101.63 Y96.913 E.02318
G1 X102.084 Y96.943 E.01397
G1 X102.819 Y97.14 E.02339
G1 X103.523 Y97.539 E.02488
G1 X104.101 Y98.107 E.02489
G1 X104.511 Y98.805 E.02488
G1 X104.727 Y99.586 E.02488
G1 X104.733 Y100.396 E.02489
G1 X104.53 Y101.18 E.02488
; LINE_WIDTH: 0.436818
G1 F9139.433
M73 P38 R16
G1 X104.345 Y101.54 E.01301
; LINE_WIDTH: 0.483107
G1 F8178.343
G1 X104.16 Y101.901 E.01454
G1 X103.588 Y102.487 E.02936
; LINE_WIDTH: 0.47357
G1 F8359.457
G1 X103.226 Y102.679 E.01438
; LINE_WIDTH: 0.42079
G1 F9527.103
G1 X102.864 Y102.872 E.01262
G1 X102.084 Y103.088 E.02494
G1 X101.274 Y103.094 E.02494
G1 X100.818 Y103.003 E.01431
G1 X100.124 Y102.714 E.02314
G1 X99.478 Y102.226 E.02493
G1 X98.98 Y101.588 E.02494
G1 X98.664 Y100.842 E.02494
G1 X98.552 Y100.04 E.02494
G1 X98.579 Y99.598 E.01363
G3 X98.829 Y98.748 I3.283 J.504 E.02736
G1 X99.178 Y98.146 E.02143
G1 X99.63 Y97.686 E.01983
G1 X99.458 Y95.134 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X99.944 Y94.936 E.01613
G1 X100.59 Y94.767 E.02054
G1 X101.063 Y94.705 E.01464
G1 X99.893 Y93.535 E.05084
G1 X99.772 Y94.313 E.02417
G3 X99.481 Y95.078 I-8.898 J-2.948 E.02518
G1 X100.209 Y94.368 F30000
; LINE_WIDTH: 0.50846
G1 F7732.955
G2 X100.207 Y94.469 I-.029 J.05 E.00912
G1 X96.859 Y95.037 F30000
; LINE_WIDTH: 0.419989
G1 F9547.323
G3 X96.156 Y95.618 I-3.34 J-3.32 E.02808
G3 X95.362 Y95.947 I-5.456 J-12.049 E.02639
G1 X94.608 Y96.046 E.02338
G1 X94.154 Y96.017 E.01398
G1 X93.419 Y95.82 E.02338
G1 X92.714 Y95.42 E.02488
G1 X92.137 Y94.852 E.02489
G1 X91.727 Y94.154 E.02488
G1 X91.511 Y93.373 E.02488
G1 X91.504 Y92.564 E.02489
G1 X91.708 Y91.78 E.02488
; LINE_WIDTH: 0.436818
G1 F9139.433
G1 X91.893 Y91.419 E.01301
; LINE_WIDTH: 0.483104
G1 F8178.4
G1 X92.078 Y91.058 E.01454
G1 X92.65 Y90.473 E.02936
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X93.012 Y90.28 E.01438
; LINE_WIDTH: 0.420826
G1 F9526.186
G3 X93.811 Y89.939 I1.441 J2.269 E.02687
G1 X94.559 Y89.842 E.02324
G1 X95.362 Y89.941 E.02493
G1 X96.113 Y90.245 E.02494
G1 X96.76 Y90.733 E.02494
G1 X97.258 Y91.372 E.02494
G1 X97.573 Y92.117 E.02494
G1 X97.685 Y92.92 E.02494
G1 X97.586 Y93.723 E.02494
G1 X97.309 Y94.409 E.02277
G1 X96.894 Y94.988 E.02195
G1 X97.093 Y95.35 F30000
; LINE_WIDTH: 0.41999
G1 F9547.306
G1 X96.464 Y95.857 E.02483
G1 X96.222 Y96.006 E.00874
G1 X95.554 Y96.283 E.0222
G1 X94.657 Y96.42 E.02789
G1 X94.056 Y96.381 E.0185
G1 X93.321 Y96.184 E.02338
G1 X92.526 Y95.747 E.02789
G1 X91.87 Y95.119 E.02789
G1 X91.4 Y94.343 E.02789
G1 X91.147 Y93.471 E.02789
G1 X91.127 Y92.564 E.02789
G1 X91.344 Y91.682 E.02789
G1 X91.382 Y91.589 E.00309
G1 X88.613 Y94.358 E.12033
G1 X100.24 Y105.986 E.50525
G1 X103.009 Y103.216 E.12034
G1 X102.181 Y103.452 E.02646
G1 X101.274 Y103.471 E.02789
G1 X100.676 Y103.352 E.01873
G1 X99.979 Y103.062 E.02318
G1 X99.249 Y102.525 E.02786
G1 X98.681 Y101.817 E.02789
G1 X98.316 Y100.986 E.02789
G1 X98.178 Y100.089 E.02789
G1 X98.209 Y99.524 E.01738
G1 X98.353 Y98.933 E.0187
G1 X98.503 Y98.558 E.01239
G1 X98.852 Y97.957 E.02138
G3 X99.597 Y97.213 I5.491 J4.75 E.03237
G1 X100.256 Y96.832 E.02339
G1 X100.763 Y96.65 E.01656
G1 X101.581 Y96.539 E.02537
G1 X102.181 Y96.579 E.01847
G1 X102.916 Y96.775 E.02339
G1 X103.712 Y97.213 E.02789
G1 X104.367 Y97.841 E.02789
G1 X104.838 Y98.617 E.02789
G1 X105.091 Y99.488 E.02789
G1 X105.11 Y100.396 E.02789
G1 X104.894 Y101.277 E.02788
G1 X104.856 Y101.37 E.0031
G1 X107.625 Y98.601 E.12033
G1 X95.998 Y86.974 E.50525
G1 X93.231 Y89.74 E.1202
G1 X93.762 Y89.565 E.01717
G1 X94.51 Y89.468 E.02318
G1 X95.412 Y89.567 E.02786
G1 X96.258 Y89.897 E.02789
G1 X96.989 Y90.434 E.02788
G1 X97.557 Y91.142 E.02789
G1 X97.922 Y91.973 E.02789
G1 X98.059 Y92.87 E.02789
G1 X97.96 Y93.773 E.02789
G1 X97.657 Y94.553 E.02572
G1 X97.499 Y94.821 E.00955
G1 X97.13 Y95.302 E.01864
G1 X97.219 Y95.753 F30000
; LINE_WIDTH: 0.41999
G1 F9547.305
G1 X96.615 Y96.217 E.02339
G3 X95.461 Y96.695 I-2.807 J-5.145 E.03845
G1 X94.706 Y96.794 E.02338
G1 X94.141 Y96.775 E.01738
G1 X93.224 Y96.548 E.02904
G1 X92.337 Y96.073 E.03089
G1 X92.142 Y95.924 E.00756
G1 X91.604 Y95.385 E.02339
G1 X91.074 Y94.531 E.0309
G1 X90.782 Y93.569 E.0309
G1 X90.75 Y92.754 E.02504
G1 X89.146 Y94.358 E.06971
G1 X100.24 Y105.452 E.48208
G1 X101.844 Y103.848 E.06971
G3 X100.709 Y103.754 I-.285 J-3.461 E.03515
G1 X99.835 Y103.41 E.02889
G1 X99.623 Y103.288 E.00751
G1 X99.019 Y102.825 E.02338
G1 X98.845 Y102.651 E.00756
G1 X98.382 Y102.047 E.02338
G1 X97.967 Y101.13 E.0309
G1 X97.804 Y100.138 E.0309
G3 X98.084 Y98.563 I4.106 J-.085 E.04948
G1 X98.476 Y97.853 E.02491
G1 X98.75 Y97.499 E.01374
G1 X99.213 Y97.036 E.02014
G1 X100.006 Y96.541 E.02874
G1 X100.603 Y96.304 E.01972
G1 X101.533 Y96.165 E.02888
G1 X102.097 Y96.184 E.01733
G1 X103.014 Y96.411 E.02904
G1 X103.9 Y96.886 E.0309
G1 X104.096 Y97.036 E.00756
G1 X104.634 Y97.574 E.02339
G1 X105.164 Y98.428 E.0309
G1 X105.455 Y99.391 E.03089
G1 X105.487 Y100.205 E.02505
G1 X107.092 Y98.601 E.06971
G1 X95.998 Y87.507 E.48208
G1 X94.403 Y89.102 E.0693
G1 X94.706 Y89.094 E.00933
G1 X95.461 Y89.194 E.02338
G1 X96.402 Y89.549 E.0309
G1 X96.615 Y89.672 E.00756
G1 X97.219 Y90.135 E.02338
G1 X97.393 Y90.309 E.00756
G1 X97.856 Y90.913 E.02338
G1 X98.27 Y91.829 E.03089
G1 X98.433 Y92.821 E.0309
G1 X98.334 Y93.822 E.0309
G3 X97.979 Y94.763 I-6.73 J-2.002 E.03092
G1 X97.457 Y95.496 E.02766
G1 X97.259 Y95.709 E.00894
G1 X97.692 Y95.809 F30000
; LINE_WIDTH: 0.417928
G1 F9599.811
G3 X96.844 Y96.516 I-4.649 J-4.712 E.03377
G1 X96.511 Y96.703 E.01169
G1 X95.843 Y96.979 E.02208
G1 X95.51 Y97.069 E.01053
G1 X94.756 Y97.168 E.02326
G1 X94.116 Y97.151 E.01955
G1 X93.126 Y96.912 E.03113
G1 X92.808 Y96.78 E.01053
G1 X92.157 Y96.386 E.02326
; LINE_WIDTH: 0.373417
G1 F10892.713
G1 X91.358 Y95.631 E.02959
G1 X91.142 Y95.37 E.00912
; LINE_WIDTH: 0.414314
G1 F9693.223
G1 X90.747 Y94.72 E.02304
G3 X90.413 Y93.625 I7.418 J-2.863 E.03467
G1 X89.679 Y94.358 E.03139
G3 X90.873 Y95.577 I-26.131 J26.799 E.05162
; LINE_WIDTH: 0.38143
G1 F10634.842
G2 X92.501 Y97.18 I22.384 J-21.097 E.06304
; LINE_WIDTH: 0.419985
G1 F9547.426
G1 X97.544 Y102.223 E.21913
; LINE_WIDTH: 0.403458
G1 F9985.092
G1 X97.941 Y102.644 E.01701
; LINE_WIDTH: 0.376005
G1 F10808.059
G2 X99.161 Y103.851 I12.562 J-11.466 E.0466
; LINE_WIDTH: 0.416912
G1 F9625.885
G3 X100.24 Y104.919 I-74.771 J76.651 E.04627
G1 X100.969 Y104.19 E.0314
G1 X100.386 Y104.048 E.01828
G1 X99.69 Y103.757 E.023
G1 X99.398 Y103.581 E.01039
; LINE_WIDTH: 0.374334
G1 F10862.563
G1 X98.81 Y103.098 E.02056
G1 X98.572 Y102.86 E.00907
G1 X98.089 Y102.271 E.02056
; LINE_WIDTH: 0.41867
G1 F9580.852
G1 X97.91 Y101.978 E.01052
G1 X97.619 Y101.275 E.02331
G1 X97.53 Y100.942 E.01055
G1 X97.431 Y100.187 E.0233
G1 X97.447 Y99.548 E.01958
G3 X97.728 Y98.438 I4.097 J.445 E.03518
G1 X98.15 Y97.664 E.02699
G1 X98.408 Y97.307 E.01348
G1 X98.946 Y96.769 E.0233
G3 X100.482 Y95.947 I3.024 J3.805 E.05361
G1 X101.484 Y95.791 E.03106
G1 X102.121 Y95.808 E.01951
G1 X103.111 Y96.047 E.03119
G1 X103.43 Y96.179 E.01055
G1 X104.081 Y96.574 E.02331
; LINE_WIDTH: 0.373427
G1 F10892.381
G1 X104.879 Y97.328 E.02959
G1 X105.095 Y97.589 E.00912
; LINE_WIDTH: 0.414315
G1 F9693.182
G1 X105.491 Y98.24 E.02304
G3 X105.825 Y99.334 I-7.413 J2.862 E.03467
G1 X106.558 Y98.601 E.03139
G3 X105.364 Y97.383 I26.091 J-26.76 E.05163
; LINE_WIDTH: 0.381434
G1 F10634.737
G2 X103.737 Y95.779 I-22.394 J21.109 E.06304
; LINE_WIDTH: 0.419989
G1 F9547.326
G1 X98.694 Y90.737 E.21913
; LINE_WIDTH: 0.40345
G1 F9985.299
G1 X98.296 Y90.316 E.017
; LINE_WIDTH: 0.375988
G1 F10808.621
G2 X97.077 Y89.108 I-12.568 J11.472 E.0466
; LINE_WIDTH: 0.416933
G1 F9625.341
G3 X95.998 Y88.04 I74.773 J-76.656 E.04628
G1 X95.252 Y88.786 E.03213
G1 X95.843 Y88.909 E.0184
G1 X96.546 Y89.201 E.0232
G1 X96.84 Y89.379 E.01047
; LINE_WIDTH: 0.374324
G1 F10862.902
G1 X97.428 Y89.862 E.02056
G1 X97.666 Y90.1 E.00907
G1 X98.149 Y90.688 E.02056
; LINE_WIDTH: 0.41948
G1 F9560.249
G1 X98.327 Y90.981 E.01054
G1 X98.619 Y91.685 E.02335
G1 X98.708 Y92.017 E.01057
G1 X98.807 Y92.772 E.02335
G1 X98.807 Y93.116 E.01057
G1 X98.708 Y93.871 E.02335
G3 X98.327 Y94.907 I-6.468 J-1.787 E.0339
G3 X97.728 Y95.761 I-4.441 J-2.476 E.03208
G1 X97.991 Y96.038 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G3 X95.559 Y97.442 I-3.493 J-3.241 E.08757
G1 X94.805 Y97.542 E.02338
G1 X94.091 Y97.528 E.02192
G1 X93.168 Y97.314 E.02912
G1 X97.27 Y101.415 E.17823
G1 X97.156 Y100.991 E.0135
G1 X97.057 Y100.237 E.02339
G1 X97.071 Y99.523 E.02192
G3 X97.372 Y98.313 I4.476 J.471 E.03846
G1 X97.824 Y97.475 E.02925
G1 X98.142 Y97.041 E.01652
G1 X98.68 Y96.503 E.02338
G3 X100.688 Y95.514 I3.127 J3.82 E.06936
G1 X101.436 Y95.417 E.02318
G1 X102.146 Y95.432 E.02183
G1 X103.069 Y95.645 E.02912
G1 X98.968 Y91.544 E.17823
G1 X99.082 Y91.968 E.0135
G1 X99.181 Y92.723 E.02338
G1 X99.181 Y93.166 E.01361
G1 X99.082 Y93.92 E.02338
G1 X98.967 Y94.348 E.01361
G1 X98.676 Y95.051 E.02338
G3 X98.027 Y95.991 I-4.659 J-2.52 E.03515
G1 X98.385 Y96.208 F30000
; LINE_WIDTH: 0.478843
G1 F8258.349
G1 X98.614 Y96.057 E.00973
; LINE_WIDTH: 0.420526
G1 F9533.755
G3 X100.065 Y95.293 I3.948 J5.733 E.05058
G1 X100.639 Y95.141 E.01828
G1 X101.387 Y95.043 E.02321
G1 X101.93 Y95.04 E.01672
G2 X99.558 Y92.673 I-182.988 J181.023 E.10311
G1 X99.555 Y93.215 E.01668
G1 X99.455 Y93.969 E.02342
G1 X99.315 Y94.492 E.01666
G1 X99.024 Y95.195 E.02342
G1 X98.753 Y95.664 E.01666
; LINE_WIDTH: 0.439608
G1 F9075.154
G1 X98.586 Y95.911 E.00964
; LINE_WIDTH: 0.478843
G1 F8258.349
G1 X98.419 Y96.159 E.0106
G1 X98.385 Y96.208 F30000
; LINE_WIDTH: 0.492731
G1 F8003.373
G3 X97.825 Y96.767 I-4.202 J-3.655 E.02904
G1 X97.78 Y96.807 F30000
; LINE_WIDTH: 0.489208
G1 F8066.549
G1 X97.542 Y96.961 E.01031
; LINE_WIDTH: 0.420648
G1 F9530.681
G3 X95.609 Y97.816 I-3.314 J-4.875 E.06542
G1 X94.854 Y97.916 E.02342
G1 X94.307 Y97.92 E.01683
G2 X96.679 Y100.286 I134.621 J-132.553 E.10313
G1 X96.695 Y99.498 E.02425
G1 X96.806 Y98.85 E.02026
G1 X97.016 Y98.187 E.02139
G1 X97.498 Y97.285 E.03148
; LINE_WIDTH: 0.443063
G1 F8996.795
G1 X97.624 Y97.072 E.00808
; LINE_WIDTH: 0.489208
G1 F8066.549
G1 X97.749 Y96.859 E.00901
G1 X96.773 Y97.818 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G3 X95.175 Y98.254 I-2.138 J-4.699 E.05113
G1 X96.327 Y99.406 E.05009
G1 X96.436 Y98.776 E.01965
G1 X96.661 Y98.062 E.023
G1 X96.748 Y97.873 E.00641
G1 X96.087 Y98.49 F30000
; LINE_WIDTH: 0.50852
G1 F7731.959
G2 X96.085 Y98.591 I-.029 J.05 E.00912
G1 X90.237 Y94.317 F30000
; LINE_WIDTH: 0.4205
G1 F9534.404
G1 X90.166 Y94.358 E.00251
G1 X90.226 Y94.393 E.00212
G1 X91.795 Y90.694 F30000
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X91.471 Y90.992 E.01544
; LINE_WIDTH: 0.420289
G1 F9539.747
G1 X91.148 Y91.29 E.01353
G1 X88.08 Y94.358 E.13343
G1 X100.24 Y106.519 E.52884
G1 X103.308 Y103.451 E.13343
; LINE_WIDTH: 0.43979
G1 F9070.98
G1 X103.563 Y103.168 E.01232
; LINE_WIDTH: 0.490497
G1 F8043.321
G3 X104.443 Y102.266 I8.422 J7.332 E.04597
; LINE_WIDTH: 0.47357
G1 F8359.457
G1 X104.766 Y101.967 E.01544
; LINE_WIDTH: 0.420289
G1 F9539.746
G1 X105.09 Y101.669 E.01353
G1 X108.158 Y98.601 E.13343
G1 X95.998 Y86.44 E.52884
G1 X92.929 Y89.509 E.13343
; LINE_WIDTH: 0.439793
G1 F9070.923
G1 X92.674 Y89.792 E.01232
; LINE_WIDTH: 0.490258
G1 F8047.616
G3 X91.837 Y90.651 I-8.031 J-6.98 E.04376
G1 X96.021 Y88.529 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X95.951 Y88.569 E.00242
G1 X96.009 Y88.602 E.002
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9726.05
G1 X95.951 Y88.569 E-.34436
G1 X96.021 Y88.529 E-.41564
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 3/30
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z.8 I.27 J1.187 P1  F30000
G1 X145.197 Y77.326 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X145.197 Y78.125 E.02651
G1 X151.416 Y78.125 E.20627
G1 X151.416 Y77.125 E.03317
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.266 E.00467
G1 X145.604 Y77.326 F30000
G1 F8843.478
G1 X145.604 Y77.718 E.01301
G1 X148.009 Y77.718 E.07975
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.266 E.01818
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
; WIPE_START
M204 S10000
G1 X147.616 Y77.326 E-.61602
G1 X147.616 Y76.947 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X144.644 Y77.289 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X144.864 Y77.509 E.00958
G1 X144.864 Y78.043 E.01643
G1 X144.28 Y77.459 E.02543
G1 X143.746 Y77.459 E.01643
G1 X159.061 Y92.774 E.66651
G1 X159.595 Y92.774 E.01643
G1 X145.28 Y78.459 E.62299
G1 X145.814 Y78.459 E.01643
G1 X160.129 Y92.774 E.62299
G1 X160.663 Y92.774 E.01643
G1 X146.348 Y78.459 E.62299
G1 X146.882 Y78.459 E.01643
G1 X161.197 Y92.774 E.62299
G1 X161.731 Y92.774 E.01643
G1 X147.416 Y78.459 E.62299
G1 X147.95 Y78.459 E.01643
G1 X162.265 Y92.774 E.62299
G1 X162.799 Y92.774 E.01643
G1 X148.484 Y78.459 E.62299
G1 X149.018 Y78.459 E.01643
G1 X163.333 Y92.774 E.62299
G1 X163.867 Y92.774 E.01643
G1 X149.552 Y78.459 E.62299
G1 X150.086 Y78.459 E.01643
G1 X164.401 Y92.774 E.62299
G1 X164.464 Y92.774 E.00193
G1 X164.464 Y92.303 E.01451
G1 X150.62 Y78.459 E.60248
G1 X151.154 Y78.459 E.01643
G1 X164.464 Y91.768 E.57923
G1 X164.464 Y91.234 E.01643
G1 X151.688 Y78.459 E.55599
G1 X151.749 Y78.459 E.00186
G1 X151.749 Y77.985 E.01457
G1 X164.464 Y90.7 E.55336
G1 X164.464 Y90.166 E.01643
G1 X151.757 Y77.459 E.55303
G1 X152.291 Y77.459 E.01643
G1 X164.464 Y89.632 E.52978
G1 X164.464 Y89.098 E.01643
G1 X152.825 Y77.459 E.50654
G1 X153.359 Y77.459 E.01643
G1 X164.464 Y88.564 E.4833
G1 X164.464 Y88.03 E.01643
G1 X153.893 Y77.459 E.46006
G1 X154.427 Y77.459 E.01643
G1 X164.464 Y87.496 E.43682
M73 P39 R16
G1 X164.464 Y86.962 E.01643
G1 X154.961 Y77.459 E.41357
G1 X155.495 Y77.459 E.01643
G1 X164.464 Y86.428 E.39033
G1 X164.464 Y85.894 E.01643
G1 X156.029 Y77.459 E.36709
G1 X156.563 Y77.459 E.01643
G1 X164.464 Y85.36 E.34385
G1 X164.464 Y84.826 E.01643
G1 X157.097 Y77.459 E.3206
G1 X157.631 Y77.459 E.01643
G1 X164.464 Y84.292 E.29736
G1 X164.464 Y83.758 E.01643
G1 X158.165 Y77.459 E.27412
G1 X158.699 Y77.459 E.01643
G1 X164.464 Y83.223 E.25088
G1 X164.464 Y82.689 E.01643
G1 X159.233 Y77.459 E.22764
G1 X159.767 Y77.459 E.01643
G1 X164.464 Y82.155 E.20439
G1 X164.464 Y81.621 E.01643
G1 X160.302 Y77.459 E.18115
G1 X160.836 Y77.459 E.01643
G1 X164.464 Y81.087 E.15791
G1 X164.464 Y80.553 E.01643
G1 X161.37 Y77.459 E.13467
G1 X161.904 Y77.459 E.01643
G1 X164.464 Y80.019 E.11143
G1 X164.464 Y79.485 E.01643
G1 X162.438 Y77.459 E.08818
G1 X162.972 Y77.459 E.01643
G1 X164.464 Y78.951 E.06494
G1 X164.464 Y78.417 E.01643
G1 X163.506 Y77.459 E.0417
G1 X164.04 Y77.459 E.01643
G1 X164.634 Y78.053 E.02584
G1 X158.696 Y92.944 F30000
G1 F9532.888
G1 X143.212 Y77.459 E.67389
G1 X143.149 Y77.459 E.00193
G1 X143.149 Y77.93 E.01451
G1 X157.993 Y92.774 E.64599
G1 X157.459 Y92.774 E.01643
G1 X143.149 Y78.464 E.62275
G1 X143.149 Y78.998 E.01643
G1 X156.925 Y92.774 E.59951
G1 X156.39 Y92.774 E.01643
G1 X143.149 Y79.532 E.57627
G1 X143.149 Y80.066 E.01643
G1 X155.856 Y92.774 E.55302
G1 X155.322 Y92.774 E.01643
G1 X143.149 Y80.6 E.52978
G1 X143.149 Y81.135 E.01643
G1 X154.788 Y92.774 E.50654
G1 X154.254 Y92.774 E.01643
G1 X143.149 Y81.669 E.4833
G1 X143.149 Y82.203 E.01643
G1 X153.72 Y92.774 E.46006
G1 X153.186 Y92.774 E.01643
G1 X143.149 Y82.737 E.43681
G1 X143.149 Y83.271 E.01643
G1 X152.652 Y92.774 E.41357
G1 X152.118 Y92.774 E.01643
G1 X143.149 Y83.805 E.39033
G1 X143.149 Y84.339 E.01643
G1 X151.584 Y92.774 E.36709
G1 X151.05 Y92.774 E.01643
G1 X143.149 Y84.873 E.34385
G1 X143.149 Y85.407 E.01643
G1 X150.516 Y92.774 E.3206
G1 X149.982 Y92.774 E.01643
G1 X143.149 Y85.941 E.29736
G1 X143.149 Y86.475 E.01643
G1 X149.448 Y92.774 E.27412
G1 X148.914 Y92.774 E.01643
G1 X143.149 Y87.009 E.25088
G1 X143.149 Y87.543 E.01643
G1 X148.38 Y92.774 E.22763
G1 X147.845 Y92.774 E.01643
G1 X143.149 Y88.077 E.20439
G1 X143.149 Y88.611 E.01643
G1 X147.311 Y92.774 E.18115
G1 X146.777 Y92.774 E.01643
G1 X143.149 Y89.145 E.15791
G1 X143.149 Y89.68 E.01643
G1 X146.243 Y92.774 E.13467
G1 X145.709 Y92.774 E.01643
G1 X143.149 Y90.214 E.11142
G1 X143.149 Y90.748 E.01643
G1 X145.175 Y92.774 E.08818
G1 X144.641 Y92.774 E.01643
G1 X143.149 Y91.282 E.06494
G1 X143.149 Y91.816 E.01643
G1 X144.107 Y92.774 E.0417
G1 X143.573 Y92.774 E.01643
G1 X142.979 Y92.18 E.02584
; WIPE_START
G1 X143.573 Y92.774 E-.31908
G1 X144.107 Y92.774 E-.20294
G1 X143.664 Y92.331 E-.23797
; WIPE_END
G1 E-.04 F1800
G1 X146.005 Y85.066 Z1 F30000
G1 X148.306 Y77.922 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X148.306 Y76.922 E.01538
; OBJECT_ID: 203
; WIPE_START
G1 X148.306 Y77.922 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X151.572 Y84.82 Z1 F30000
G1 X165.917 Y115.125 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z1 F30000
G1 X140.698 Y115.907 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.707 Y117.311 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.139 Y113.201 Z1 F30000
G1 X167.593 Y98.215 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.53 Y98.251 E.002
G1 X167.578 Y98.279 E.00151
G1 X167.593 Y115.945 F30000
G1 F10696.458
G1 X167.53 Y115.981 E.002
G1 X167.578 Y116.009 E.00151
G1 X147.906 Y115.911 F30000
; LINE_WIDTH: 0.452305
G1 F8793.689
G1 X147.889 Y116.067 E.00524
G1 X147.728 Y116.321 E.01003
G1 X166.92 Y116.321 E.64025
G2 X167.929 Y116.338 I.831 J-19.816 E.03367
G3 X167.913 Y115.329 I11.402 J-.692 E.03368
G1 X167.913 Y98.904 E.54794
G2 X167.929 Y97.895 I-19.816 J-.831 E.03367
G1 X166.92 Y97.911 E.03367
G1 X139.495 Y97.911 E.9149
G2 X138.486 Y97.895 I-.831 J19.816 E.03367
G1 X138.502 Y98.904 E.03367
G1 X138.502 Y115.121 E.54102
G1 X138.709 Y115.104 E.00692
G1 X138.86 Y114.713 E.01396
G1 X138.913 Y114.69 E.00193
G1 X138.913 Y98.904 E.52662
G1 X139.095 Y98.504 E.01466
G1 X139.394 Y98.327 E.01158
G1 X166.92 Y98.321 E.91827
G1 X167.32 Y98.504 E.01466
G1 X167.502 Y98.904 E.01466
G1 X167.502 Y115.329 E.54794
G1 X167.497 Y115.43 E.00338
G1 X167.32 Y115.729 E.01158
G1 X167.021 Y115.905 E.01158
G1 X166.92 Y115.911 E.00338
G1 X147.966 Y115.911 E.63231
G1 X147.512 Y115.518 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.103 Y115.515 E.03055
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.572 Y115.518 E.5945
; WIPE_START
G1 X149.572 Y115.518 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.555 Y109.027 Z1 F30000
G1 X138.864 Y98.215 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X138.801 Y98.251 E.002
G1 X138.848 Y98.279 E.00151
; OBJECT_ID: 269
; WIPE_START
G1 X138.801 Y98.251 E-.32672
G1 X138.864 Y98.215 E-.43328
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.144 Y104.534 Z1 F30000
G1 X176.182 Y153.302 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00076
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X173.462 Y160.781 E.02995
G1 X172.147 Y163.058 E.08722
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X161.638 Y172.275 E.11717
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X125.476 Y160 E.11717
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X126.791 Y133.836 E.08722
G1 X127.242 Y133.054 E.02995
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X148.831 Y121.111 E.02995
G1 X151.461 Y121.111 E.08722
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X162.42 Y124.289 E.02995
G1 X164.697 Y125.604 E.08722
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
M73 P40 R16
G1 X172.147 Y133.054 E.11717
G1 X173.913 Y136.113 E.11717
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.19 Y153.242 E.11443
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10696
G1 X173.561 Y159.826 E.10696
G1 X173.123 Y160.585 E.02695
G1 X171.821 Y162.84 E.08001
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X125.829 Y159.826 E.10696
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X127.131 Y134.032 E.08001
G1 X127.569 Y133.272 E.02695
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X137.925 Y124.19 E.10696
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X148.831 Y121.503 E.02695
G1 X151.435 Y121.503 E.08001
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X162.224 Y124.629 E.02695
G1 X164.479 Y125.931 E.08001
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.12 Y140.35 E.02695
G1 X175.794 Y142.865 E.08001
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.289 Y155.121 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z1 F30000
G1 X155.04 Y121.186 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.003 Y123.15 E.08981
G1 X161.812 Y123.485 E.02906
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X170.293 Y129.992 E.11888
G1 X172.474 Y132.835 E.11887
G1 X174.266 Y135.939 E.11888
G1 X175.302 Y138.44 E.08981
G1 X175.638 Y139.25 E.02906
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 3 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer3 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X161.812 Y172.628 E.11888
G1 X159.311 Y173.664 E.08981
G1 X158.501 Y173.999 E.02906
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y146.265 E.11887
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X124.788 Y136.749 E.08981
G1 X125.124 Y135.939 E.02906
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X131.631 Y127.458 E.11888
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X154.98 Y121.178 E.11689
M204 S250
G1 X155.113 Y120.8 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X155.116 Y120.801 E.00009
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X169.95 Y129.096 E.08398
G1 X170.588 Y129.733 E.02771
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X175.664 Y138.29 E.08398
G1 X176.01 Y139.124 E.02771
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X159.461 Y174.026 E.08398
G1 X158.628 Y174.371 E.02771
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.426 Y136.599 E.08398
G1 X124.771 Y135.765 E.02771
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X130.734 Y127.801 E.08398
G1 X131.372 Y127.163 E.02771
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X155.054 Y120.792 E.10976
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X155.116 Y120.801 E-.02393
G1 X156.987 Y121.302 E-.73607
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.738 Y126.843 Z1 F30000
G1 X116.764 Y163.76 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z1 F30000
G1 X100.964 Y139.541 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.617 Y143.137 Z1 F30000
G1 X117.641 Y165.379 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y165.415 E.002
G1 X117.625 Y165.443 E.00151
G1 X100.911 Y165.379 F30000
G1 F10696.458
G1 X100.848 Y165.415 E.002
G1 X100.895 Y165.443 E.00151
G1 X100.96 Y143.749 F30000
; LINE_WIDTH: 0.452293
G1 F8793.946
G1 X100.804 Y143.732 E.00524
G1 X100.55 Y143.571 E.01003
G1 X100.55 Y164.763 E.70695
G2 X100.533 Y165.772 I19.816 J.831 E.03367
G1 X101.542 Y165.756 E.03367
G1 X116.968 Y165.756 E.51457
G2 X117.977 Y165.772 I.831 J-19.816 E.03367
G3 X117.96 Y164.763 I11.402 J-.692 E.03368
G1 X117.96 Y138.338 E.88151
G2 X117.977 Y137.329 I-19.816 J-.831 E.03367
G1 X116.968 Y137.345 E.03367
G1 X101.75 Y137.345 E.50765
G1 X101.767 Y137.552 E.00692
G1 X102.158 Y137.703 E.01396
G1 X102.181 Y137.756 E.00193
G1 X116.968 Y137.756 E.49325
G1 X117.367 Y137.938 E.01466
G1 X117.55 Y138.338 E.01466
G1 X117.55 Y164.763 E.88151
G1 X117.544 Y164.864 E.00338
G1 X117.367 Y165.163 E.01158
G1 X117.069 Y165.34 E.01158
G1 X101.542 Y165.345 E.51794
G1 X101.142 Y165.163 E.01466
G1 X100.966 Y164.864 E.01158
G1 X100.96 Y164.763 E.00338
G1 X100.96 Y143.809 E.69901
G1 X101.354 Y143.355 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.243 Y142.13 Z1 F30000
G1 X117.641 Y137.649 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y137.686 E.002
G1 X117.625 Y137.713 E.00151
; OBJECT_ID: 214
; WIPE_START
G1 X117.578 Y137.686 E-.32669
G1 X117.641 Y137.649 E-.43331
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X110.249 Y139.55 Z1 F30000
G1 X94.746 Y143.538 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.746 Y146.757 E.10676
G1 X95.746 Y146.757 E.03317
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X94.806 Y143.538 E.03118
G1 X95.153 Y143.945 F30000
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
; WIPE_START
M204 S10000
G1 X95.545 Y145.957 E-.61602
G1 X95.924 Y145.957 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X95.582 Y142.084 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X94.988 Y141.49 E.02584
G1 X94.454 Y141.49 E.01643
G1 X95.413 Y142.448 E.0417
G1 X95.413 Y142.982 E.01643
G1 X93.92 Y141.49 E.06494
G1 X93.386 Y141.49 E.01643
G1 X95.101 Y143.205 E.07465
G1 X94.567 Y143.205 E.01643
G1 X92.852 Y141.49 E.07464
G1 X92.318 Y141.49 E.01643
G1 X94.413 Y143.584 E.09115
G1 X94.413 Y144.118 E.01643
G1 X91.784 Y141.49 E.11439
G1 X91.25 Y141.49 E.01643
G1 X94.413 Y144.652 E.13763
G1 X94.413 Y145.186 E.01643
G1 X90.716 Y141.49 E.16087
G1 X90.182 Y141.49 E.01643
G1 X94.413 Y145.72 E.18412
G1 X94.413 Y146.255 E.01643
G1 X89.648 Y141.49 E.20736
G1 X89.114 Y141.49 E.01643
G1 X95.413 Y147.789 E.27412
G1 X95.413 Y147.255 E.01643
G1 X95.078 Y146.92 E.01455
G1 X95.582 Y148.492 F30000
G1 F9532.888
G1 X88.58 Y141.49 E.30475
G1 X88.046 Y141.49 E.01643
G1 X95.413 Y148.857 E.3206
G1 X95.413 Y149.391 E.01643
G1 X87.512 Y141.49 E.34385
G1 X86.977 Y141.49 E.01643
G1 X95.413 Y149.925 E.36709
G1 X95.413 Y150.459 E.01643
G1 X86.443 Y141.49 E.39033
G1 X85.909 Y141.49 E.01643
G1 X95.413 Y150.993 E.41357
G1 X95.413 Y151.527 E.01643
M73 P41 R16
G1 X85.375 Y141.49 E.43682
G1 X84.841 Y141.49 E.01643
G1 X95.413 Y152.061 E.46006
G1 X95.413 Y152.595 E.01643
G1 X84.307 Y141.49 E.4833
G1 X83.773 Y141.49 E.01643
G1 X95.413 Y153.129 E.50654
G1 X95.413 Y153.663 E.01643
G1 X83.239 Y141.49 E.52978
G1 X82.705 Y141.49 E.01643
G1 X95.413 Y154.197 E.55303
G1 X95.413 Y154.731 E.01643
G1 X82.171 Y141.49 E.57627
G1 X81.637 Y141.49 E.01643
G1 X95.413 Y155.265 E.59951
G1 X95.413 Y155.8 E.01643
G1 X81.103 Y141.49 E.62275
G1 X80.569 Y141.49 E.01643
G1 X95.413 Y156.334 E.64599
G1 X95.413 Y156.868 E.01643
G1 X80.097 Y141.552 E.66651
G1 X80.097 Y142.086 E.01643
G1 X95.413 Y157.402 E.66651
G1 X95.413 Y157.936 E.01643
G1 X80.097 Y142.621 E.66651
G1 X80.097 Y143.155 E.01643
G1 X95.413 Y158.47 E.66651
G1 X95.413 Y159.004 E.01643
G1 X80.097 Y143.689 E.66651
G1 X80.097 Y144.223 E.01643
G1 X95.413 Y159.538 E.66651
G1 X95.413 Y160.072 E.01643
G1 X80.097 Y144.757 E.66651
G1 X80.097 Y145.291 E.01643
G1 X95.413 Y160.606 E.66651
G1 X95.413 Y161.14 E.01643
G1 X80.097 Y145.825 E.66651
G1 X80.097 Y146.359 E.01643
G1 X95.413 Y161.674 E.66651
G1 X95.413 Y162.208 E.01643
G1 X80.097 Y146.893 E.66651
G1 X80.097 Y147.427 E.01643
G1 X95.413 Y162.742 E.66651
G1 X95.413 Y162.805 E.00193
G1 X94.941 Y162.805 E.01451
G1 X80.097 Y147.961 E.64599
G1 X80.097 Y148.495 E.01643
G1 X94.407 Y162.805 E.62275
G1 X93.873 Y162.805 E.01643
G1 X80.097 Y149.029 E.59951
G1 X80.097 Y149.563 E.01643
G1 X93.339 Y162.805 E.57627
G1 X92.805 Y162.805 E.01643
G1 X80.097 Y150.097 E.55302
G1 X80.097 Y150.632 E.01643
G1 X92.271 Y162.805 E.52978
G1 X91.737 Y162.805 E.01643
G1 X80.097 Y151.166 E.50654
G1 X80.097 Y151.7 E.01643
G1 X91.203 Y162.805 E.4833
G1 X90.669 Y162.805 E.01643
G1 X80.097 Y152.234 E.46006
G1 X80.097 Y152.768 E.01643
G1 X90.135 Y162.805 E.43681
G1 X89.6 Y162.805 E.01643
G1 X80.097 Y153.302 E.41357
G1 X80.097 Y153.836 E.01643
G1 X89.066 Y162.805 E.39033
G1 X88.532 Y162.805 E.01643
G1 X80.097 Y154.37 E.36709
G1 X80.097 Y154.904 E.01643
G1 X87.998 Y162.805 E.34385
G1 X87.464 Y162.805 E.01643
G1 X80.097 Y155.438 E.3206
G1 X80.097 Y155.972 E.01643
G1 X86.93 Y162.805 E.29736
G1 X86.396 Y162.805 E.01643
G1 X80.097 Y156.506 E.27412
G1 X80.097 Y157.04 E.01643
G1 X85.862 Y162.805 E.25088
G1 X85.328 Y162.805 E.01643
G1 X80.097 Y157.574 E.22763
G1 X80.097 Y158.108 E.01643
G1 X84.794 Y162.805 E.20439
G1 X84.26 Y162.805 E.01643
G1 X80.097 Y158.642 E.18115
G1 X80.097 Y159.177 E.01643
G1 X83.726 Y162.805 E.15791
G1 X83.192 Y162.805 E.01643
G1 X80.097 Y159.711 E.13467
G1 X80.097 Y160.245 E.01643
G1 X82.658 Y162.805 E.11142
G1 X82.124 Y162.805 E.01643
G1 X80.097 Y160.779 E.08818
G1 X80.097 Y161.313 E.01643
G1 X81.589 Y162.805 E.06494
G1 X81.055 Y162.805 E.01643
G1 X80.097 Y161.847 E.0417
G1 X80.097 Y162.381 E.01643
G1 X80.691 Y162.975 E.02584
; OBJECT_ID: 236
; WIPE_START
G1 X80.097 Y162.381 E-.31908
G1 X80.097 Y161.847 E-.20294
G1 X80.54 Y162.29 E-.23797
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X82.932 Y155.042 Z1 F30000
G1 X96.313 Y114.504 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.78 E.10676
G1 X99.295 Y116.072 E.03317
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.07 Y110.261 E.03317
G1 X93.526 Y111.717 E.06831
G1 X96.27 Y114.461 E.12873
G1 X96.888 Y114.504 F30000
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X93.814 Y111.429 E.0548
G1 X94.346 Y111.961 E.02495
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.091 Y111.152 E.03872
G1 X94.346 Y111.407 E.01106
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.534 Y114.437 E.01538
G1 X94.413 Y112.316 F30000
G1 F15000
G1 X95.12 Y111.609 E.01538
; WIPE_START
G1 X94.413 Y112.316 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.971 Y108.223 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42565
G1 F9406.108
G1 X92.304 Y109.556 E.05878
G1 X92.033 Y109.827 E.01194
G1 X90.82 Y108.614 E.05349
G1 X90.55 Y108.885 E.01194
G1 X91.763 Y110.097 E.05349
G1 X91.599 Y110.261 E.00722
G1 X93.29 Y111.953 E.07461
G1 X98.588 Y117.251 E.23367
G1 X98.752 Y117.087 E.00722
G1 X105.622 Y123.957 E.30299
G1 X105.892 Y123.686 E.01194
G1 X99.023 Y116.816 E.30299
G1 X99.293 Y116.546 E.01194
G1 X106.283 Y123.535 E.30829
G1 X105.471 Y124.347 F30000
G1 F9406.108
G1 X90.279 Y109.155 E.67006
G1 X90.008 Y109.426 E.01194
G1 X105.081 Y124.498 E.66477
G1 X104.81 Y124.769 E.01194
G1 X89.738 Y109.696 E.66477
G1 X89.467 Y109.967 E.01194
G1 X104.539 Y125.039 E.66477
G1 X104.269 Y125.31 E.01194
G1 X89.197 Y110.238 E.66477
G1 X88.926 Y110.508 E.01194
G1 X103.998 Y125.58 E.66477
G1 X103.727 Y125.851 E.01194
G1 X88.655 Y110.779 E.66477
G1 X88.385 Y111.05 E.01194
G1 X103.457 Y126.122 E.66477
G1 X103.186 Y126.392 E.01194
G1 X88.114 Y111.32 E.66477
G1 X87.843 Y111.591 E.01194
G1 X102.916 Y126.663 E.66477
G1 X102.645 Y126.934 E.01194
G1 X87.573 Y111.862 E.66477
G1 X87.302 Y112.132 E.01194
G1 X102.374 Y127.204 E.66477
G1 X102.104 Y127.475 E.01194
G1 X87.031 Y112.403 E.66477
G1 X86.761 Y112.673 E.01194
G1 X101.833 Y127.746 E.66477
G1 X101.562 Y128.016 E.01194
G1 X86.49 Y112.944 E.66477
G1 X86.22 Y113.215 E.01194
G1 X101.292 Y128.287 E.66477
G1 X101.021 Y128.557 E.01194
G1 X85.949 Y113.485 E.66477
G1 X85.678 Y113.756 E.01194
G1 X100.75 Y128.828 E.66477
G1 X100.48 Y129.099 E.01194
G1 X85.408 Y114.027 E.66477
G1 X85.137 Y114.297 E.01194
G1 X100.209 Y129.369 E.66477
G1 X99.939 Y129.64 E.01194
G1 X84.866 Y114.568 E.66477
G1 X84.596 Y114.838 E.01194
G1 X99.668 Y129.911 E.66477
G1 X99.397 Y130.181 E.01194
G1 X84.325 Y115.109 E.66477
G1 X84.055 Y115.38 E.01194
G1 X99.127 Y130.452 E.66477
G1 X98.856 Y130.722 E.01194
G1 X83.784 Y115.65 E.66477
G1 X83.513 Y115.921 E.01194
G1 X98.585 Y130.993 E.66477
G1 X98.315 Y131.264 E.01194
G1 X83.243 Y116.192 E.66477
G1 X82.972 Y116.462 E.01194
G1 X98.044 Y131.534 E.66477
G1 X97.774 Y131.805 E.01194
G1 X82.701 Y116.733 E.66477
G1 X82.431 Y117.004 E.01194
G1 X97.503 Y132.076 E.66477
G1 X97.232 Y132.346 E.01194
G1 X82.16 Y117.274 E.66477
G1 X81.89 Y117.545 E.01194
G1 X96.962 Y132.617 E.66477
G1 X96.691 Y132.888 E.01194
G1 X81.619 Y117.815 E.66477
G1 X81.348 Y118.086 E.01194
G1 X96.42 Y133.158 E.66477
G1 X96.15 Y133.429 E.01194
G1 X81.078 Y118.357 E.66477
G1 X80.807 Y118.627 E.01194
G1 X95.879 Y133.699 E.66477
G1 X95.608 Y133.97 E.01194
G1 X80.536 Y118.898 E.66477
G1 X80.266 Y119.169 E.01194
G1 X95.458 Y134.361 E.67006
; OBJECT_ID: 181
; WIPE_START
G1 X94.044 Y132.946 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X101.266 Y130.478 Z1 F30000
G1 X130.791 Y120.389 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X106.588 Y109.21 E.13299
G1 X113.666 Y102.133 E.33202
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X106.876 Y109.498 E.11949
G1 X113.666 Y102.709 E.31852
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X107.153 Y109.775 E.09863
G1 X113.666 Y103.263 E.283
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z1 F30000
G1 X101.799 Y111.197 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
M73 P42 R16
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
M73 P42 R15
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.72 Y114.099 Z1 F30000
G1 X132.588 Y119.787 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.525 Y119.823 E.002
G1 X132.572 Y119.851 E.00151
G1 X121.465 Y130.91 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.402 Y130.946 E.002
G1 X121.45 Y130.974 E.00151
G1 X104.759 Y114.162 F30000
; LINE_WIDTH: 0.452271
G1 F8794.426
G1 X104.636 Y114.26 E.00524
G1 X104.343 Y114.326 E.01003
G1 X120.742 Y130.725 E.77362
G2 X121.444 Y131.451 I14.602 J-13.428 E.03367
G3 X122.146 Y130.725 I8.557 J7.578 E.03367
G1 X132.346 Y120.525 E.48118
G2 X133.071 Y119.823 I-13.416 J-14.591 E.03367
G1 X132.346 Y119.122 E.03366
G1 X114.368 Y101.143 E.84811
G2 X113.666 Y100.418 I-14.602 J13.428 E.03367
G1 X112.964 Y101.143 E.03366
G1 X102.911 Y111.197 E.47426
G1 X103.069 Y111.331 E.00692
G1 X103.452 Y111.161 E.01396
G1 X103.506 Y111.182 E.00193
G1 X113.254 Y101.433 E.45986
G1 X113.666 Y101.279 E.01466
G1 X114.078 Y101.433 E.01466
G1 X132.056 Y119.412 E.84811
G1 X132.21 Y119.823 E.01466
G1 X132.123 Y120.16 E.01158
G1 X121.856 Y130.435 E.48456
G1 X121.78 Y130.503 E.00338
G1 X121.444 Y130.589 E.01158
G1 X121.108 Y130.503 E.01158
G1 X121.032 Y130.435 E.00338
G1 X104.801 Y114.204 E.76568
G1 X104.759 Y113.605 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.432 Y113.924 E.01402
G1 X104.315 Y113.95 E.0037
G1 X104.18 Y113.896 E.00446
G1 X103.768 Y114.308 E.01791
G1 X121.444 Y131.984 E.76809
G1 X133.605 Y119.823 E.52842
G1 X113.666 Y99.885 E.86641
G1 X102.354 Y111.197 E.49155
G1 X103.057 Y111.9 E.03055
G1 X103.366 Y111.593 E.01338
G1 X103.472 Y111.554 E.00346
G1 X103.635 Y111.609 E.00531
G1 X113.533 Y101.712 E.43007
G1 X113.666 Y101.656 E.00443
G1 X113.799 Y101.712 E.00443
G1 X131.778 Y119.69 E.78123
G1 X131.833 Y119.823 E.00443
G3 X131.778 Y119.957 I-.188 J0 E.00455
G1 X121.577 Y130.157 E.44324
G1 X121.444 Y130.212 E.00443
G1 X121.311 Y130.157 E.00443
G1 X104.801 Y113.647 E.7174
; WIPE_START
G1 X106.215 Y115.062 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.774 Y108.31 Z1 F30000
G1 X113.687 Y100.886 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X113.624 Y100.923 E.002
G1 X113.671 Y100.95 E.00151
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.32668
G1 X113.687 Y100.886 E-.43332
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.866 Y98.294 Z1 F30000
G1 X135.594 Y92.974 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.241 Y93.096 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42565
G1 F9406.108
G1 X120.049 Y77.904 E.67006
G1 X119.778 Y78.175 E.01194
G1 X134.85 Y93.247 E.66477
G1 X134.579 Y93.517 E.01194
G1 X119.507 Y78.445 E.66477
G1 X119.237 Y78.716 E.01194
G1 X134.309 Y93.788 E.66477
G1 X134.038 Y94.059 E.01194
G1 X118.966 Y78.987 E.66477
G1 X118.695 Y79.257 E.01194
G1 X133.768 Y94.329 E.66477
G1 X133.497 Y94.6 E.01194
G1 X118.425 Y79.528 E.66477
G1 X118.154 Y79.799 E.01194
G1 X133.226 Y94.871 E.66477
G1 X132.956 Y95.141 E.01194
G1 X117.884 Y80.069 E.66477
G1 X117.613 Y80.34 E.01194
G1 X132.685 Y95.412 E.66477
G1 X132.414 Y95.683 E.01194
G1 X117.342 Y80.61 E.66477
G1 X117.072 Y80.881 E.01194
G1 X132.144 Y95.953 E.66477
G1 X131.873 Y96.224 E.01194
G1 X116.801 Y81.152 E.66477
G1 X116.53 Y81.422 E.01194
G1 X131.603 Y96.494 E.66477
G1 X131.332 Y96.765 E.01194
G1 X116.26 Y81.693 E.66477
G1 X115.989 Y81.964 E.01194
G1 X131.061 Y97.036 E.66477
G1 X130.791 Y97.306 E.01194
G1 X115.719 Y82.234 E.66477
G1 X115.448 Y82.505 E.01194
G1 X130.52 Y97.577 E.66477
G1 X130.249 Y97.848 E.01194
G1 X115.177 Y82.775 E.66477
G1 X114.907 Y83.046 E.01194
G1 X129.979 Y98.118 E.66477
G1 X129.708 Y98.389 E.01194
G1 X114.636 Y83.317 E.66477
G1 X114.365 Y83.587 E.01194
G1 X129.437 Y98.659 E.66477
G1 X129.167 Y98.93 E.01194
G1 X114.095 Y83.858 E.66477
G1 X113.824 Y84.129 E.01194
G1 X128.896 Y99.201 E.66477
G1 X128.626 Y99.471 E.01194
G1 X113.553 Y84.399 E.66477
G1 X113.283 Y84.67 E.01194
G1 X128.355 Y99.742 E.66477
G1 X128.084 Y100.013 E.01194
G1 X113.012 Y84.941 E.66477
G1 X112.742 Y85.211 E.01194
G1 X127.814 Y100.283 E.66477
G1 X127.543 Y100.554 E.01194
G1 X112.471 Y85.482 E.66477
G1 X112.2 Y85.752 E.01194
G1 X127.272 Y100.825 E.66477
G1 X127.002 Y101.095 E.01194
G1 X111.93 Y86.023 E.66477
G1 X111.659 Y86.294 E.01194
G1 X126.731 Y101.366 E.66477
G1 X126.461 Y101.636 E.01194
G1 X111.388 Y86.564 E.66477
G1 X111.118 Y86.835 E.01194
G1 X126.19 Y101.907 E.66477
G1 X125.919 Y102.178 E.01194
G1 X110.847 Y87.106 E.66477
G1 X110.577 Y87.376 E.01194
G1 X125.649 Y102.448 E.66477
G1 X125.378 Y102.719 E.01194
G1 X110.306 Y87.647 E.66477
G1 X110.035 Y87.917 E.01194
G1 X125.107 Y102.99 E.66477
G1 X124.837 Y103.26 E.01194
G1 X109.765 Y88.188 E.66477
G1 X109.494 Y88.459 E.01194
G1 X124.566 Y103.531 E.66477
G1 X124.295 Y103.801 E.01194
G1 X109.103 Y88.609 E.67006
; OBJECT_ID: 258
; WIPE_START
G1 X110.518 Y90.024 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X105.631 Y95.887 Z1 F30000
G1 X100.257 Y102.335 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.007 Y102.162 E.01009
G3 X101.4 Y97.321 I1.655 J-2.145 E.21455
G3 X103.01 Y97.667 I.247 J2.766 E.05546
G3 X100.31 Y102.364 I-1.348 J2.35 E.28245
G1 X100.483 Y101.997 F30000
G1 F8843.478
G1 X100.256 Y101.837 E.0092
G3 X101.427 Y97.727 I1.405 J-1.822 E.18179
G3 X102.536 Y97.887 I.241 J2.25 E.03757
G3 X100.537 Y102.022 I-.874 J2.128 E.24901
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.452 Y98.118 I.959 J-1.65 E.14693
G3 X102.149 Y98.17 I.196 J2.076 E.02156
G3 X100.754 Y101.695 I-.488 J1.845 E.19814
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11763
G1 X100.303 Y101.366 E-.09495
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09496
G1 X99.76 Y100.265 E-.09497
G1 X99.748 Y100.074 E-.07259
; WIPE_END
G1 E-.04 F1800
G1 X97.215 Y93.579 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.207 Y93.647 E.00226
G3 X94.329 Y90.25 I-2.616 J-.702 E.39116
G3 X95.939 Y90.596 I.247 J2.767 E.05546
G3 X97.276 Y93.299 I-1.348 J2.349 E.10609
G1 X97.228 Y93.521 E.00754
M73 P43 R15
G1 X96.816 Y93.5 F30000
G1 F8843.478
G1 X96.805 Y93.539 E.00136
G3 X92.488 Y91.997 I-2.221 J-.595 E.25207
G3 X94.356 Y90.656 I2.101 J.955 E.07986
G3 X96.863 Y93.244 I.228 J2.288 E.13738
G1 X96.827 Y93.441 E.00663
M204 S250
G1 X96.432 Y93.424 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X96.433 Y93.44 E.00051
G3 X94.381 Y91.047 I-1.843 J-.496 E.25453
G3 X95.078 Y91.099 I.196 J2.076 E.02156
G3 X96.482 Y93.194 I-.488 J1.845 E.08468
G1 X96.445 Y93.365 E.00537
; WIPE_START
M204 S10000
G1 X96.433 Y93.44 E-.02879
G1 X96.348 Y93.675 E-.09509
G1 X96.238 Y93.899 E-.09498
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09498
G1 X95.149 Y94.765 E-.06634
; WIPE_END
G1 E-.04 F1800
G1 X102.493 Y96.842 Z1 F30000
G1 X108.713 Y98.601 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X108.248 Y98.136 E.57468
G1 X108.67 Y98.559 E.01982
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X108.535 Y97.848 E.58818
G1 X109.246 Y98.559 E.03332
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X108.813 Y97.571 E.55688
G1 X109.8 Y98.559 E.04292
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.67 Y103.594 Z1 F30000
G1 X100.263 Y104.351 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X100.194 Y104.391 E.00242
G1 X100.251 Y104.424 E.002
G1 X104.137 Y102.579 F30000
; LINE_WIDTH: 0.50575
G1 F7778.234
G1 X104.738 Y101.942 E.03303
; LINE_WIDTH: 0.512232
G1 F7670.809
G1 X104.961 Y101.745 E.01138
; LINE_WIDTH: 0.475335
G1 F8325.335
G1 X105.184 Y101.549 E.01048
; LINE_WIDTH: 0.420204
G1 F9541.901
G1 X105.407 Y101.352 E.00915
G1 X108.158 Y98.601 E.11959
G1 X95.998 Y86.44 E.52872
G1 X92.929 Y89.509 E.1334
; LINE_WIDTH: 0.43979
G1 F9070.98
G1 X92.674 Y89.792 E.01232
; LINE_WIDTH: 0.490493
G1 F8043.395
G3 X91.795 Y90.694 I-8.427 J-7.338 E.04597
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X91.509 Y90.954 E.01356
; LINE_WIDTH: 0.420257
G1 F9540.562
G1 X91.224 Y91.214 E.01188
G1 X88.08 Y94.358 E.13671
G1 X100.24 Y106.519 E.52879
G1 X102.991 Y103.768 E.11961
; LINE_WIDTH: 0.43862
G1 F9097.802
G1 X103.247 Y103.486 E.01229
; LINE_WIDTH: 0.483959
G1 F8162.556
G3 X104.094 Y102.621 I8.061 J7.052 E.04355
G1 X106.053 Y98.561 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X105.984 Y98.601 E.00242
G1 X106.041 Y98.634 E.002
G1 X96.021 Y88.533 F30000
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X95.95 Y88.574 E.00251
G1 X96.01 Y88.608 E.00212
G1 X100.194 Y94.362 F30000
; LINE_WIDTH: 0.52512
G1 F7465.782
G2 X100.194 Y94.466 I-.024 J.052 E.00906
G1 X99.489 Y95.109 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.115 Y94.877 E.0205
G3 X101.063 Y94.705 I1.343 J4.706 E.02966
G1 X99.896 Y93.539 E.05069
G1 X99.841 Y93.959 E.01302
G1 X99.644 Y94.694 E.02338
G1 X99.51 Y95.053 E.01178
G1 X99.745 Y97.57 F30000
; LINE_WIDTH: 0.419989
G1 F9547.326
G1 X100.445 Y97.159 E.02493
G1 X100.878 Y97.011 E.01407
G1 X101.63 Y96.913 E.0233
G1 X102.433 Y97.012 E.02488
G1 X103.184 Y97.316 E.02488
G1 X103.831 Y97.804 E.02488
G1 X104.329 Y98.443 E.02488
G1 X104.64 Y99.177 E.02449
G1 X104.757 Y99.991 E.02526
G1 X104.657 Y100.794 E.02489
; LINE_WIDTH: 0.440358
G1 F9058.028
G1 X104.524 Y101.178 E.01314
; LINE_WIDTH: 0.48782
G1 F8091.721
G1 X104.391 Y101.561 E.01471
G1 X103.889 Y102.21 E.02974
; LINE_WIDTH: 0.505755
G1 F7778.15
G1 X103.261 Y102.733 E.03085
; LINE_WIDTH: 0.512232
G1 F7670.809
G1 X103.001 Y102.824 E.01052
; LINE_WIDTH: 0.475335
G1 F8325.335
G1 X102.741 Y102.915 E.0097
; LINE_WIDTH: 0.420572
G1 F9532.594
G1 X102.481 Y103.005 E.00847
G1 X101.679 Y103.117 E.02492
G1 X100.875 Y103.018 E.02492
G1 X100.125 Y102.714 E.02492
G1 X99.478 Y102.226 E.02492
G1 X98.98 Y101.588 E.02492
G1 X98.664 Y100.842 E.02492
G1 X98.552 Y100.04 E.02492
G1 X98.651 Y99.236 E.02492
G1 X98.929 Y98.551 E.02276
G1 X99.197 Y98.119 E.01565
G1 X99.703 Y97.613 E.02202
G1 X99.212 Y97.036 F30000
; LINE_WIDTH: 0.41999
G1 F9547.303
G1 X99.408 Y96.886 E.00759
G1 X100.068 Y96.505 E.02339
G1 X100.6 Y96.306 E.01746
G1 X101.532 Y96.165 E.02897
G1 X102.532 Y96.265 E.03088
G1 X103.473 Y96.62 E.0309
G1 X103.686 Y96.743 E.00756
G1 X104.29 Y97.206 E.02338
G1 X104.464 Y97.38 E.00756
G1 X104.927 Y97.984 E.02338
G1 X105.336 Y98.888 E.03051
G1 X105.405 Y99.138 E.00795
G1 X105.504 Y99.892 E.02338
G1 X105.497 Y100.196 E.00934
G1 X107.092 Y98.601 E.0693
G1 X95.998 Y87.507 E.48208
G1 X94.403 Y89.102 E.0693
G1 X95.025 Y89.113 E.01914
G1 X95.802 Y89.303 E.02457
G1 X96.17 Y89.434 E.01201
G1 X96.829 Y89.815 E.02338
G1 X97.025 Y89.965 E.00756
G1 X97.563 Y90.503 E.02339
G1 X98.093 Y91.357 E.0309
G1 X98.384 Y92.32 E.03089
G1 X98.416 Y93.325 E.0309
G3 X98.137 Y94.446 I-7.576 J-1.294 E.03553
G1 X97.713 Y95.19 E.02633
G1 X97.563 Y95.385 E.00756
G1 X97.025 Y95.924 E.02338
G3 X96.17 Y96.454 I-4.422 J-6.17 E.03092
G3 X94.964 Y96.777 I-2.167 J-5.675 E.03844
G1 X94.203 Y96.777 E.02339
G1 X93.642 Y96.684 E.01746
G1 X93.047 Y96.476 E.01937
G1 X92.329 Y96.069 E.02536
G1 X91.604 Y95.386 E.03061
G1 X91.073 Y94.531 E.0309
G1 X90.782 Y93.569 E.03089
G1 X90.75 Y92.754 E.02504
G1 X89.146 Y94.358 E.06971
G1 X100.24 Y105.452 E.48208
G1 X101.835 Y103.857 E.06931
G1 X101.531 Y103.865 E.00934
G1 X100.777 Y103.766 E.02339
G1 X99.836 Y103.411 E.03089
G1 X99.623 Y103.288 E.00756
G1 X99.019 Y102.825 E.02338
G1 X98.845 Y102.651 E.00756
G1 X98.382 Y102.047 E.02339
G1 X97.968 Y101.13 E.0309
G1 X97.804 Y100.138 E.0309
G1 X97.904 Y99.138 E.0309
G1 X97.98 Y98.871 E.00853
G1 X98.259 Y98.197 E.02241
G1 X98.559 Y97.714 E.01747
G1 X99.171 Y97.08 E.02708
G1 X98.946 Y96.77 F30000
; LINE_WIDTH: 0.419279
G1 F9565.357
G1 X99.22 Y96.559 E.01059
G1 X99.879 Y96.179 E.02334
G1 X100.478 Y95.949 E.01969
G1 X101.483 Y95.791 E.03119
G1 X101.827 Y95.791 E.01054
G1 X102.581 Y95.891 E.02334
G1 X102.914 Y95.98 E.01057
G1 X103.617 Y96.272 E.02334
G1 X103.91 Y96.45 E.01053
; LINE_WIDTH: 0.374335
G1 F10862.522
G1 X104.499 Y96.933 E.02056
G1 X104.737 Y97.171 E.00907
G1 X105.22 Y97.759 E.02056
; LINE_WIDTH: 0.419271
G1 F9565.559
G1 X105.398 Y98.053 E.01054
G1 X105.69 Y98.756 E.02334
G1 X105.813 Y99.347 E.01851
G1 X106.558 Y98.601 E.03233
G1 X105.765 Y97.808 E.03441
; LINE_WIDTH: 0.40346
G1 F9985.022
G1 X105.367 Y97.387 E.01701
; LINE_WIDTH: 0.376004
G1 F10808.088
G2 X104.148 Y96.179 I-12.566 J11.471 E.0466
; LINE_WIDTH: 0.417268
G1 F9616.738
G3 X98.293 Y90.312 I307.865 J-313.034 E.25285
; LINE_WIDTH: 0.381436
G1 F10634.675
G2 X96.666 Y88.708 I-22.372 J21.086 E.06304
; LINE_WIDTH: 0.416764
G1 F9629.695
G1 X95.998 Y88.04 E.02878
G1 X95.265 Y88.772 E.03154
G3 X96.359 Y89.108 I-1.158 J5.724 E.0349
G1 X97.01 Y89.503 E.02319
; LINE_WIDTH: 0.373424
G1 F10892.469
G1 X97.808 Y90.257 E.02959
G1 X98.024 Y90.518 E.00912
; LINE_WIDTH: 0.417562
G1 F9609.185
G1 X98.42 Y91.169 E.02324
G1 X98.551 Y91.487 E.01052
G1 X98.748 Y92.222 E.02323
G1 X98.793 Y92.564 E.01052
G1 X98.793 Y93.325 E.02324
G3 X98.481 Y94.6 I-7.082 J-1.06 E.04014
G1 X98.039 Y95.379 E.02733
G1 X97.829 Y95.652 E.01052
G1 X97.291 Y96.19 E.02323
G1 X97.018 Y96.4 E.01052
G1 X96.359 Y96.78 E.02324
G1 X95.649 Y97.017 E.02283
G1 X94.964 Y97.154 E.02134
G1 X94.203 Y97.154 E.02324
G1 X93.568 Y97.054 E.0196
G1 X92.916 Y96.829 E.02108
G1 X92.146 Y96.378 E.02723
; LINE_WIDTH: 0.372708
G1 F10916.101
G1 X91.358 Y95.631 E.02917
G1 X91.143 Y95.37 E.0091
; LINE_WIDTH: 0.41431
G1 F9693.314
G1 X90.747 Y94.72 E.02305
G3 X90.413 Y93.625 I7.414 J-2.862 E.03466
G1 X89.679 Y94.358 E.03139
G3 X90.873 Y95.577 I-26.133 J26.801 E.05163
; LINE_WIDTH: 0.380954
G1 F10649.82
G2 X92.418 Y97.097 I19.685 J-18.458 E.05972
; LINE_WIDTH: 0.419985
G1 F9547.426
G1 X97.544 Y102.223 E.22273
; LINE_WIDTH: 0.40346
G1 F9985.022
G1 X97.941 Y102.644 E.01701
; LINE_WIDTH: 0.376011
G1 F10807.878
G2 X99.161 Y103.851 I12.563 J-11.468 E.0466
; LINE_WIDTH: 0.416943
G1 F9625.075
G3 X100.24 Y104.919 I-75.137 J77.019 E.04627
G1 X100.986 Y104.174 E.03214
G1 X100.395 Y104.05 E.0184
G1 X99.692 Y103.758 E.02319
G1 X99.398 Y103.581 E.01046
; LINE_WIDTH: 0.374344
G1 F10862.245
G1 X98.81 Y103.098 E.02056
G1 X98.572 Y102.86 E.00907
G1 X98.089 Y102.271 E.02057
; LINE_WIDTH: 0.419525
G1 F9559.092
G1 X97.91 Y101.978 E.01054
G1 X97.619 Y101.275 E.02336
G1 X97.53 Y100.942 E.01057
G1 X97.431 Y100.188 E.02336
G1 X97.431 Y99.843 E.01058
G1 X97.53 Y99.088 E.02335
G1 X97.631 Y98.726 E.01154
G1 X97.91 Y98.053 E.02238
G1 X98.246 Y97.505 E.01971
G1 X98.905 Y96.813 E.02932
G1 X98.588 Y96.01 F30000
; LINE_WIDTH: 0.508986
G1 F7724.233
G2 X97.763 Y96.836 I409.903 J410.872 E.04434
G1 X98.588 Y96.01 F30000
; LINE_WIDTH: 0.511215
G1 F7687.463
G1 X98.893 Y95.849 E.01315
; LINE_WIDTH: 0.474725
G1 F8337.097
G1 X99.197 Y95.687 E.01213
; LINE_WIDTH: 0.421952
G1 F9497.891
G3 X100.633 Y95.142 I2.638 J4.785 E.0476
G1 X101.385 Y95.044 E.02342
G1 X101.926 Y95.04 E.01669
G2 X99.547 Y92.657 I-184.105 J181.321 E.10399
G1 X99.547 Y93.325 E.02063
G1 X99.477 Y93.862 E.01672
G1 X99.28 Y94.596 E.0235
G1 X99.073 Y95.097 E.01672
G1 X98.706 Y95.764 E.02352
; LINE_WIDTH: 0.471605
G1 F8397.775
G1 X98.66 Y95.86 E.00372
; LINE_WIDTH: 0.510175
G1 F7704.572
G1 X98.614 Y95.956 E.00406
G1 X98.144 Y97.037 F30000
; LINE_WIDTH: 0.41999
G1 F9547.313
G1 X98.681 Y96.502 E.02329
G1 X99.031 Y96.233 E.01357
G1 X99.69 Y95.852 E.02339
G3 X101.434 Y95.417 I2.055 J4.526 E.05552
G1 X101.876 Y95.418 E.01357
G1 X102.63 Y95.517 E.02338
G1 X103.055 Y95.631 E.0135
G1 X98.953 Y91.529 E.17823
G3 X99.17 Y92.564 I-3.819 J1.342 E.03257
G1 X99.17 Y93.325 E.02339
G1 X99.113 Y93.764 E.01361
G1 X98.916 Y94.499 E.02338
G1 X98.746 Y94.908 E.01361
G1 X98.366 Y95.567 E.02339
G1 X98.096 Y95.919 E.01361
G1 X97.558 Y96.457 E.02338
G1 X97.206 Y96.726 E.01361
G1 X96.547 Y97.107 E.02339
G1 X96.107 Y97.285 E.01458
G1 X95.403 Y97.473 E.0224
G1 X94.964 Y97.531 E.01361
G1 X94.203 Y97.531 E.02339
G3 X93.223 Y97.368 I1.144 J-9.914 E.03054
G1 X97.27 Y101.416 E.17586
G1 X97.156 Y100.991 E.01349
G1 X97.057 Y100.237 E.02338
G1 X97.057 Y99.794 E.01361
G1 X97.156 Y99.039 E.02338
G1 X97.283 Y98.582 E.01458
G1 X97.562 Y97.908 E.02241
G3 X98.108 Y97.085 I3.527 J1.744 E.03043
G1 X97.699 Y96.892 F30000
; LINE_WIDTH: 0.481153
G1 F8214.818
G1 X97.443 Y97.032 E.01042
; LINE_WIDTH: 0.420719
G1 F9528.884
G2 X96.736 Y97.434 I8.907 J16.532 E.02504
G1 X96.236 Y97.641 E.01667
G1 X95.501 Y97.838 E.02342
G1 X94.964 Y97.908 E.01667
G1 X94.296 Y97.908 E.02057
G2 X96.679 Y100.286 I186.209 J-184.235 E.10365
G1 X96.683 Y99.744 E.01669
G1 X96.782 Y98.99 E.02343
G1 X96.922 Y98.467 E.01667
G1 X97.214 Y97.764 E.02343
G1 X97.537 Y97.205 E.01987
; LINE_WIDTH: 0.443385
G1 F8989.549
G1 X97.604 Y97.075 E.00477
; LINE_WIDTH: 0.482155
G1 F8196.068
G1 X97.671 Y96.945 E.00524
G1 X96.783 Y97.819 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X96.303 Y98.013 E.01592
G1 X95.598 Y98.202 E.0224
G1 X95.178 Y98.257 E.01302
G1 X96.345 Y99.424 E.0507
G1 X96.469 Y98.635 E.02455
G1 X96.761 Y97.875 E.02502
G1 X96.083 Y98.473 F30000
; LINE_WIDTH: 0.52524
G1 F7463.924
G2 X96.084 Y98.577 I-.024 J.052 E.00907
G1 X96.761 Y95.654 F30000
; LINE_WIDTH: 0.41999
G1 F9547.306
G1 X96.043 Y96.092 E.02586
G1 X95.815 Y96.192 E.00765
G1 X95.11 Y96.381 E.0224
G1 X94.203 Y96.4 E.02789
G1 X93.629 Y96.29 E.01796
G1 X93.088 Y96.079 E.01784
G1 X92.521 Y95.744 E.02023
G1 X91.871 Y95.119 E.02771
G1 X91.4 Y94.342 E.0279
G1 X91.147 Y93.471 E.02789
G1 X91.127 Y92.564 E.02789
G1 X91.238 Y91.99 E.01796
G1 X91.389 Y91.582 E.01337
G1 X88.613 Y94.358 E.12065
G1 X100.24 Y105.986 E.50525
G1 X103.047 Y103.179 E.12195
G1 X102.483 Y103.392 E.01852
G1 X101.728 Y103.491 E.02339
G1 X100.826 Y103.392 E.02789
G1 X99.98 Y103.062 E.02788
G1 X99.249 Y102.525 E.02789
G1 X98.681 Y101.817 E.02789
G1 X98.316 Y100.986 E.02789
G1 X98.178 Y100.089 E.02789
G1 X98.278 Y99.187 E.02789
G1 X98.58 Y98.406 E.02572
G1 X98.873 Y97.924 E.01734
G1 X99.479 Y97.303 E.02665
G1 X100.256 Y96.832 E.02793
G1 X100.758 Y96.652 E.01638
G1 X101.581 Y96.539 E.02553
G1 X102.483 Y96.638 E.02788
G1 X103.328 Y96.968 E.02789
G1 X104.06 Y97.505 E.02789
G1 X104.628 Y98.213 E.02789
G1 X104.988 Y99.033 E.0275
G1 X105.13 Y99.941 E.02827
G1 X105.031 Y100.844 E.02789
G1 X104.818 Y101.407 E.01852
G1 X107.625 Y98.601 E.12195
G1 X95.998 Y86.974 E.50525
G1 X93.231 Y89.74 E.1202
G1 X93.758 Y89.566 E.01704
G1 X94.51 Y89.468 E.0233
G1 X95.11 Y89.507 E.01848
G1 X95.845 Y89.704 E.02339
G1 X96.641 Y90.141 E.02789
G1 X97.296 Y90.77 E.02789
G1 X97.767 Y91.546 E.02789
G1 X98.02 Y92.417 E.02788
G1 X98.039 Y93.325 E.0279
G3 X97.767 Y94.342 I-7.065 J-1.347 E.0324
G1 X97.386 Y95.002 E.02339
G1 X96.803 Y95.61 E.0259
G1 X96.495 Y95.387 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X95.854 Y95.766 E.02286
G3 X94.964 Y96.023 I-2.482 J-6.917 E.02849
G1 X94.203 Y96.023 E.02339
G3 X92.713 Y95.419 I.538 J-3.47 E.04984
G1 X92.137 Y94.852 E.02482
G1 X91.727 Y94.154 E.02489
G1 X91.511 Y93.373 E.02488
G1 X91.504 Y92.564 E.02488
G3 X91.773 Y91.641 I2.855 J.33 E.02968
; LINE_WIDTH: 0.437035
G1 F9134.389
G1 X91.926 Y91.348 E.01059
; LINE_WIDTH: 0.484424
G1 F8153.955
G1 X92.079 Y91.056 E.01186
G1 X92.65 Y90.473 E.02937
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X93.012 Y90.28 E.01438
; LINE_WIDTH: 0.42078
G1 F9527.341
G3 X93.807 Y89.94 I1.436 J2.26 E.02675
G1 X94.559 Y89.842 E.02334
G1 X95.013 Y89.872 E.014
G1 X95.748 Y90.069 E.02343
G1 X96.452 Y90.468 E.02493
G1 X97.029 Y91.036 E.02494
G1 X97.44 Y91.734 E.02494
G1 X97.656 Y92.515 E.02493
G1 X97.662 Y93.325 E.02494
G3 X97.44 Y94.154 I-11.814 J-2.721 E.02644
G1 X97.059 Y94.813 E.02343
G1 X96.537 Y95.344 E.02295
; WIPE_START
G1 X97.059 Y94.813 E-.28322
G1 X97.44 Y94.154 E-.2892
G1 X97.568 Y93.677 E-.18758
; WIPE_END
G1 E-.04 F1800
G1 X90.237 Y94.317 Z1 F30000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X90.166 Y94.358 E.00251
G1 X90.226 Y94.393 E.00212
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9534.908
G1 X90.166 Y94.358 E-.34773
G1 X90.237 Y94.317 E-.41227
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 4/30
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S183.6
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z1 I.359 J1.163 P1  F30000
G1 X145.197 Y77.326 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X145.197 Y78.125 E.02651
G1 X151.416 Y78.125 E.20627
G1 X151.416 Y77.125 E.03317
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.266 E.00467
G1 X145.604 Y77.326 F30000
G1 F8843.478
G1 X145.604 Y77.718 E.01301
G1 X148.009 Y77.718 E.07975
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.266 E.01818
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
; WIPE_START
M204 S10000
G1 X147.616 Y77.326 E-.61602
G1 X147.616 Y76.947 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X143.743 Y77.289 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X143.149 Y77.883 E.02584
G1 X143.149 Y78.417 E.01643
G1 X144.107 Y77.459 E.0417
G1 X144.641 Y77.459 E.01643
G1 X143.149 Y78.951 E.06494
G1 X143.149 Y79.485 E.01643
G1 X144.864 Y77.77 E.07465
G1 X144.864 Y78.304 E.01643
G1 X143.149 Y80.019 E.07464
G1 X143.149 Y80.553 E.01643
G1 X145.243 Y78.459 E.09115
G1 X145.777 Y78.459 E.01643
G1 X143.149 Y81.087 E.11439
G1 X143.149 Y81.621 E.01643
G1 X146.311 Y78.459 E.13763
G1 X146.845 Y78.459 E.01643
G1 X143.149 Y82.155 E.16087
G1 X143.149 Y82.689 E.01643
G1 X147.38 Y78.459 E.18412
G1 X147.914 Y78.459 E.01643
G1 X143.149 Y83.223 E.20736
G1 X143.149 Y83.758 E.01643
G1 X148.448 Y78.459 E.2306
G1 X148.982 Y78.459 E.01643
G1 X143.149 Y84.292 E.25384
G1 X143.149 Y84.826 E.01643
G1 X149.516 Y78.459 E.27708
G1 X150.05 Y78.459 E.01643
G1 X143.149 Y85.36 E.30033
G1 X143.149 Y85.894 E.01643
G1 X150.584 Y78.459 E.32357
G1 X151.118 Y78.459 E.01643
G1 X142.979 Y86.597 E.35419
; WIPE_START
G1 X144.393 Y85.183 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.661 Y78.285 Z1.2 F30000
G1 X148.306 Y76.922 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X148.306 Y77.922 E.01538
; WIPE_START
G1 X148.306 Y76.922 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X151.579 Y77.997 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X152.118 Y77.459 E.02345
G1 X152.652 Y77.459 E.01643
G1 X143.149 Y86.962 E.41357
G1 X143.149 Y87.496 E.01643
G1 X153.186 Y77.459 E.43681
G1 X153.72 Y77.459 E.01643
G1 X143.149 Y88.03 E.46006
G1 X143.149 Y88.564 E.01643
G1 X154.254 Y77.459 E.4833
G1 X154.788 Y77.459 E.01643
G1 X143.149 Y89.098 E.50654
G1 X143.149 Y89.632 E.01643
G1 X155.322 Y77.459 E.52978
G1 X155.856 Y77.459 E.01643
G1 X143.149 Y90.166 E.55302
G1 X143.149 Y90.7 E.01643
G1 X156.39 Y77.459 E.57627
G1 X156.925 Y77.459 E.01643
G1 X143.149 Y91.234 E.59951
G1 X143.149 Y91.768 E.01643
G1 X157.459 Y77.459 E.62275
G1 X157.993 Y77.459 E.01643
G1 X143.149 Y92.303 E.64599
G1 X143.149 Y92.774 E.01451
G1 X143.212 Y92.774 E.00193
G1 X158.527 Y77.459 E.66651
G1 X159.061 Y77.459 E.01643
G1 X143.746 Y92.774 E.66651
G1 X144.28 Y92.774 E.01643
G1 X159.595 Y77.459 E.66651
G1 X160.129 Y77.459 E.01643
G1 X144.814 Y92.774 E.66651
G1 X145.348 Y92.774 E.01643
G1 X160.663 Y77.459 E.66651
G1 X161.197 Y77.459 E.01643
G1 X145.882 Y92.774 E.66651
G1 X146.416 Y92.774 E.01643
G1 X161.731 Y77.459 E.66651
G1 X162.265 Y77.459 E.01643
G1 X146.95 Y92.774 E.66651
G1 X147.484 Y92.774 E.01643
G1 X162.799 Y77.459 E.66651
G1 X163.333 Y77.459 E.01643
G1 X148.018 Y92.774 E.66651
G1 X148.552 Y92.774 E.01643
G1 X163.867 Y77.459 E.66651
G1 X164.401 Y77.459 E.01643
G1 X149.086 Y92.774 E.66651
G1 X149.62 Y92.774 E.01643
G1 X164.464 Y77.93 E.64599
G1 X164.464 Y78.464 E.01643
G1 X150.154 Y92.774 E.62275
G1 X150.688 Y92.774 E.01643
G1 X164.464 Y78.998 E.59951
G1 X164.464 Y79.532 E.01643
G1 X151.222 Y92.774 E.57627
G1 X151.757 Y92.774 E.01643
G1 X164.464 Y80.066 E.55303
G1 X164.464 Y80.6 E.01643
G1 X152.291 Y92.774 E.52978
G1 X152.825 Y92.774 E.01643
G1 X164.464 Y81.135 E.50654
G1 X164.464 Y81.669 E.01643
G1 X153.359 Y92.774 E.4833
G1 X153.893 Y92.774 E.01643
G1 X164.464 Y82.203 E.46006
G1 X164.464 Y82.737 E.01643
G1 X154.427 Y92.774 E.43682
G1 X154.961 Y92.774 E.01643
G1 X164.464 Y83.271 E.41357
G1 X164.464 Y83.805 E.01643
G1 X155.495 Y92.774 E.39033
G1 X156.029 Y92.774 E.01643
G1 X164.464 Y84.339 E.36709
G1 X164.464 Y84.873 E.01643
G1 X156.563 Y92.774 E.34385
G1 X157.097 Y92.774 E.01643
G1 X164.464 Y85.407 E.3206
G1 X164.464 Y85.941 E.01643
G1 X157.631 Y92.774 E.29736
G1 X158.165 Y92.774 E.01643
G1 X164.464 Y86.475 E.27412
G1 X164.464 Y87.009 E.01643
G1 X158.699 Y92.774 E.25088
G1 X159.233 Y92.774 E.01643
G1 X164.464 Y87.543 E.22764
G1 X164.464 Y88.077 E.01643
G1 X159.767 Y92.774 E.20439
G1 X160.302 Y92.774 E.01643
G1 X164.464 Y88.611 E.18115
G1 X164.464 Y89.145 E.01643
G1 X160.836 Y92.774 E.15791
G1 X161.37 Y92.774 E.01643
G1 X164.464 Y89.68 E.13467
G1 X164.464 Y90.214 E.01643
G1 X161.904 Y92.774 E.11143
G1 X162.438 Y92.774 E.01643
G1 X164.464 Y90.748 E.08818
G1 X164.464 Y91.282 E.01643
G1 X162.972 Y92.774 E.06494
G1 X163.506 Y92.774 E.01643
G1 X164.464 Y91.816 E.0417
G1 X164.464 Y92.35 E.01643
G1 X163.87 Y92.944 E.02584
; OBJECT_ID: 203
; WIPE_START
M73 P44 R15
G1 X164.464 Y92.35 E-.3191
G1 X164.464 Y91.816 E-.20295
G1 X164.021 Y92.259 E-.23796
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X164.652 Y99.865 Z1.2 F30000
G1 X165.917 Y115.125 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z1.2 F30000
G1 X140.698 Y115.907 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y117.311 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
G1 F15000
G1 X143.807 Y116.111 E.01846
G1 X137.707 Y116.111 F30000
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y117.311 E.03802
; WIPE_START
G1 X137.707 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.899 Y108.481 Z1.2 F30000
G1 X138.065 Y101.859 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X138.065 Y103.488 E.05401
G1 X139.35 Y104.773 E.06029
G1 X139.35 Y103.703 E.0355
G1 X138.065 Y104.988 E.06029
G1 X138.065 Y109.245 E.1412
G1 X139.35 Y110.53 E.06029
G1 X139.35 Y109.46 E.0355
G1 X138.065 Y110.745 E.06029
G1 X138.065 Y115.002 E.1412
G1 X138.622 Y115.559 E.02615
G1 X139.008 Y115.559 E.01279
G1 X139.147 Y115.42 E.00651
G1 X139.147 Y114.959 E.01529
G1 X139.35 Y114.959 E.00675
G1 X139.35 Y113.995 E.03197
G1 X139.495 Y115.516 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
G1 X147.694 Y116.759 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X149.322 Y116.759 E.05401
G1 X150.607 Y115.474 E.06029
G1 X150.051 Y115.474 E.01845
G1 X151.336 Y116.759 E.06029
G1 X155.079 Y116.759 E.12415
G1 X156.364 Y115.474 E.06029
G1 X155.808 Y115.474 E.01845
G1 X157.093 Y116.759 E.06029
G1 X160.836 Y116.759 E.12415
G1 X162.121 Y115.474 E.06029
G1 X161.565 Y115.474 E.01845
G1 X162.85 Y116.759 E.06029
G1 X166.593 Y116.759 E.12415
G1 X168.35 Y115.002 E.08244
G1 X168.35 Y116.502 E.04977
G1 X167.065 Y115.217 E.06029
G1 X167.065 Y115.474 E.00852
G1 X165.694 Y115.474 E.04549
; WIPE_START
G1 X167.065 Y115.474 E-.52112
G1 X167.065 Y115.217 E-.09765
G1 X167.328 Y115.48 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X168.35 Y112.373 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
G1 F8843.478
G1 X168.35 Y110.745 E.05401
G1 X167.065 Y109.46 E.06029
G1 X167.065 Y110.53 E.03549
G1 X168.35 Y109.245 E.06029
G1 X168.35 Y104.988 E.1412
G1 X167.065 Y103.703 E.06029
G1 X167.065 Y104.773 E.03549
G1 X168.35 Y103.488 E.06029
G1 X168.35 Y101.859 E.05401
; WIPE_START
G1 X168.35 Y103.488 E-.61876
G1 X168.087 Y103.75 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X165.694 Y98.759 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
G1 F8843.478
G1 X167.065 Y98.759 E.04549
G1 X167.065 Y99.016 E.00852
G1 X168.35 Y97.731 E.06029
G1 X168.35 Y99.231 E.04977
G1 X166.593 Y97.474 E.08244
G1 X162.85 Y97.474 E.12415
G1 X161.565 Y98.759 E.06029
G1 X162.121 Y98.759 E.01845
G1 X160.836 Y97.474 E.06029
G1 X157.093 Y97.474 E.12415
G1 X155.808 Y98.759 E.06029
G1 X156.364 Y98.759 E.01845
G1 X155.079 Y97.474 E.06029
G1 X151.336 Y97.474 E.12415
G1 X150.051 Y98.759 E.06029
G1 X150.607 Y98.759 E.01845
G1 X149.322 Y97.474 E.06029
G1 X145.579 Y97.474 E.12415
G1 X144.294 Y98.759 E.06029
G1 X144.85 Y98.759 E.01845
G1 X143.565 Y97.474 E.06029
G1 X139.822 Y97.474 E.12415
G1 X138.065 Y99.231 E.08244
G1 X138.065 Y97.731 E.04977
G1 X139.35 Y99.016 E.06029
G1 X139.35 Y98.759 E.00852
G1 X140.721 Y98.759 E.04549
; OBJECT_ID: 269
; WIPE_START
G1 X139.35 Y98.759 E-.52111
G1 X139.35 Y99.016 E-.09765
G1 X139.087 Y98.753 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.379 Y105.064 Z1.2 F30000
G1 X176.182 Y153.301 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X176.179 Y153.324 E.00078
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X161.638 Y172.275 E.11717
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X125.476 Y160 E.11717
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.047 Y144.026 E.07577
G1 X123.21 Y142.788 E.0414
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X126.618 Y134.135 E.07577
G1 X127.242 Y133.054 E.0414
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X149.177 Y121.111 E.0414
G1 X151.461 Y121.111 E.07577
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X162.719 Y124.462 E.0414
G1 X164.697 Y125.604 E.07577
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.913 Y136.113 E.11717
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.19 Y153.242 E.1144
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10695
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X145.716 Y174.315 E.06939
G1 X144.504 Y174.155 E.03756
G1 X141.141 Y173.255 E.10696
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X125.829 Y159.826 E.10696
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.436 Y144.077 E.06939
G1 X123.596 Y142.865 E.03756
G1 X124.497 Y139.503 E.10696
G1 X125.829 Y136.287 E.10696
G1 X126.958 Y134.331 E.06939
G1 X127.569 Y133.272 E.03756
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X137.925 Y124.19 E.10696
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X149.177 Y121.503 E.03756
G1 X151.435 Y121.503 E.06939
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X162.523 Y124.801 E.03756
G1 X164.479 Y125.931 E.0694
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.289 Y155.121 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z1.2 F30000
G1 X155.04 Y121.186 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X169.414 Y129.114 E.07766
G1 X170.293 Y129.992 E.04122
G1 X172.474 Y132.835 E.11887
G1 X174.266 Y135.939 E.11888
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 4 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer4 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X161.812 Y172.628 E.11888
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y147.507 E.07766
G1 X122.357 Y146.265 E.04121
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X124.648 Y137.087 E.07766
G1 X125.124 Y135.939 E.04121
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X130.752 Y128.337 E.07766
G1 X131.631 Y127.458 E.04122
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X153.808 Y121.024 E.07766
G1 X154.98 Y121.178 E.03922
M204 S250
G1 X155.114 Y120.8 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X155.116 Y120.801 E.00007
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X169.691 Y128.837 E.07273
G1 X170.588 Y129.733 E.03897
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y147.507 E.07273
G1 X121.965 Y146.239 E.03896
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.286 Y136.937 E.07273
G1 X124.771 Y135.765 E.03897
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X130.475 Y128.06 E.07273
G1 X131.372 Y127.163 E.03897
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X153.859 Y120.635 E.07273
G1 X155.054 Y120.793 E.03705
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X155.116 Y120.801 E-.02367
G1 X156.988 Y121.302 E-.73633
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.739 Y126.843 Z1.2 F30000
G1 X116.764 Y163.76 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z1.2 F30000
G1 X100.964 Y139.541 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
M73 P45 R15
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.998 Y136.908 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X101.312 Y136.908 E.02273
G1 X101.312 Y137.851 E.03128
G1 X101.451 Y137.99 E.00651
G1 X101.912 Y137.99 E.01529
G1 X101.912 Y138.193 E.00675
G1 X105.341 Y138.193 E.11376
G1 X106.627 Y136.908 E.06029
G1 X106.126 Y136.908 E.0166
G1 X107.411 Y138.193 E.06029
G1 X111.098 Y138.193 E.1223
G1 X112.384 Y136.908 E.06029
G1 X111.883 Y136.908 E.0166
G1 X113.168 Y138.193 E.06029
G1 X116.855 Y138.193 E.1223
G1 X118.141 Y136.908 E.06029
G1 X117.64 Y136.908 E.0166
G1 X118.397 Y137.665 E.03553
G1 X118.397 Y139.294 E.05401
G1 X117.112 Y140.509 F30000
G1 F8843.478
G1 X117.112 Y142.137 E.05401
G1 X118.397 Y143.422 E.06029
G1 X118.397 Y142.408 E.03365
G1 X117.112 Y143.693 E.06029
G1 X117.112 Y147.894 E.13935
G1 X118.397 Y149.179 E.06029
G1 X118.397 Y148.165 E.03365
G1 X117.112 Y149.45 E.06029
G1 X117.112 Y153.651 E.13935
G1 X118.397 Y154.936 E.06029
G1 X118.397 Y153.922 E.03365
G1 X117.112 Y155.207 E.06029
G1 X117.112 Y159.408 E.13935
G1 X118.397 Y160.693 E.06029
G1 X118.397 Y159.679 E.03365
G1 X117.112 Y160.964 E.06029
G1 X117.112 Y162.592 E.05401
G1 X118.397 Y163.807 F30000
G1 F8843.478
G1 X118.397 Y165.436 E.05401
G1 X117.64 Y166.193 E.03553
G1 X118.141 Y166.193 E.0166
G1 X116.855 Y164.908 E.06029
G1 X113.168 Y164.908 E.1223
G1 X111.883 Y166.193 E.06029
G1 X112.384 Y166.193 E.0166
G1 X111.098 Y164.908 E.06029
G1 X107.411 Y164.908 E.1223
G1 X106.126 Y166.193 E.06029
G1 X106.627 Y166.193 E.0166
G1 X105.341 Y164.908 E.06029
G1 X101.654 Y164.908 E.1223
G1 X100.369 Y166.193 E.06029
G1 X100.87 Y166.193 E.0166
G1 X100.112 Y165.436 E.03553
G1 X100.112 Y163.807 E.05401
G1 X101.397 Y162.592 F30000
G1 F8843.478
G1 X101.397 Y160.964 E.05401
G1 X100.112 Y159.679 E.06029
G1 X100.112 Y160.693 E.03365
G1 X101.397 Y159.408 E.06029
G1 X101.397 Y155.207 E.13935
G1 X100.112 Y153.922 E.06029
G1 X100.112 Y154.936 E.03365
G1 X101.397 Y153.651 E.06029
G1 X101.397 Y149.45 E.13935
G1 X100.112 Y148.165 E.06029
G1 X100.112 Y149.179 E.03365
G1 X101.397 Y147.894 E.06029
G1 X101.397 Y143.693 E.13935
G1 X101.016 Y143.311 E.01791
G1 X100.798 Y143.311 E.00723
G1 X100.798 Y143.108 E.00675
G1 X100.427 Y143.108 E.01231
G1 X100.112 Y143.422 E.01475
G1 X100.112 Y145.051 E.05401
; WIPE_START
G1 X100.112 Y143.422 E-.61876
G1 X100.375 Y143.159 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X99.56 Y136.55 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X100.76 Y136.55 E.03802
; OBJECT_ID: 214
; WIPE_START
G1 X99.56 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X95.23 Y142.835 Z1.2 F30000
G1 X94.746 Y143.538 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.746 Y146.757 E.10676
G1 X95.746 Y146.757 E.03317
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X94.806 Y143.538 E.03118
G1 X95.153 Y143.945 F30000
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
; WIPE_START
M204 S10000
G1 X95.545 Y145.957 E-.61602
G1 X95.924 Y145.957 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X95.582 Y142.985 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42056
G1 F9532.888
G1 X95.362 Y143.205 E.00958
G1 X94.828 Y143.205 E.01643
G1 X95.413 Y142.621 E.02543
G1 X95.413 Y142.086 E.01643
G1 X80.097 Y157.402 E.66651
G1 X80.097 Y157.936 E.01643
G1 X94.413 Y143.621 E.62299
G1 X94.413 Y144.155 E.01643
G1 X80.097 Y158.47 E.62299
G1 X80.097 Y159.004 E.01643
G1 X94.413 Y144.689 E.62299
G1 X94.413 Y145.223 E.01643
G1 X80.097 Y159.538 E.62299
G1 X80.097 Y160.072 E.01643
G1 X94.413 Y145.757 E.62299
G1 X94.413 Y146.291 E.01643
G1 X80.097 Y160.606 E.62299
G1 X80.097 Y161.14 E.01643
G1 X94.413 Y146.825 E.62299
G1 X94.413 Y147.09 E.00815
G1 X94.682 Y147.09 E.00828
G1 X80.097 Y161.674 E.63471
G1 X80.097 Y162.208 E.01643
G1 X95.216 Y147.09 E.65795
G1 X95.413 Y147.09 E.00605
G1 X95.413 Y147.427 E.01038
G1 X80.097 Y162.742 E.66651
G1 X80.097 Y162.805 E.00193
G1 X80.569 Y162.805 E.01451
G1 X95.413 Y147.961 E.64599
G1 X95.413 Y148.495 E.01643
G1 X81.103 Y162.805 E.62275
G1 X81.637 Y162.805 E.01643
G1 X95.413 Y149.029 E.59951
G1 X95.413 Y149.563 E.01643
G1 X82.171 Y162.805 E.57627
G1 X82.705 Y162.805 E.01643
G1 X95.413 Y150.097 E.55303
G1 X95.413 Y150.631 E.01643
G1 X83.239 Y162.805 E.52978
G1 X83.773 Y162.805 E.01643
G1 X95.413 Y151.166 E.50654
G1 X95.413 Y151.7 E.01643
G1 X84.307 Y162.805 E.4833
G1 X84.841 Y162.805 E.01643
G1 X95.413 Y152.234 E.46006
G1 X95.413 Y152.768 E.01643
G1 X85.375 Y162.805 E.43682
G1 X85.909 Y162.805 E.01643
G1 X95.413 Y153.302 E.41357
G1 X95.413 Y153.836 E.01643
G1 X86.443 Y162.805 E.39033
G1 X86.977 Y162.805 E.01643
G1 X95.413 Y154.37 E.36709
G1 X95.413 Y154.904 E.01643
G1 X87.512 Y162.805 E.34385
G1 X88.046 Y162.805 E.01643
G1 X95.413 Y155.438 E.3206
G1 X95.413 Y155.972 E.01643
G1 X88.58 Y162.805 E.29736
G1 X89.114 Y162.805 E.01643
G1 X95.413 Y156.506 E.27412
G1 X95.413 Y157.04 E.01643
G1 X89.648 Y162.805 E.25088
G1 X90.182 Y162.805 E.01643
G1 X95.413 Y157.574 E.22764
G1 X95.413 Y158.108 E.01643
G1 X90.716 Y162.805 E.20439
G1 X91.25 Y162.805 E.01643
G1 X95.413 Y158.642 E.18115
G1 X95.413 Y159.177 E.01643
G1 X91.784 Y162.805 E.15791
G1 X92.318 Y162.805 E.01643
G1 X95.413 Y159.711 E.13467
G1 X95.413 Y160.245 E.01643
G1 X92.852 Y162.805 E.11143
G1 X93.386 Y162.805 E.01643
G1 X95.413 Y160.779 E.08818
G1 X95.413 Y161.313 E.01643
G1 X93.92 Y162.805 E.06494
G1 X94.454 Y162.805 E.01643
G1 X95.413 Y161.847 E.0417
G1 X95.413 Y162.381 E.01643
G1 X94.819 Y162.975 E.02584
G1 X79.928 Y157.037 F30000
G1 F9532.888
G1 X95.413 Y141.552 E.67389
G1 X95.413 Y141.49 E.00193
G1 X94.941 Y141.49 E.01451
G1 X80.097 Y156.334 E.64599
G1 X80.097 Y155.8 E.01643
G1 X94.407 Y141.49 E.62275
G1 X93.873 Y141.49 E.01643
G1 X80.097 Y155.265 E.59951
M73 P45 R14
G1 X80.097 Y154.731 E.01643
G1 X93.339 Y141.49 E.57627
G1 X92.805 Y141.49 E.01643
G1 X80.097 Y154.197 E.55302
G1 X80.097 Y153.663 E.01643
G1 X92.271 Y141.49 E.52978
G1 X91.737 Y141.49 E.01643
G1 X80.097 Y153.129 E.50654
G1 X80.097 Y152.595 E.01643
G1 X91.203 Y141.49 E.4833
G1 X90.669 Y141.49 E.01643
G1 X80.097 Y152.061 E.46006
G1 X80.097 Y151.527 E.01643
G1 X90.135 Y141.49 E.43681
G1 X89.6 Y141.49 E.01643
G1 X80.097 Y150.993 E.41357
G1 X80.097 Y150.459 E.01643
G1 X89.066 Y141.49 E.39033
G1 X88.532 Y141.49 E.01643
G1 X80.097 Y149.925 E.36709
G1 X80.097 Y149.391 E.01643
G1 X87.998 Y141.49 E.34385
G1 X87.464 Y141.49 E.01643
G1 X80.097 Y148.857 E.3206
G1 X80.097 Y148.323 E.01643
G1 X86.93 Y141.49 E.29736
G1 X86.396 Y141.49 E.01643
G1 X80.097 Y147.789 E.27412
G1 X80.097 Y147.254 E.01643
G1 X85.862 Y141.49 E.25088
G1 X85.328 Y141.49 E.01643
G1 X80.097 Y146.72 E.22763
G1 X80.097 Y146.186 E.01643
G1 X84.794 Y141.49 E.20439
G1 X84.26 Y141.49 E.01643
G1 X80.097 Y145.652 E.18115
G1 X80.097 Y145.118 E.01643
G1 X83.726 Y141.49 E.15791
G1 X83.192 Y141.49 E.01643
G1 X80.097 Y144.584 E.13467
G1 X80.097 Y144.05 E.01643
G1 X82.658 Y141.49 E.11142
G1 X82.124 Y141.49 E.01643
G1 X80.097 Y143.516 E.08818
G1 X80.097 Y142.982 E.01643
G1 X81.589 Y141.49 E.06494
G1 X81.055 Y141.49 E.01643
G1 X80.097 Y142.448 E.0417
G1 X80.097 Y141.914 E.01643
G1 X80.691 Y141.32 E.02584
; OBJECT_ID: 236
; WIPE_START
G1 X80.097 Y141.914 E-.31909
G1 X80.097 Y142.448 E-.20294
G1 X80.54 Y142.005 E-.23797
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X84.337 Y135.384 Z1.2 F30000
G1 X96.313 Y114.504 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.78 E.10676
G1 X99.295 Y116.072 E.03317
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.07 Y110.261 E.03317
G1 X96.27 Y114.461 E.19704
G1 X96.888 Y114.504 F30000
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
M73 P46 R14
G1 F15000
G1 X96.534 Y114.437 E.01538
G1 X94.413 Y112.316 F30000
G1 F15000
G1 X95.12 Y111.609 E.01538
; WIPE_START
G1 X94.413 Y112.316 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X91.214 Y108.223 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42348
G1 F9459.743
G1 X80.265 Y119.172 E.4802
G1 X80.534 Y119.441 E.0118
G1 X91.364 Y108.612 E.47494
G1 X91.633 Y108.881 E.0118
G1 X80.803 Y119.71 E.47494
G1 X81.072 Y119.98 E.0118
G1 X91.902 Y109.15 E.47494
G1 X92.171 Y109.419 E.0118
G1 X81.341 Y120.249 E.47494
G1 X81.61 Y120.518 E.0118
G1 X91.733 Y110.395 E.44393
G1 X92.002 Y110.664 E.0118
G1 X81.88 Y120.787 E.44393
G1 X82.149 Y121.056 E.0118
G1 X92.271 Y110.934 E.44393
G1 X92.54 Y111.203 E.0118
G1 X82.418 Y121.325 E.44393
G1 X82.687 Y121.594 E.0118
G1 X92.809 Y111.472 E.44393
G1 X93.078 Y111.741 E.0118
G1 X82.956 Y121.863 E.44393
G1 X83.225 Y122.132 E.0118
G1 X93.347 Y112.01 E.44393
G1 X93.616 Y112.279 E.0118
G1 X83.494 Y122.401 E.44393
G1 X83.763 Y122.67 E.0118
G1 X93.886 Y112.548 E.44393
G1 X94.155 Y112.817 E.0118
G1 X84.032 Y122.94 E.44393
G1 X84.301 Y123.209 E.0118
G1 X94.424 Y113.086 E.44393
G1 X94.693 Y113.355 E.0118
G1 X84.57 Y123.478 E.44393
G1 X84.84 Y123.747 E.0118
G1 X94.962 Y113.624 E.44393
G1 X95.231 Y113.894 E.0118
G1 X85.109 Y124.016 E.44393
G1 X85.378 Y124.285 E.0118
G1 X95.5 Y114.163 E.44393
G1 X95.769 Y114.432 E.0118
G1 X85.647 Y124.554 E.44393
G1 X85.916 Y124.823 E.0118
G1 X96.038 Y114.701 E.44393
G1 X96.307 Y114.97 E.0118
G1 X86.185 Y125.092 E.44393
G1 X86.454 Y125.361 E.0118
G1 X96.577 Y115.239 E.44393
G1 X96.846 Y115.508 E.0118
G1 X86.723 Y125.631 E.44393
G1 X86.992 Y125.9 E.0118
G1 X97.115 Y115.777 E.44393
G1 X97.384 Y116.046 E.0118
G1 X87.261 Y126.169 E.44393
G1 X87.531 Y126.438 E.0118
G1 X97.653 Y116.315 E.44393
G1 X97.922 Y116.585 E.0118
G1 X87.8 Y126.707 E.44393
G1 X88.069 Y126.976 E.0118
G1 X98.191 Y116.854 E.44393
G1 X98.46 Y117.123 E.0118
G1 X88.338 Y127.245 E.44393
G1 X88.607 Y127.514 E.0118
G1 X99.436 Y116.685 E.47494
G1 X99.706 Y116.954 E.0118
G1 X88.876 Y127.783 E.47494
G1 X89.145 Y128.052 E.0118
G1 X99.975 Y117.223 E.47494
G1 X100.244 Y117.492 E.0118
G1 X89.414 Y128.321 E.47494
G1 X89.683 Y128.591 E.0118
G1 X100.513 Y117.761 E.47494
G1 X100.782 Y118.03 E.0118
G1 X89.952 Y128.86 E.47494
G1 X90.222 Y129.129 E.0118
G1 X101.051 Y118.299 E.47494
G1 X101.32 Y118.568 E.0118
G1 X90.491 Y129.398 E.47494
G1 X90.76 Y129.667 E.0118
G1 X101.589 Y118.838 E.47494
G1 X101.858 Y119.107 E.0118
G1 X91.029 Y129.936 E.47494
G1 X91.298 Y130.205 E.0118
G1 X102.127 Y119.376 E.47494
G1 X102.396 Y119.645 E.0118
G1 X91.567 Y130.474 E.47494
G1 X91.836 Y130.743 E.0118
G1 X102.666 Y119.914 E.47494
G1 X102.935 Y120.183 E.0118
G1 X92.105 Y131.012 E.47494
G1 X92.374 Y131.282 E.0118
G1 X103.204 Y120.452 E.47494
G1 X103.473 Y120.721 E.0118
G1 X92.643 Y131.551 E.47494
G1 X92.912 Y131.82 E.0118
G1 X103.742 Y120.99 E.47494
G1 X104.011 Y121.259 E.0118
G1 X93.182 Y132.089 E.47494
G1 X93.451 Y132.358 E.0118
G1 X104.28 Y121.528 E.47494
G1 X104.549 Y121.798 E.0118
G1 X93.72 Y132.627 E.47494
G1 X93.989 Y132.896 E.0118
G1 X104.818 Y122.067 E.47494
G1 X105.087 Y122.336 E.0118
G1 X94.258 Y133.165 E.47494
G1 X94.527 Y133.434 E.0118
G1 X105.357 Y122.605 E.47494
G1 X105.626 Y122.874 E.0118
G1 X94.796 Y133.703 E.47494
G1 X95.065 Y133.973 E.0118
G1 X105.895 Y123.143 E.47494
G1 X106.164 Y123.412 E.0118
G1 X95.214 Y134.362 E.4802
; OBJECT_ID: 181
; WIPE_START
G1 X96.629 Y132.947 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X103.792 Y130.314 Z1.2 F30000
G1 X130.791 Y120.389 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X107.437 Y108.362 E.1728
G1 X113.666 Y102.133 E.29222
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X107.725 Y108.65 E.15929
G1 X113.666 Y102.709 E.27871
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X108.002 Y108.927 E.13551
G1 X113.666 Y103.263 E.24612
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z1.2 F30000
G1 X101.799 Y111.197 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.525 Y109.964 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.676 Y108.813 E.05401
G1 X105.585 Y109.721 E.04263
G1 X108.463 Y106.843 E.13504
G1 X107.555 Y105.934 E.04263
G1 X110.433 Y103.056 E.13504
G1 X111.342 Y103.964 E.04263
G1 X113.666 Y101.64 E.10902
G1 X114.122 Y102.096 E.0214
G1 X115.031 Y101.188 E.04263
G1 X113.666 Y99.823 E.06403
G1 X113.312 Y100.177 E.01662
G1 X133.312 Y120.178 E.93827
G1 X133.667 Y119.823 E.01662
G1 X132.302 Y118.459 E.06403
G1 X131.393 Y119.367 E.04263
G1 X131.849 Y119.823 E.0214
G1 X129.525 Y122.147 E.10902
G1 X130.434 Y123.056 E.04263
G1 X127.555 Y125.935 E.13504
G1 X126.647 Y125.026 E.04263
G1 X125.495 Y126.177 E.05401
G1 X123.525 Y129.965 F30000
G1 F8843.478
G1 X124.677 Y128.813 E.05401
G1 X123.768 Y127.904 E.04263
G1 X121.444 Y130.228 E.10902
G1 X120.988 Y129.772 E.0214
G1 X120.079 Y130.681 E.04263
G1 X121.444 Y132.046 E.06403
G1 X121.798 Y131.692 E.01662
G1 X104.06 Y113.954 E.83212
G1 X103.706 Y114.308 E.01662
G1 X105.687 Y116.289 E.09291
G1 X106.596 Y115.38 E.04263
G1 X109.474 Y118.258 E.13504
G1 X108.565 Y119.167 E.04263
G1 X111.444 Y122.046 E.13504
G1 X112.353 Y121.137 E.04263
G1 X115.231 Y124.015 E.13504
G1 X114.322 Y124.924 E.04263
G1 X117.201 Y127.803 E.13504
G1 X118.109 Y126.894 E.04263
G1 X119.261 Y128.045 E.05401
; WIPE_START
G1 X118.109 Y126.894 E-.61876
G1 X117.847 Y127.157 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X119.443 Y119.693 Z1.2 F30000
G1 X121.606 Y109.58 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F8843.478
G1 X122.757 Y110.732 E.05401
G1 X123.666 Y109.823 E.04263
G1 X126.545 Y112.702 E.13504
G1 X125.636 Y113.61 E.04263
G1 X128.514 Y116.489 E.13504
G1 X129.423 Y115.58 E.04263
G1 X128.272 Y114.429 E.05401
G1 X116.758 Y102.915 F30000
G1 F8843.478
G1 X117.909 Y104.066 E.05401
G1 X117 Y104.975 E.04263
G1 X119.879 Y107.853 E.13504
G1 X120.788 Y106.945 E.04263
G1 X119.636 Y105.793 E.05401
; OBJECT_ID: 247
; WIPE_START
G1 X120.788 Y106.945 E-.61876
G1 X120.525 Y107.207 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X126.074 Y101.967 Z1.2 F30000
G1 X135.594 Y92.974 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X130.933 Y87.183 E.47289
G1 X136.682 Y92.932 E.24981
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.727 Y94.348 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X132.576 Y95.5 E.05401
G1 X117.525 Y80.449 E.70607
G1 X114.647 Y83.327 E.13504
G1 X129.697 Y98.378 E.70607
G1 X126.819 Y101.257 E.13504
G1 X111.768 Y86.206 E.70607
G1 X109.242 Y88.732 E.11848
G1 X111.011 Y90.5 E.08296
G1 X121.819 Y79.692 E.50704
G1 X124.698 Y82.57 E.13504
G1 X113.889 Y93.379 E.50704
G1 X116.768 Y96.257 E.13504
G1 X127.576 Y85.449 E.50704
G1 X126.425 Y84.297 E.05401
G1 X123.676 Y103.165 F30000
G1 F8843.478
G1 X122.525 Y102.014 E.05401
M73 P47 R14
G1 X133.333 Y91.206 E.50704
G1 X130.455 Y88.327 E.13504
G1 X119.646 Y99.135 E.50704
G1 X118.495 Y97.984 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X119.646 Y99.135 E-.61876
G1 X119.909 Y98.873 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X112.392 Y100.197 Z1.2 F30000
G1 X100.257 Y102.335 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.008 Y102.161 E.01008
G3 X101.413 Y97.32 I1.655 J-2.144 E.21494
G3 X103.01 Y97.667 I.235 J2.764 E.05502
G3 X100.31 Y102.363 I-1.347 J2.35 E.28248
G1 X100.483 Y101.997 F30000
G1 F8843.478
G1 X100.256 Y101.838 E.00919
G3 X101.44 Y97.726 I1.407 J-1.821 E.18222
G3 X102.536 Y97.887 I.229 J2.245 E.03712
G3 X100.537 Y102.023 I-.873 J2.129 E.24914
M204 S250
G1 X100.702 Y101.664 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.466 Y98.117 I.96 J-1.649 E.14721
G3 X102.149 Y98.17 I.184 J2.063 E.02115
G3 X100.755 Y101.693 I-.486 J1.845 E.19817
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11762
G1 X100.263 Y101.32 E-.11795
G1 X100.139 Y101.178 E-.07181
G1 X100 Y100.97 E-.09495
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09496
G1 X99.76 Y100.265 E-.09498
G1 X99.748 Y100.073 E-.07276
; WIPE_END
G1 E-.04 F1800
G1 X97.182 Y93.706 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.093 Y93.984 E.00968
G3 X94.342 Y90.249 I-2.502 J-1.038 E.3798
G3 X95.939 Y90.596 I.234 J2.764 E.05501
G3 X97.208 Y93.647 I-1.347 J2.35 E.11789
G1 X97.206 Y93.651 E.00013
G1 X96.815 Y93.504 F30000
G1 F8843.478
G1 X96.813 Y93.542 E.00124
G3 X94.369 Y90.655 I-2.221 J-.597 E.3321
G3 X95.465 Y90.816 I.229 J2.246 E.03712
G3 X96.872 Y93.246 I-.873 J2.128 E.10018
G1 X96.828 Y93.446 E.00679
M204 S250
G1 X96.431 Y93.428 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X96.435 Y93.44 E.00041
G3 X94.395 Y91.046 I-1.843 J-.496 E.25493
G3 X95.078 Y91.099 I.184 J2.064 E.02115
G3 X96.484 Y93.194 I-.486 J1.846 E.08472
G1 X96.444 Y93.369 E.00551
; WIPE_START
M204 S10000
G1 X96.435 Y93.44 E-.02721
G1 X96.348 Y93.675 E-.09515
G1 X96.238 Y93.899 E-.09499
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09497
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.145 Y94.767 E-.06786
; WIPE_END
G1 E-.04 F1800
G1 X102.49 Y96.842 Z1.2 F30000
G1 X108.713 Y98.601 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X107.776 Y97.665 E.55256
G1 X108.67 Y98.559 E.04194
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X108.064 Y97.377 E.56606
G1 X109.246 Y98.559 E.05544
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X108.341 Y97.1 E.53639
G1 X109.8 Y98.559 E.0634
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.109 Y102.261 Z1.2 F30000
G1 X100.027 Y102.6 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G3 X98.94 Y101.415 I1.632 J-2.588 E.05397
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X99.23 Y89.611 E.13504
G1 X97.298 Y91.544 E.09066
G3 X96.747 Y95.108 I-2.838 J1.386 E.12733
G1 X99.499 Y97.86 E.12908
G3 X103.055 Y97.301 I2.164 J2.177 E.12759
G1 X104.987 Y95.368 E.09066
G1 X107.866 Y98.247 E.13504
G1 X99.886 Y106.227 E.37435
G1 X100.24 Y106.581 E.01662
G1 X101.352 Y105.469 E.05214
G1 X89.129 Y93.247 E.57338
G1 X88.018 Y94.358 E.05214
G1 X88.372 Y94.713 E.01662
G1 X96.352 Y86.733 E.37435
G1 X95.998 Y86.379 E.01662
G1 X94.886 Y87.49 E.05214
G1 X107.109 Y99.712 E.57338
G1 X104.23 Y102.591 E.13504
G1 X103.818 Y102.179 E.01932
; WIPE_START
G1 X104.23 Y102.591 E-.22126
G1 X105.233 Y101.588 E-.53874
; WIPE_END
G1 E-.04 F1800
G1 X98.489 Y98.013 Z1.2 F30000
G1 X91.998 Y94.572 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F8843.478
G2 X93.183 Y95.659 I2.741 J-1.799 E.05389
G1 X91.25 Y97.591 E.09066
G1 X92.402 Y98.742 E.05401
; WIPE_START
G1 X91.25 Y97.591 E-.61876
G1 X91.513 Y97.328 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X93.031 Y89.848 Z1.2 F30000
G1 X93.159 Y89.217 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.05401
G1 X92.419 Y90.78 E.01932
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X92.008 Y90.368 E-.22126
G1 X93.01 Y89.366 E-.53874
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 5/30
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S175.95
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z1.2 I.26 J1.189 P1  F30000
G1 X148.009 Y77.326 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X148.009 Y76.718 E.02017
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.494 E.02574
G1 X148.009 Y77.494 E.01977
G1 X148.009 Y77.386 E.00358
; WIPE_START
G1 X148.009 Y76.718 E-.25382
G1 X148.604 Y76.718 E-.22643
G1 X148.604 Y77.455 E-.27975
; WIPE_END
G1 E-.04 F1800
G1 X145.604 Y77.326 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X145.604 Y77.494 E.00557
G1 X143.184 Y77.494 E.08027
G1 X143.184 Y92.738 E.50567
G1 X164.429 Y92.738 E.7047
G1 X164.429 Y77.494 E.50567
G1 X151.009 Y77.494 E.44516
G1 X151.009 Y76.718 E.02574
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.266 E.01818
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.801 Y77.606 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.21092
G1 F15000
G1 X147.812 Y77.606 E.02754
G1 X148.801 Y77.606 F30000
G1 F15000
G1 X150.812 Y77.606 E.02754
G1 X151.212 Y77.106 F30000
; LINE_WIDTH: 0.41178
G1 F9759.801
G1 X164.632 Y77.106 E.40337
; LINE_WIDTH: 0.448699
G1 F8871.831
G1 X164.785 Y77.138 E.00516
G1 X164.801 Y77.214 E.00258
; LINE_WIDTH: 0.4276
G1 F9358.427
G1 X164.816 Y77.291 E.00245
; LINE_WIDTH: 0.41178
G1 F9759.801
G1 X164.816 Y92.942 E.47043
; LINE_WIDTH: 0.448699
G1 F8871.831
G1 X164.785 Y93.095 E.00516
G1 X164.708 Y93.11 E.00258
; LINE_WIDTH: 0.4276
G1 F9358.427
G1 X164.632 Y93.126 E.00245
; LINE_WIDTH: 0.41178
G1 F9759.801
G1 X142.981 Y93.126 E.65078
; LINE_WIDTH: 0.448699
G1 F8871.831
G1 X142.828 Y93.095 E.00516
G1 X142.812 Y93.018 E.00258
; LINE_WIDTH: 0.4276
G1 F9358.427
G1 X142.797 Y92.942 E.00245
; LINE_WIDTH: 0.41178
G1 F9759.801
G1 X142.797 Y77.291 E.47043
; LINE_WIDTH: 0.448699
G1 F8871.831
G1 X142.828 Y77.138 E.00516
G1 X142.905 Y77.122 E.00258
; LINE_WIDTH: 0.4276
G1 F9358.427
G1 X142.981 Y77.106 E.00245
; LINE_WIDTH: 0.41178
G1 F9759.801
G1 X145.401 Y77.106 E.07274
; WIPE_START
G1 X143.401 Y77.106 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X151.03 Y77.335 Z1.4 F30000
G1 X163.738 Y77.717 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X164.206 Y78.185 E.02035
G1 X164.206 Y78.718
G1 X163.205 Y77.717 E.04352
G1 X162.671 Y77.717
G1 X164.206 Y79.252 E.06669
G1 X164.206 Y79.785
G1 X162.138 Y77.717 E.08987
G1 X161.605 Y77.717
G1 X164.206 Y80.318 E.11304
G1 X164.206 Y80.851
G1 X161.071 Y77.717 E.13621
G1 X160.538 Y77.717
G1 X164.206 Y81.385 E.15938
G1 X164.206 Y81.918
G1 X160.005 Y77.717 E.18256
G1 X159.472 Y77.717
G1 X164.206 Y82.451 E.20573
G1 X164.206 Y82.984
G1 X158.938 Y77.717 E.2289
G1 X158.405 Y77.717
G1 X164.206 Y83.518 E.25207
G1 X164.206 Y84.051
G1 X157.872 Y77.717 E.27525
G1 X157.339 Y77.717
G1 X164.206 Y84.584 E.29842
G1 X164.206 Y85.117
G1 X156.805 Y77.717 E.32159
G1 X156.272 Y77.717
G1 X164.206 Y85.651 E.34476
G1 X164.206 Y86.184
G1 X155.739 Y77.717 E.36794
G1 X155.206 Y77.717
G1 X164.206 Y86.717 E.39111
G1 X164.206 Y87.25
G1 X154.672 Y77.717 E.41428
G1 X154.139 Y77.717
G1 X164.206 Y87.784 E.43745
G1 X164.206 Y88.317
G1 X153.606 Y77.717 E.46063
G1 X153.073 Y77.717
G1 X164.206 Y88.85 E.4838
G1 X164.206 Y89.383
G1 X152.539 Y77.717 E.50697
G1 X152.006 Y77.717
G1 X164.206 Y89.917 E.53014
G1 X164.206 Y90.45
G1 X151.473 Y77.717 E.55332
G1 X150.94 Y77.717
G1 X164.206 Y90.983 E.57649
G1 X164.206 Y91.516
G1 X150.406 Y77.717 E.59966
G1 X149.873 Y77.717
G1 X164.206 Y92.05 E.62284
G1 X164.139 Y92.516
G1 X149.34 Y77.717 E.64309
G1 X148.807 Y77.717
G1 X163.606 Y92.516 E.64309
G1 X163.072 Y92.516
G1 X148.273 Y77.717 E.64309
G1 X147.74 Y77.717
G1 X162.539 Y92.516 E.64309
G1 X162.006 Y92.516
G1 X147.207 Y77.717 E.64309
G1 X146.674 Y77.717
G1 X161.473 Y92.516 E.64309
G1 X160.939 Y92.516
G1 X146.14 Y77.717 E.64309
G1 X145.607 Y77.717
G1 X160.406 Y92.516 E.64309
G1 X159.873 Y92.516
G1 X145.074 Y77.717 E.64309
G1 X144.541 Y77.717
G1 X159.34 Y92.516 E.64309
G1 X158.806 Y92.516
G1 X144.007 Y77.717 E.64309
G1 X143.474 Y77.717
G1 X158.273 Y92.516 E.64309
G1 X157.74 Y92.516
G1 X143.407 Y78.183 E.62283
G1 X143.407 Y78.716
G1 X157.207 Y92.516 E.59966
G1 X156.673 Y92.516
G1 X143.407 Y79.25 E.57648
G1 X143.407 Y79.783
G1 X156.14 Y92.516 E.55331
G1 X155.607 Y92.516
G1 X143.407 Y80.316 E.53014
G1 X143.407 Y80.849
G1 X155.073 Y92.516 E.50697
G1 X154.54 Y92.516
G1 X143.407 Y81.383 E.48379
G1 X143.407 Y81.916
G1 X154.007 Y92.516 E.46062
G1 X153.474 Y92.516
G1 X143.407 Y82.449 E.43745
G1 X143.407 Y82.982
G1 X152.94 Y92.516 E.41428
G1 X152.407 Y92.516
G1 X143.407 Y83.516 E.3911
G1 X143.407 Y84.049
G1 X151.874 Y92.516 E.36793
G1 X151.341 Y92.516
G1 X143.407 Y84.582 E.34476
G1 X143.407 Y85.115
G1 X150.807 Y92.516 E.32159
G1 X150.274 Y92.516
G1 X143.407 Y85.649 E.29841
G1 X143.407 Y86.182
G1 X149.741 Y92.516 E.27524
G1 X149.208 Y92.516
G1 X143.407 Y86.715 E.25207
M73 P48 R14
G1 X143.407 Y87.248
G1 X148.674 Y92.516 E.22889
G1 X148.141 Y92.516
G1 X143.407 Y87.782 E.20572
G1 X143.407 Y88.315
G1 X147.608 Y92.516 E.18255
G1 X147.075 Y92.516
G1 X143.407 Y88.848 E.15938
G1 X143.407 Y89.381
G1 X146.541 Y92.516 E.1362
G1 X146.008 Y92.516
G1 X143.407 Y89.915 E.11303
G1 X143.407 Y90.448
G1 X145.475 Y92.516 E.08986
G1 X144.942 Y92.516
G1 X143.407 Y90.981 E.06669
G1 X143.407 Y91.514
G1 X144.408 Y92.516 E.04351
G1 X143.875 Y92.516
G1 X143.407 Y92.048 E.02034
; OBJECT_ID: 203
; WIPE_START
M204 S10000
G1 X143.875 Y92.516 E-.25156
G1 X144.408 Y92.516 E-.20264
G1 X143.839 Y91.947 E-.3058
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X149.103 Y97.473 Z1.4 F30000
G1 X165.917 Y115.125 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z1.4 F30000
G1 X140.698 Y115.907 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.35 Y113.995 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.35 Y114.959 E.03197
G1 X139.147 Y114.959 E.00675
G1 X139.147 Y115.42 E.01529
G1 X139.008 Y115.559 E.00651
G1 X138.622 Y115.559 E.01279
G1 X138.065 Y115.002 E.02615
G1 X138.065 Y110.745 E.1412
G1 X139.35 Y109.46 E.06029
G1 X139.35 Y110.53 E.0355
G1 X138.065 Y109.245 E.06029
G1 X138.065 Y104.988 E.1412
G1 X139.35 Y103.703 E.06029
G1 X139.35 Y104.773 E.0355
G1 X138.065 Y103.488 E.06029
G1 X138.065 Y101.859 E.05401
; WIPE_START
G1 X138.065 Y103.488 E-.61876
G1 X138.328 Y103.75 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X140.721 Y98.759 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X139.35 Y98.759 E.04549
G1 X139.35 Y99.016 E.00852
G1 X138.065 Y97.731 E.06029
G1 X138.065 Y99.231 E.04977
G1 X139.822 Y97.474 E.08244
G1 X143.565 Y97.474 E.12415
G1 X144.85 Y98.759 E.06029
G1 X144.294 Y98.759 E.01845
G1 X145.579 Y97.474 E.06029
G1 X149.322 Y97.474 E.12415
G1 X150.607 Y98.759 E.06029
G1 X150.051 Y98.759 E.01845
G1 X151.336 Y97.474 E.06029
G1 X155.079 Y97.474 E.12415
G1 X156.364 Y98.759 E.06029
G1 X155.808 Y98.759 E.01845
G1 X157.093 Y97.474 E.06029
G1 X160.836 Y97.474 E.12415
G1 X162.121 Y98.759 E.06029
G1 X161.565 Y98.759 E.01845
G1 X162.85 Y97.474 E.06029
G1 X166.593 Y97.474 E.12415
G1 X168.35 Y99.231 E.08244
G1 X168.35 Y97.731 E.04977
G1 X167.065 Y99.016 E.06029
G1 X167.065 Y98.759 E.00852
G1 X165.694 Y98.759 E.04549
; WIPE_START
G1 X167.065 Y98.759 E-.52112
G1 X167.065 Y99.016 E-.09765
G1 X167.328 Y98.753 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X168.35 Y101.859 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X168.35 Y103.488 E.05401
G1 X167.065 Y104.773 E.06029
G1 X167.065 Y103.703 E.03549
G1 X168.35 Y104.988 E.06029
G1 X168.35 Y109.245 E.1412
G1 X167.065 Y110.53 E.06029
G1 X167.065 Y109.46 E.03549
G1 X168.35 Y110.745 E.06029
G1 X168.35 Y112.373 E.05401
; WIPE_START
G1 X168.35 Y110.745 E-.61876
G1 X168.087 Y110.482 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X165.694 Y115.474 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X167.065 Y115.474 E.04549
G1 X167.065 Y115.217 E.00852
G1 X168.35 Y116.502 E.06029
G1 X168.35 Y115.002 E.04977
G1 X166.593 Y116.759 E.08244
G1 X162.85 Y116.759 E.12415
G1 X161.565 Y115.474 E.06029
G1 X162.121 Y115.474 E.01845
G1 X160.836 Y116.759 E.06029
G1 X157.093 Y116.759 E.12415
G1 X155.808 Y115.474 E.06029
G1 X156.364 Y115.474 E.01845
G1 X155.079 Y116.759 E.06029
G1 X151.336 Y116.759 E.12415
G1 X150.051 Y115.474 E.06029
G1 X150.607 Y115.474 E.01845
G1 X149.322 Y116.759 E.06029
G1 X147.694 Y116.759 E.05401
; WIPE_START
G1 X149.322 Y116.759 E-.61876
G1 X149.585 Y116.496 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X141.97 Y117.018 Z1.4 F30000
G1 X137.707 Y117.311 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; OBJECT_ID: 269
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.281 Y122.525 Z1.4 F30000
G1 X176.183 Y153.3 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.0008
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X161.638 Y172.275 E.11717
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X125.476 Y160 E.11717
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X126.446 Y134.434 E.06431
G1 X127.242 Y133.054 E.05286
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X149.522 Y121.111 E.05286
G1 X151.461 Y121.111 E.06431
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X163.018 Y124.634 E.05286
G1 X164.697 Y125.604 E.06431
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.913 Y136.113 E.11717
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.19 Y153.241 E.11438
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10695
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X125.829 Y159.826 E.10696
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X126.785 Y134.63 E.05878
G1 X127.569 Y133.272 E.04817
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X137.925 Y124.19 E.10696
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10695
G1 X147.954 Y121.503 E.10696
G1 X149.522 Y121.503 E.04817
G1 X151.435 Y121.503 E.05878
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X162.822 Y124.974 E.04817
G1 X164.479 Y125.931 E.05878
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10695
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.289 Y155.121 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z1.4 F30000
G1 X155.04 Y121.186 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X170.293 Y129.992 E.11888
G1 X172.474 Y132.835 E.11887
G1 X174.266 Y135.939 E.11888
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 5 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer5 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X161.812 Y172.628 E.11888
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
M73 P49 R14
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y147.873 E.06551
G1 X122.357 Y146.265 E.05336
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X124.508 Y137.425 E.06551
G1 X125.124 Y135.939 E.05336
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X131.631 Y127.458 E.11888
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X153.445 Y120.976 E.06551
G1 X154.98 Y121.178 E.05137
M204 S250
G1 X155.115 Y120.801 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X155.116 Y120.801 E.00005
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.588 Y129.733 E.1117
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X175.384 Y137.614 E.06147
G1 X176.01 Y139.124 E.05022
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X160.138 Y173.746 E.06147
G1 X158.628 Y174.371 E.05022
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X124.006 Y158.499 E.06147
G1 X123.38 Y156.989 E.05022
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y147.873 E.06147
G1 X121.965 Y146.239 E.05022
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.146 Y137.275 E.06147
G1 X124.771 Y135.765 E.05022
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X131.372 Y127.163 E.1117
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X139.252 Y122.367 E.06147
G1 X140.762 Y121.742 E.05022
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X153.496 Y120.587 E.06148
G1 X155.055 Y120.793 E.04833
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X155.116 Y120.801 E-.02341
G1 X156.989 Y121.302 E-.73659
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.739 Y126.843 Z1.4 F30000
G1 X116.764 Y163.76 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z1.4 F30000
G1 X100.964 Y139.541 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
M73 P49 R13
G1 X101.355 Y142.963 E.14121
G1 X100.112 Y145.051 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.112 Y143.422 E.05401
G1 X100.427 Y143.108 E.01475
G1 X100.798 Y143.108 E.01231
G1 X100.798 Y143.311 E.00675
G1 X101.016 Y143.311 E.00723
G1 X101.397 Y143.693 E.01791
G1 X101.397 Y147.894 E.13935
G1 X100.112 Y149.179 E.06029
G1 X100.112 Y148.165 E.03365
G1 X101.397 Y149.45 E.06029
G1 X101.397 Y153.651 E.13935
G1 X100.112 Y154.936 E.06029
G1 X100.112 Y153.922 E.03365
G1 X101.397 Y155.207 E.06029
G1 X101.397 Y159.408 E.13935
G1 X100.112 Y160.693 E.06029
G1 X100.112 Y159.679 E.03365
G1 X101.397 Y160.964 E.06029
G1 X101.397 Y162.592 E.05401
G1 X100.112 Y163.807 F30000
G1 F8843.478
G1 X100.112 Y165.436 E.05401
G1 X100.87 Y166.193 E.03553
G1 X100.369 Y166.193 E.0166
G1 X101.654 Y164.908 E.06029
G1 X105.341 Y164.908 E.1223
G1 X106.627 Y166.193 E.06029
G1 X106.126 Y166.193 E.0166
G1 X107.411 Y164.908 E.06029
G1 X111.098 Y164.908 E.1223
G1 X112.384 Y166.193 E.06029
G1 X111.883 Y166.193 E.0166
G1 X113.168 Y164.908 E.06029
G1 X116.855 Y164.908 E.1223
G1 X118.141 Y166.193 E.06029
G1 X117.64 Y166.193 E.0166
G1 X118.397 Y165.436 E.03553
G1 X118.397 Y163.807 E.05401
G1 X117.112 Y162.592 F30000
G1 F8843.478
G1 X117.112 Y160.964 E.05401
G1 X118.397 Y159.679 E.06029
G1 X118.397 Y160.693 E.03365
G1 X117.112 Y159.408 E.06029
G1 X117.112 Y155.207 E.13935
G1 X118.397 Y153.922 E.06029
G1 X118.397 Y154.936 E.03365
G1 X117.112 Y153.651 E.06029
G1 X117.112 Y149.45 E.13935
G1 X118.397 Y148.165 E.06029
G1 X118.397 Y149.179 E.03365
G1 X117.112 Y147.894 E.06029
G1 X117.112 Y143.693 E.13935
G1 X118.397 Y142.408 E.06029
G1 X118.397 Y143.422 E.03365
G1 X117.112 Y142.137 E.06029
G1 X117.112 Y140.509 E.05401
G1 X118.397 Y139.294 F30000
G1 F8843.478
G1 X118.397 Y137.665 E.05401
G1 X117.64 Y136.908 E.03553
G1 X118.141 Y136.908 E.0166
G1 X116.855 Y138.193 E.06029
G1 X113.168 Y138.193 E.1223
G1 X111.883 Y136.908 E.06029
G1 X112.384 Y136.908 E.0166
G1 X111.098 Y138.193 E.06029
G1 X107.411 Y138.193 E.1223
G1 X106.126 Y136.908 E.06029
G1 X106.627 Y136.908 E.0166
G1 X105.341 Y138.193 E.06029
G1 X101.912 Y138.193 E.11376
G1 X101.912 Y137.99 E.00675
G1 X101.451 Y137.99 E.01529
G1 X101.312 Y137.851 E.00651
G1 X101.312 Y136.908 E.03128
G1 X101.998 Y136.908 E.02273
; WIPE_START
G1 X101.312 Y136.908 E-.26042
G1 X101.312 Y137.851 E-.35834
G1 X101.451 Y137.99 E-.07457
G1 X101.626 Y137.99 E-.06667
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; OBJECT_ID: 214
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X96.214 Y142.681 Z1.4 F30000
G1 X95.277 Y143.945 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.277 Y141.625 E.07696
G1 X80.233 Y141.625 E.49904
G1 X80.233 Y162.669 E.69807
G1 X95.277 Y162.669 E.49904
G1 X95.277 Y146.349 E.54136
G1 X96.153 Y146.349 E.02906
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.337 Y143.945 E.02707
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X95.215 Y144.141 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.31092
G1 F13432.836
G1 X95.215 Y146.153 E.04394
G1 X95.715 Y146.553 F30000
; LINE_WIDTH: 0.51178
G1 F7678.198
G1 X95.715 Y162.873 E.62352
; LINE_WIDTH: 0.558707
G1 F6979.633
G1 X95.675 Y163.067 E.00834
G1 X95.578 Y163.087 E.00417
; LINE_WIDTH: 0.53189
G1 F7362.415
G1 X95.48 Y163.107 E.00395
; LINE_WIDTH: 0.51178
G1 F7678.198
G1 X80.029 Y163.107 E.59033
; LINE_WIDTH: 0.558707
G1 F6979.633
G1 X79.835 Y163.067 E.00834
G1 X79.815 Y162.97 E.00417
; LINE_WIDTH: 0.53189
G1 F7362.415
G1 X79.795 Y162.873 E.00395
; LINE_WIDTH: 0.51178
G1 F7678.198
G1 X79.795 Y141.422 E.81956
; LINE_WIDTH: 0.558707
G1 F6979.633
G1 X79.835 Y141.228 E.00834
G1 X79.932 Y141.208 E.00417
; LINE_WIDTH: 0.53189
G1 F7362.415
G1 X80.029 Y141.187 E.00395
; LINE_WIDTH: 0.51178
G1 F7678.198
G1 X95.48 Y141.187 E.59033
; LINE_WIDTH: 0.558707
G1 F6979.633
G1 X95.675 Y141.228 E.00834
G1 X95.695 Y141.325 E.00417
; LINE_WIDTH: 0.53189
G1 F7362.415
G1 X95.715 Y141.422 E.00395
; LINE_WIDTH: 0.51178
G1 F7678.198
G1 X95.715 Y143.742 E.08864
; WIPE_START
G1 X95.715 Y141.742 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X94.253 Y141.848 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X95.054 Y142.649 E.03483
G1 X95.054 Y143.183
G1 X93.72 Y141.848 E.058
G1 X93.186 Y141.848
G1 X95.054 Y143.716 E.08117
G1 X95.054 Y144.249
G1 X92.653 Y141.848 E.10435
G1 X92.12 Y141.848
G1 X95.054 Y144.782 E.12752
G1 X95.054 Y145.316
G1 X91.587 Y141.848 E.15069
G1 X91.053 Y141.848
G1 X95.054 Y145.849 E.17386
G1 X95.054 Y146.382
G1 X90.52 Y141.848 E.19704
G1 X89.987 Y141.848
G1 X95.054 Y146.915 E.22021
G1 X95.054 Y147.449
G1 X89.454 Y141.848 E.24338
G1 X88.92 Y141.848
G1 X95.054 Y147.982 E.26656
G1 X95.054 Y148.515
G1 X88.387 Y141.848 E.28973
G1 X87.854 Y141.848
G1 X95.054 Y149.048 E.3129
G1 X95.054 Y149.582
G1 X87.321 Y141.848 E.33607
G1 X86.787 Y141.848
G1 X95.054 Y150.115 E.35925
G1 X95.054 Y150.648
G1 X86.254 Y141.848 E.38242
G1 X85.721 Y141.848
G1 X95.054 Y151.181 E.40559
G1 X95.054 Y151.715
G1 X85.188 Y141.848 E.42876
G1 X84.654 Y141.848
G1 X95.054 Y152.248 E.45194
G1 X95.054 Y152.781
G1 X84.121 Y141.848 E.47511
G1 X83.588 Y141.848
G1 X95.054 Y153.315 E.49828
G1 X95.054 Y153.848
G1 X83.055 Y141.848 E.52145
G1 X82.521 Y141.848
G1 X95.054 Y154.381 E.54463
G1 X95.054 Y154.914
G1 X81.988 Y141.848 E.5678
G1 X81.455 Y141.848
G1 X95.054 Y155.448 E.59097
G1 X95.054 Y155.981
G1 X80.921 Y141.848 E.61414
G1 X80.455 Y141.915
G1 X95.054 Y156.514 E.6344
G1 X95.054 Y157.047
G1 X80.455 Y142.448 E.6344
G1 X80.455 Y142.982
G1 X95.054 Y157.581 E.6344
G1 X95.054 Y158.114
G1 X80.455 Y143.515 E.6344
G1 X80.455 Y144.048
G1 X95.054 Y158.647 E.6344
G1 X95.054 Y159.18
G1 X80.455 Y144.581 E.6344
G1 X80.455 Y145.115
G1 X95.054 Y159.714 E.6344
G1 X95.054 Y160.247
G1 X80.455 Y145.648 E.6344
G1 X80.455 Y146.181
G1 X95.054 Y160.78 E.6344
G1 X95.054 Y161.313
G1 X80.455 Y146.714 E.6344
G1 X80.455 Y147.248
G1 X95.054 Y161.847 E.6344
G1 X95.054 Y162.38
G1 X80.455 Y147.781 E.6344
G1 X80.455 Y148.314
G1 X94.588 Y162.447 E.61414
G1 X94.055 Y162.447
G1 X80.455 Y148.847 E.59097
G1 X80.455 Y149.381
G1 X93.522 Y162.447 E.56779
G1 X92.988 Y162.447
G1 X80.455 Y149.914 E.54462
G1 X80.455 Y150.447
G1 X92.455 Y162.447 E.52145
G1 X91.922 Y162.447
G1 X80.455 Y150.98 E.49828
G1 X80.455 Y151.514
G1 X91.389 Y162.447 E.4751
G1 X90.855 Y162.447
G1 X80.455 Y152.047 E.45193
G1 X80.455 Y152.58
G1 X90.322 Y162.447 E.42876
M73 P50 R13
G1 X89.789 Y162.447
G1 X80.455 Y153.113 E.40558
G1 X80.455 Y153.647
G1 X89.256 Y162.447 E.38241
G1 X88.722 Y162.447
G1 X80.455 Y154.18 E.35924
G1 X80.455 Y154.713
G1 X88.189 Y162.447 E.33607
G1 X87.656 Y162.447
G1 X80.455 Y155.246 E.31289
G1 X80.455 Y155.78
G1 X87.123 Y162.447 E.28972
G1 X86.589 Y162.447
G1 X80.455 Y156.313 E.26655
G1 X80.455 Y156.846
G1 X86.056 Y162.447 E.24338
G1 X85.523 Y162.447
G1 X80.455 Y157.379 E.2202
G1 X80.455 Y157.913
G1 X84.99 Y162.447 E.19703
G1 X84.456 Y162.447
G1 X80.455 Y158.446 E.17386
G1 X80.455 Y158.979
G1 X83.923 Y162.447 E.15069
G1 X83.39 Y162.447
G1 X80.455 Y159.513 E.12751
G1 X80.455 Y160.046
G1 X82.857 Y162.447 E.10434
G1 X82.323 Y162.447
G1 X80.455 Y160.579 E.08117
G1 X80.455 Y161.112
G1 X81.79 Y162.447 E.058
G1 X81.257 Y162.447
G1 X80.455 Y161.646 E.03482
; OBJECT_ID: 236
; WIPE_START
M204 S10000
G1 X81.257 Y162.447 E-.43065
G1 X81.79 Y162.447 E-.20264
G1 X81.554 Y162.211 E-.12671
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X83.911 Y154.952 Z1.4 F30000
G1 X97.118 Y114.275 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X96.696 Y113.853 E.01977
G1 X97.174 Y113.375 E.02242
G1 X97.595 Y113.797 E.01977
G1 X97.16 Y114.232 E.02043
; WIPE_START
G1 X96.696 Y113.853 E-.22758
G1 X97.174 Y113.375 E-.25685
G1 X97.595 Y113.797 E-.22643
G1 X97.504 Y113.888 E-.04915
; WIPE_END
G1 E-.04 F1800
G1 X94.996 Y112.153 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X94.575 Y111.732 E.01977
G1 X95.053 Y111.254 E.02242
G1 X95.474 Y111.675 E.01977
G1 X95.039 Y112.111 E.02043
; WIPE_START
G1 X94.575 Y111.732 E-.22757
G1 X95.053 Y111.254 E-.25685
G1 X95.474 Y111.675 E-.22643
G1 X95.383 Y111.767 E-.04915
; WIPE_END
G1 E-.04 F1800
G1 X98.817 Y115.975 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X99.295 Y115.497 E.02242
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.875 Y110.032 E.02242
G1 X91.093 Y108.25 E.08359
G1 X80.172 Y119.171 E.51231
G1 X95.336 Y134.334 E.71134
G1 X106.256 Y123.413 E.51231
G1 X98.86 Y116.017 E.34698
; WIPE_START
G1 X99.295 Y115.497 E-.25786
G1 X100.23 Y116.431 E-.50214
; WIPE_END
G1 E-.04 F1800
G1 X97.443 Y114.504 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.142 Y114.528 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.110909
G1 F15000
G1 X98.564 Y115.951 E.01115
G1 X99.2 Y115.88 F30000
; LINE_WIDTH: 0.312073
G1 F13375.302
G1 X106.639 Y123.318 E.23073
G1 X106.702 Y123.413 E.00249
G1 X106.639 Y123.508 E.00249
G1 X95.431 Y134.717 E.34766
G1 X95.336 Y134.779 E.00249
G1 X95.241 Y134.717 E.00249
G1 X79.79 Y119.266 E.47925
G1 X79.727 Y119.171 E.00249
G1 X79.79 Y119.076 E.00249
G1 X90.998 Y107.867 E.34766
G1 X91.093 Y107.805 E.00249
G1 X91.188 Y107.867 E.00249
G1 X92.97 Y109.649 E.05527
G1 X92.899 Y110.285 F30000
; LINE_WIDTH: 0.110909
G1 F15000
G1 X94.322 Y111.708 E.01115
G1 X95.02 Y112.407 F30000
G1 F15000
G1 X96.443 Y113.829 E.01115
G1 X90.723 Y108.935 F30000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X105.571 Y123.784 E.64524
G1 X105.305 Y124.05
G1 X90.456 Y109.202 E.64524
G1 X90.189 Y109.468
G1 X105.038 Y124.317 E.64524
G1 X104.771 Y124.584
G1 X89.923 Y109.735 E.64524
G1 X89.656 Y110.002
G1 X104.505 Y124.85 E.64524
G1 X104.238 Y125.117
G1 X89.389 Y110.268 E.64524
G1 X89.123 Y110.535
G1 X103.971 Y125.384 E.64524
G1 X103.705 Y125.65
G1 X88.856 Y110.802 E.64524
G1 X88.59 Y111.068
G1 X103.438 Y125.917 E.64524
G1 X103.172 Y126.183
G1 X88.323 Y111.335 E.64524
G1 X88.056 Y111.601
G1 X102.905 Y126.45 E.64524
G1 X102.638 Y126.717
G1 X87.79 Y111.868 E.64524
G1 X87.523 Y112.135
G1 X102.372 Y126.983 E.64524
G1 X102.105 Y127.25
G1 X87.256 Y112.401 E.64524
G1 X86.99 Y112.668
G1 X101.838 Y127.517 E.64524
G1 X101.572 Y127.783
G1 X86.723 Y112.935 E.64524
G1 X86.457 Y113.201
G1 X101.305 Y128.05 E.64524
G1 X101.039 Y128.316
G1 X86.19 Y113.468 E.64524
G1 X85.923 Y113.735
G1 X100.772 Y128.583 E.64524
G1 X100.505 Y128.85
G1 X85.657 Y114.001 E.64524
G1 X85.39 Y114.268
G1 X100.239 Y129.116 E.64524
G1 X99.972 Y129.383
G1 X85.123 Y114.534 E.64524
G1 X84.857 Y114.801
G1 X99.705 Y129.65 E.64524
G1 X99.439 Y129.916
G1 X84.59 Y115.068 E.64524
G1 X84.324 Y115.334
G1 X99.172 Y130.183 E.64524
G1 X98.905 Y130.45
G1 X84.057 Y115.601 E.64524
G1 X83.79 Y115.868
G1 X98.639 Y130.716 E.64524
G1 X98.372 Y130.983
G1 X83.524 Y116.134 E.64524
G1 X83.257 Y116.401
G1 X98.106 Y131.249 E.64524
G1 X97.839 Y131.516
G1 X82.99 Y116.667 E.64524
G1 X82.724 Y116.934
G1 X97.572 Y131.783 E.64524
G1 X97.306 Y132.049
G1 X82.457 Y117.201 E.64524
G1 X82.191 Y117.467
G1 X97.039 Y132.316 E.64524
G1 X96.772 Y132.583
G1 X81.924 Y117.734 E.64524
G1 X81.657 Y118.001
G1 X96.506 Y132.849 E.64524
G1 X96.239 Y133.116
G1 X81.391 Y118.267 E.64524
G1 X81.124 Y118.534
G1 X95.973 Y133.382 E.64524
G1 X95.706 Y133.649
G1 X80.857 Y118.8 E.64524
M204 S10000
G1 X95.461 Y133.921 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.39682
G1 F10172.368
G1 X80.586 Y119.046 E.60667
; WIPE_START
G1 X82 Y120.46 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X89.569 Y121.437 Z1.4 F30000
G1 X105.843 Y123.539 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.396905
G1 F10169.932
G1 X90.968 Y108.663 E.60681
; OBJECT_ID: 181
; WIPE_START
G1 X92.382 Y110.078 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X99.754 Y112.056 Z1.4 F30000
G1 X130.791 Y120.389 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X108.285 Y107.513 E.2126
G1 X113.666 Y102.133 E.25241
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
M73 P51 R13
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X108.573 Y107.801 E.1991
G1 X113.666 Y102.709 E.23891
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X108.851 Y108.078 E.17238
G1 X113.666 Y103.263 E.20925
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z1.4 F30000
G1 X101.799 Y111.197 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.44 Y109.395 Z1.4 F30000
G1 X119.636 Y105.793 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.788 Y106.945 E.05401
G1 X119.879 Y107.853 E.04263
G1 X117 Y104.975 E.13504
G1 X117.909 Y104.066 E.04263
G1 X116.758 Y102.915 E.05401
G1 X128.272 Y114.429 F30000
G1 F8843.478
G1 X129.423 Y115.58 E.05401
G1 X128.514 Y116.489 E.04263
G1 X125.636 Y113.61 E.13504
G1 X126.545 Y112.702 E.04263
G1 X123.666 Y109.823 E.13504
G1 X122.757 Y110.732 E.04263
G1 X121.606 Y109.58 E.05401
; WIPE_START
G1 X122.757 Y110.732 E-.61876
G1 X123.02 Y110.469 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X124.208 Y118.009 Z1.4 F30000
G1 X125.495 Y126.177 Z1.4
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X126.647 Y125.026 E.05401
G1 X127.555 Y125.935 E.04263
G1 X130.434 Y123.056 E.13504
G1 X129.525 Y122.147 E.04263
G1 X131.849 Y119.823 E.10902
G1 X131.393 Y119.367 E.0214
G1 X132.302 Y118.459 E.04263
G1 X133.667 Y119.823 E.06403
G1 X133.312 Y120.178 E.01662
G1 X113.312 Y100.177 E.93827
G1 X113.666 Y99.823 E.01662
G1 X115.031 Y101.188 E.06403
G1 X114.122 Y102.096 E.04263
G1 X113.666 Y101.64 E.0214
G1 X111.342 Y103.964 E.10902
G1 X110.433 Y103.056 E.04263
G1 X107.555 Y105.934 E.13504
G1 X108.463 Y106.843 E.04263
G1 X105.585 Y109.721 E.13504
G1 X104.676 Y108.813 E.04263
G1 X103.525 Y109.964 E.05401
; WIPE_START
G1 X104.676 Y108.813 E-.61876
G1 X104.939 Y109.075 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X109.538 Y115.167 Z1.4 F30000
G1 X119.261 Y128.045 Z1.4
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X118.109 Y126.894 E.05401
G1 X117.201 Y127.803 E.04263
G1 X114.322 Y124.924 E.13504
G1 X115.231 Y124.015 E.04263
G1 X112.353 Y121.137 E.13504
G1 X111.444 Y122.046 E.04263
G1 X108.565 Y119.167 E.13504
G1 X109.474 Y118.258 E.04263
G1 X106.596 Y115.38 E.13504
G1 X105.687 Y116.289 E.04263
G1 X103.706 Y114.308 E.09291
G1 X104.06 Y113.954 E.01662
G1 X121.798 Y131.692 E.83212
G1 X121.444 Y132.046 E.01662
G1 X120.079 Y130.681 E.06403
G1 X120.988 Y129.772 E.04263
G1 X121.444 Y130.228 E.0214
G1 X123.768 Y127.904 E.10902
G1 X124.677 Y128.813 E.04263
G1 X123.525 Y129.965 E.05401
; OBJECT_ID: 247
; WIPE_START
G1 X124.677 Y128.813 E-.61876
G1 X124.414 Y128.55 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X126.702 Y121.269 Z1.4 F30000
G1 X135.594 Y92.974 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.461 Y94.082 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X132.309 Y95.233 E.05401
G1 X117.792 Y80.716 E.68105
G1 X114.913 Y83.594 E.13504
G1 X129.431 Y98.112 E.68105
G1 X126.552 Y100.99 E.13504
G1 X112.035 Y86.473 E.68105
G1 X110.883 Y87.624 E.05401
G1 X109.375 Y88.844 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383128
G1 F3000;_EXTRUDE_SET_SPEED
G1 X109.301 Y88.732 E.00373
G1 X109.375 Y88.619 E.00373
G1 X119.938 Y78.056 E.41412
G1 X120.051 Y77.982 E.00373
G1 X120.163 Y78.056 E.00373
G1 X134.969 Y92.862 E.58045
G1 X135.042 Y92.974 E.00373
G3 X134.969 Y93.087 I-.311 J-.124 E.00376
G1 X124.406 Y103.649 E.41412
G1 X124.293 Y103.723 E.00373
G1 X124.181 Y103.649 E.00373
G1 X109.418 Y88.887 E.57879
; Slow Down End
G1 X120.401 Y78.807 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.552 Y79.958 E.05401
G1 X111.278 Y90.233 E.48201
G1 X114.156 Y93.112 E.13504
G1 X124.431 Y82.837 E.48201
G1 X127.309 Y85.715 E.13504
G1 X117.035 Y95.99 E.48201
G1 X119.913 Y98.869 E.13504
G1 X130.188 Y88.594 E.48201
G1 X133.066 Y91.472 E.13504
G1 X122.791 Y101.747 E.48201
G1 X123.943 Y102.899 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X122.791 Y101.747 E-.61876
G1 X123.054 Y101.484 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X115.427 Y101.769 Z1.4 F30000
G1 X100.257 Y102.335 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.008 Y102.161 E.01007
G3 X101.427 Y97.319 I1.655 J-2.144 E.21534
G3 X103.01 Y97.667 I.222 J2.762 E.05457
G3 X100.31 Y102.363 I-1.347 J2.35 E.2825
G1 X100.483 Y101.997 F30000
G1 F8843.478
G1 X100.256 Y101.837 E.00918
G3 X101.454 Y97.725 I1.407 J-1.821 E.1826
G3 X102.536 Y97.887 I.217 J2.241 E.03667
G3 X100.537 Y102.023 I-.872 J2.129 E.24918
M204 S250
G1 X100.702 Y101.664 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.479 Y98.116 I.962 J-1.648 E.14758
G3 X102.149 Y98.17 I.173 J2.052 E.02073
G3 X100.755 Y101.694 I-.485 J1.846 E.19831
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11762
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09494
G1 X100 Y100.97 E-.09495
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09498
G1 X99.748 Y100.074 E-.0726
; WIPE_END
G1 E-.04 F1800
G1 X97.214 Y93.588 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.208 Y93.647 E.00197
G3 X94.356 Y90.248 I-2.616 J-.701 E.392
G3 X95.939 Y90.596 I.222 J2.763 E.05457
G3 X97.277 Y93.299 I-1.347 J2.35 E.10611
G1 X97.227 Y93.53 E.00783
G1 X96.814 Y93.509 F30000
G1 F8843.478
G1 X96.815 Y93.542 E.0011
G3 X94.383 Y90.654 I-2.222 J-.597 E.33269
G3 X95.465 Y90.816 I.217 J2.242 E.03667
G3 X96.874 Y93.246 I-.872 J2.129 E.10021
G1 X96.828 Y93.45 E.00695
M204 S250
G1 X96.43 Y93.432 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X96.436 Y93.441 E.00032
G3 X94.408 Y91.045 I-1.843 J-.496 E.25526
G3 X95.078 Y91.099 I.172 J2.053 E.02073
G3 X96.485 Y93.195 I-.485 J1.846 E.08475
G1 X96.443 Y93.374 E.00565
; WIPE_START
M204 S10000
G1 X96.436 Y93.441 E-.02553
G1 X96.348 Y93.675 E-.09518
G1 X96.238 Y93.899 E-.09499
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.802 Y94.411 E-.06668
G1 X95.539 Y94.599 E-.12303
G1 X95.314 Y94.709 E-.09499
G1 X95.141 Y94.768 E-.06969
; WIPE_END
G1 E-.04 F1800
G1 X102.486 Y96.842 Z1.4 F30000
G1 X108.713 Y98.601 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
M73 P52 R13
G1 X107.305 Y97.193 E.53045
G1 X108.67 Y98.559 E.06405
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X107.593 Y96.905 E.54395
G1 X109.246 Y98.559 E.07755
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X107.87 Y96.628 E.51591
G1 X109.8 Y98.559 E.08389
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.239 Y98.387 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G2 X103.055 Y97.301 I-2.91 J1.985 E.05379
G1 X104.987 Y95.368 E.09066
G1 X107.866 Y98.247 E.13504
G1 X99.886 Y106.227 E.37435
G1 X100.24 Y106.581 E.01662
G1 X101.352 Y105.469 E.05214
G1 X89.129 Y93.247 E.57338
G1 X88.018 Y94.358 E.05214
G1 X88.372 Y94.713 E.01662
G1 X96.352 Y86.733 E.37435
G1 X95.998 Y86.379 E.01662
G1 X94.886 Y87.49 E.05214
G1 X107.109 Y99.712 E.57338
G1 X104.23 Y102.591 E.13504
G1 X103.818 Y102.179 E.01932
; WIPE_START
G1 X104.23 Y102.591 E-.22126
G1 X105.233 Y101.588 E-.53874
; WIPE_END
G1 E-.04 F1800
G1 X102.112 Y94.623 Z1.4 F30000
G1 X100.382 Y90.763 Z1.4
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X99.23 Y89.611 E.05401
G1 X97.298 Y91.544 E.09066
G3 X96.747 Y95.108 I-2.838 J1.386 E.12733
G1 X99.49 Y97.851 E.12869
G2 X98.94 Y101.415 I2.181 J2.161 E.12786
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X103.26 Y93.641 E.05401
; WIPE_START
G1 X102.109 Y92.49 E-.61876
G1 X101.846 Y92.753 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X94.375 Y91.189 Z1.4 F30000
G1 X92.419 Y90.78 Z1.4
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.01932
G1 X93.159 Y89.217 E.05401
; WIPE_START
G1 X92.008 Y90.368 E-.61876
G1 X92.27 Y90.631 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X92.394 Y98.263 Z1.4 F30000
G1 X92.402 Y98.742 Z1.4
G1 Z1
G1 E.8 F1800
G1 F8843.478
G1 X91.25 Y97.591 E.05401
G1 X93.183 Y95.659 E.09066
G3 X91.998 Y94.572 I1.415 J-2.732 E.05394
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X92.419 Y95.108 E-.25892
G1 X93.183 Y95.659 E-.35775
G1 X92.916 Y95.925 E-.14333
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 6/30
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S160.65
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z1.4 I.398 J1.15 P1  F30000
G1 X145.197 Y77.807 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 203
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X147.12 Y84.194 Z1.6 F30000
G1 X165.917 Y115.125 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z1.6 F30000
G1 X140.698 Y115.907 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y117.311 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
G1 F15000
G1 X143.807 Y116.111 E.01846
; WIPE_START
G1 X143.807 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.12 Y115.516 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X139.495 Y115.516 E.2328
G1 X139.103 Y115.515 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.512 Y115.518 E.59634
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.043 Y115.515 E.0287
G1 X138.502 Y115.121 F30000
; Slow Down Start
; LINE_WIDTH: 0.44762
G1 F3000;_EXTRUDE_SET_SPEED
G1 X138.502 Y98.904 E.53483
G1 X138.486 Y97.895 E.03328
G3 X139.495 Y97.911 I.178 J19.833 E.03329
G1 X166.92 Y97.911 E.90443
G1 X167.929 Y97.895 E.03328
G3 X167.913 Y98.904 I-19.833 J.178 E.03329
G1 X167.913 Y115.329 E.54167
G2 X167.929 Y116.338 I11.419 J.317 E.03329
G3 X166.92 Y116.321 I-.178 J-19.833 E.03329
G1 X147.728 Y116.321 E.63292
G1 X147.889 Y116.067 E.00992
G1 X147.906 Y115.911 E.00518
G1 X166.92 Y115.911 E.62705
G1 X167.021 Y115.905 E.00334
G1 X167.32 Y115.729 E.01144
G1 X167.497 Y115.43 E.01144
G1 X167.502 Y115.329 E.00334
G1 X167.502 Y98.904 E.54167
G1 X167.32 Y98.504 E.01449
G1 X166.92 Y98.321 E.01449
G1 X139.495 Y98.321 E.90443
G1 X139.394 Y98.327 E.00334
G1 X139.095 Y98.504 E.01144
G1 X138.913 Y98.904 E.01449
G1 X138.913 Y114.69 E.52059
G1 X138.86 Y114.713 E.00191
G1 X138.709 Y115.104 E.0138
G1 X138.562 Y115.116 E.00487
; Slow Down End
; WIPE_START
G1 X138.709 Y115.104 E-.05607
G1 X138.86 Y114.713 E-.15904
G1 X138.913 Y114.69 E-.02204
G1 X138.913 Y113.314 E-.52285
; WIPE_END
G1 E-.04 F1800
G1 X145.671 Y109.767 Z1.6 F30000
G1 X167.614 Y98.251 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.593 Y98.288 E.00115
G1 X167.53 Y98.251 E.002
G1 X167.541 Y98.245 E.00035
G1 X167.614 Y115.981 F30000
G1 F10696.458
G1 X167.593 Y116.018 E.00115
G1 X167.53 Y115.981 E.002
G1 X167.541 Y115.975 E.00035
; WIPE_START
G1 X167.53 Y115.981 E-.07648
G1 X167.593 Y116.018 E-.43333
G1 X167.614 Y115.981 E-.2502
; WIPE_END
G1 E-.04 F1800
G1 X161.119 Y111.973 Z1.6 F30000
M73 P52 R12
G1 X138.885 Y98.251 Z1.6
G1 Z1.2
G1 E.8 F1800
M73 P53 R12
G1 F10696.458
G1 X138.864 Y98.288 E.00115
G1 X138.801 Y98.251 E.002
G1 X138.812 Y98.245 E.00035
; WIPE_START
G1 X138.801 Y98.251 E-.07649
G1 X138.864 Y98.288 E-.43331
G1 X138.885 Y98.251 E-.25019
; WIPE_END
G1 E-.04 F1800
G1 X138.383 Y105.867 Z1.6 F30000
G1 X137.707 Y116.111 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y117.311 E.03802
; OBJECT_ID: 269
; WIPE_START
G1 X137.707 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.195 Y121.415 Z1.6 F30000
G1 X176.183 Y153.3 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00083
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X161.638 Y172.275 E.11717
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X126.446 Y161.679 E.05286
G1 X125.476 Y160 E.06432
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X123.623 Y141.249 E.05286
G1 X124.125 Y139.376 E.06431
G1 X125.476 Y136.113 E.11717
G1 X127.242 Y133.054 E.11717
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X149.867 Y121.111 E.06431
G1 X151.461 Y121.111 E.05286
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X164.697 Y125.604 E.11717
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.913 Y136.113 E.11717
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.432 Y144.71 E.06431
G1 X176.64 Y146.29 E.05286
G1 X176.64 Y149.822 E.11717
G1 X176.19 Y153.24 E.11436
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10695
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10695
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X126.785 Y161.483 E.04817
G1 X125.829 Y159.826 E.05878
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10695
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.001 Y141.351 E.04817
G1 X124.497 Y139.503 E.05878
G1 X125.829 Y136.287 E.10696
G1 X127.569 Y133.272 E.10696
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X136.269 Y125.147 E.04817
G1 X137.925 Y124.19 E.05878
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X149.867 Y121.503 E.05878
G1 X151.435 Y121.503 E.04817
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X164.479 Y125.931 E.10696
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.044 Y144.761 E.05878
G1 X176.248 Y146.316 E.04817
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.289 Y155.121 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z1.6 F30000
G1 X155.04 Y121.186 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X170.293 Y129.992 E.11888
G1 X172.474 Y132.835 E.11887
G1 X174.266 Y135.939 E.11888
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 6 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer6 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X161.812 Y172.628 E.11888
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y146.265 E.11887
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X125.124 Y135.939 E.11888
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X131.631 Y127.458 E.11888
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X153.082 Y120.928 E.05336
G1 X154.98 Y121.178 E.06352
M204 S250
G1 X155.115 Y120.801 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X155.116 Y120.801 E.00003
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.588 Y129.733 E.1117
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.771 Y135.765 E.11169
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X131.372 Y127.163 E.1117
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X153.133 Y120.54 E.05022
G1 X155.056 Y120.793 E.0596
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X155.116 Y120.801 E-.02314
G1 X156.989 Y121.303 E-.73686
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.74 Y126.843 Z1.6 F30000
G1 X116.764 Y163.76 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z1.6 F30000
G1 X100.964 Y139.541 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.56 Y136.55 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X100.76 Y136.55 E.03802
; WIPE_START
G1 X99.56 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
G1 X101.354 Y143.355 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.08 Y151.408 Z1.6 F30000
G1 X117.069 Y165.34 Z1.6
G1 Z1.2
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.447863
G1 F3000;_EXTRUDE_SET_SPEED
G1 X117.367 Y165.163 E.01145
G1 X117.544 Y164.864 E.01145
G1 X117.55 Y164.763 E.00334
G1 X117.55 Y138.338 E.87198
G1 X117.367 Y137.938 E.0145
G1 X116.968 Y137.756 E.0145
G1 X102.181 Y137.756 E.48791
G1 X102.158 Y137.703 E.00191
G1 X101.767 Y137.552 E.01381
G1 X101.75 Y137.345 E.00685
G1 X116.968 Y137.345 E.50215
G1 X117.977 Y137.329 E.0333
G3 X117.96 Y138.338 I-19.833 J.178 E.03331
G1 X117.96 Y164.763 E.87198
G2 X117.977 Y165.772 I11.419 J.317 E.03331
G3 X116.968 Y165.756 I-.178 J-19.833 E.03331
G1 X101.542 Y165.756 E.509
G1 X100.533 Y165.772 E.0333
G3 X100.55 Y164.763 I19.833 J-.178 E.03331
G1 X100.55 Y143.571 E.6993
G1 X100.804 Y143.732 E.00993
G1 X100.96 Y143.749 E.00519
G1 X100.96 Y164.763 E.69343
G1 X100.966 Y164.864 E.00334
G1 X101.142 Y165.163 E.01145
G1 X101.542 Y165.345 E.0145
G1 X117.009 Y165.343 E.51036
; Slow Down End
G1 X117.662 Y137.686 F30000
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.641 Y137.722 E.00115
G1 X117.578 Y137.686 E.002
G1 X117.589 Y137.679 E.00035
G1 X117.662 Y165.415 F30000
G1 F10696.458
G1 X117.641 Y165.452 E.00115
G1 X117.578 Y165.415 E.002
G1 X117.589 Y165.409 E.00035
G1 X100.932 Y165.415 F30000
G1 F10696.458
G1 X100.911 Y165.452 E.00115
G1 X100.848 Y165.415 E.002
G1 X100.859 Y165.409 E.00035
; OBJECT_ID: 214
; WIPE_START
G1 X100.848 Y165.415 E-.07652
G1 X100.911 Y165.452 E-.4333
G1 X100.932 Y165.415 E-.25018
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X98.923 Y158.052 Z1.6 F30000
G1 X94.964 Y143.538 Z1.6
G1 Z1.2
M73 P54 R12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z1.6 F30000
G1 X81.345 Y142.345 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z1.6 F30000
G1 X95.153 Y143.945 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z1.6 F30000
G1 X92.366 Y109.965 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z1.6 F30000
G1 X95.613 Y133.039 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z1.6 F30000
G1 X96.888 Y114.504 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 181
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X108.253 Y118.48 Z1.6 F30000
G1 X130.791 Y120.389 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X109.134 Y106.665 E.25241
G1 X113.666 Y102.133 E.2126
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X109.422 Y106.953 E.23891
G1 X113.666 Y102.709 E.1991
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X109.699 Y107.23 E.20925
G1 X113.666 Y103.263 E.17238
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z1.6 F30000
G1 X101.799 Y111.197 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.244 Y106.335 Z1.6 F30000
G1 X113.666 Y99.885 Z1.6
G1 Z1.2
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
G1 X133.605 Y119.823 E.86641
G1 X121.444 Y131.984 E.52842
G1 X103.768 Y114.308 E.76809
G1 X104.18 Y113.896 E.01791
G1 X104.315 Y113.95 E.00446
G1 X104.432 Y113.924 E.0037
G1 X104.759 Y113.605 E.01402
G1 X121.311 Y130.157 E.71925
G1 X121.444 Y130.212 E.00443
G1 X121.577 Y130.157 E.00443
G1 X131.778 Y119.957 E.44324
G2 X131.778 Y119.69 I-.176 J-.133 E.0088
G1 X113.799 Y101.712 E.78123
M73 P55 R12
G1 X113.666 Y101.656 E.00443
G1 X113.533 Y101.712 E.00443
G1 X103.635 Y111.609 E.43007
G1 X103.472 Y111.554 E.00531
G1 X103.366 Y111.593 E.00346
G1 X103.057 Y111.9 E.01338
G1 X102.354 Y111.197 E.03055
G1 X113.623 Y99.927 E.48971
; Slow Down End
G1 X113.666 Y100.418 F30000
; Slow Down Start
; LINE_WIDTH: 0.446833
G1 F3000;_EXTRUDE_SET_SPEED
G3 X114.368 Y101.143 I-13.901 J14.153 E.03322
G1 X132.346 Y119.122 E.83684
G1 X133.071 Y119.823 E.03322
G3 X132.346 Y120.525 I-14.141 J-13.889 E.03322
G1 X122.146 Y130.725 E.47479
G2 X121.444 Y131.451 I7.855 J8.303 E.03323
G3 X120.742 Y130.725 I13.901 J-14.153 E.03322
G1 X104.343 Y114.326 E.76335
G1 X104.636 Y114.26 E.0099
G1 X104.759 Y114.162 E.00517
G1 X121.032 Y130.435 E.75749
G1 X121.108 Y130.503 E.00333
G1 X121.444 Y130.589 E.01142
G1 X121.78 Y130.503 E.01142
G1 X121.856 Y130.435 E.00333
G1 X132.056 Y120.235 E.47479
G1 X132.123 Y120.16 E.00333
G1 X132.21 Y119.823 E.01142
G1 X132.056 Y119.412 E.01447
G1 X114.078 Y101.433 E.83684
G1 X113.666 Y101.279 E.01447
G1 X113.254 Y101.433 E.01447
G1 X103.506 Y111.182 E.45376
G1 X103.452 Y111.161 E.00191
G1 X103.069 Y111.331 E.01378
G1 X102.911 Y111.197 E.00683
G1 X112.964 Y101.143 E.46796
G1 X113.624 Y100.461 E.03124
; Slow Down End
G1 X132.609 Y119.823 F30000
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.588 Y119.86 E.00115
G1 X132.525 Y119.823 E.002
G1 X132.536 Y119.817 E.00035
G1 X121.486 Y130.946 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.465 Y130.983 E.00115
G1 X121.402 Y130.946 E.002
G1 X121.413 Y130.94 E.00035
; WIPE_START
G1 X121.402 Y130.946 E-.07646
G1 X121.465 Y130.983 E-.43334
G1 X121.486 Y130.946 E-.25021
; WIPE_END
G1 E-.04 F1800
G1 X119.572 Y123.558 Z1.6 F30000
G1 X113.708 Y100.923 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X113.687 Y100.959 E.00115
G1 X113.624 Y100.923 E.002
G1 X113.635 Y100.916 E.00035
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.07648
G1 X113.687 Y100.959 E-.43333
G1 X113.708 Y100.923 E-.2502
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.882 Y98.317 Z1.6 F30000
G1 X135.594 Y92.974 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.415 Y92.59 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41154
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X133.435 Y94.61 E.15486
G1 X133.762 Y94.284 E.02501
G1 X118.741 Y79.263 E1.15127
G1 X119.067 Y78.937 E.02501
G1 X134.088 Y93.957 E1.15127
G1 X134.414 Y93.631 E.02501
G1 X119.394 Y78.61 E1.15127
G1 X119.72 Y78.284 E.02501
G1 X134.741 Y93.305 E1.15127
G1 X135.067 Y92.978 E.02501
G1 X119.903 Y77.814 E1.16225
M106 S160.65
G1 X120.435 Y81.61 F30000
M106 S255
G1 F3000
G1 X118.415 Y79.589 E.15486
G1 X118.088 Y79.916 E.02501
G1 X133.109 Y94.936 E1.15127
G1 X132.783 Y95.263 E.02501
G1 X117.762 Y80.242 E1.15127
G1 X117.436 Y80.568 E.02501
G1 X132.456 Y95.589 E1.15127
G1 X132.13 Y95.916 E.02501
G1 X127.374 Y91.16 E.36451
G1 X127.048 Y91.486 E.02501
G1 X131.804 Y96.242 E.36451
G1 X131.477 Y96.568 E.02501
G1 X126.722 Y91.813 E.36451
G1 X126.395 Y92.139 E.02501
G1 X131.151 Y96.895 E.36451
G1 X130.825 Y97.221 E.02501
G1 X126.069 Y92.465 E.36451
G1 X125.742 Y92.792 E.02501
G1 X130.498 Y97.547 E.36451
G1 X130.172 Y97.874 E.02501
G1 X125.416 Y93.118 E.36451
G1 X125.09 Y93.444 E.02501
G1 X129.845 Y98.2 E.36451
G1 X129.519 Y98.526 E.02501
G1 X124.763 Y93.771 E.36451
G1 X124.437 Y94.097 E.02501
G1 X129.193 Y98.853 E.36451
G1 X128.866 Y99.179 E.02501
G1 X124.111 Y94.423 E.36451
G1 X123.784 Y94.75 E.02501
G1 X128.54 Y99.505 E.36451
G1 X128.214 Y99.832 E.02501
G1 X123.458 Y95.076 E.36451
G1 X123.132 Y95.402 E.02501
G1 X127.887 Y100.158 E.36451
G1 X127.561 Y100.485 E.02501
G1 X122.662 Y95.586 E.37548
M106 S160.65
G1 X125.85 Y89.478 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F8843.478
G1 X124.699 Y88.326 E.05401
G1 X119.896 Y93.129 E.22532
G1 X122.347 Y95.581 E.11501
G1 X124.624 Y93.304 E.10679
G1 X119.72 Y88.401 E.23002
G1 X120.872 Y87.25 E.05401
G1 X122.008 Y85.794 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.41154
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X117.109 Y80.895 E.37548
G1 X116.783 Y81.221 E.02501
G1 X121.539 Y85.977 E.36451
G1 X121.212 Y86.303 E.02501
G1 X116.457 Y81.548 E.36451
G1 X116.13 Y81.874 E.02501
G1 X120.886 Y86.63 E.36451
G1 X120.56 Y86.956 E.02501
G1 X115.804 Y82.2 E.36451
G1 X115.478 Y82.527 E.02501
G1 X120.233 Y87.282 E.36451
G1 X119.907 Y87.609 E.02501
G1 X115.151 Y82.853 E.36451
G1 X114.825 Y83.179 E.02501
G1 X119.581 Y87.935 E.36451
G1 X119.254 Y88.261 E.02501
G1 X114.498 Y83.506 E.36451
G1 X114.172 Y83.832 E.02501
G1 X118.928 Y88.588 E.36451
G1 X118.601 Y88.914 E.02501
G1 X113.846 Y84.158 E.36451
G1 X113.519 Y84.485 E.02501
G1 X118.275 Y89.241 E.36451
G1 X117.949 Y89.567 E.02501
G1 X113.193 Y84.811 E.36451
G1 X112.867 Y85.138 E.02501
G1 X117.622 Y89.893 E.36451
G1 X117.296 Y90.22 E.02501
G1 X112.54 Y85.464 E.36451
G1 X112.214 Y85.79 E.02501
G1 X127.235 Y100.811 E1.15127
G1 X126.908 Y101.137 E.02501
M73 P56 R12
G1 X111.888 Y86.117 E1.15127
G1 X111.561 Y86.443 E.02501
G1 X126.582 Y101.464 E1.15127
G1 X126.256 Y101.79 E.02501
G1 X111.235 Y86.769 E1.15127
G1 X110.908 Y87.096 E.02501
G1 X112.786 Y88.973 E.14388
G1 X112.541 Y89.218 E.01875
G1 X123.807 Y100.484 E.86351
G1 X124.052 Y100.239 E.01875
G1 X125.929 Y102.116 E.14388
G1 X125.603 Y102.443 E.02501
G1 X110.582 Y87.422 E1.15127
G1 X110.256 Y87.748 E.02501
G1 X125.276 Y102.769 E1.15127
G1 X124.95 Y103.095 E.02501
G1 X109.929 Y88.075 E1.15127
G1 X109.603 Y88.401 E.02501
G1 X124.624 Y103.422 E1.15127
G1 X124.297 Y103.748 E.02501
G1 X109.134 Y88.584 E1.16225
M106 S160.65
G1 X114.464 Y90.501 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F8843.478
G1 X122.507 Y98.577 E.3781
; OBJECT_ID: 258
; WIPE_START
G1 X121.096 Y97.16 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X113.694 Y99.024 Z1.6 F30000
G1 X100.344 Y102.386 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.302 Y102.357 E.00169
G3 X101.44 Y97.318 I1.36 J-2.341 E.2275
G3 X103.305 Y97.864 I.228 J2.676 E.06594
G3 X100.619 Y102.514 I-1.643 J2.152 E.25909
G1 X100.399 Y102.411 E.00808
G1 X100.483 Y101.996 F30000
G1 F8843.478
G1 X100.256 Y101.838 E.00918
G3 X101.467 Y97.724 I1.406 J-1.821 E.18312
G3 X102.806 Y98.02 I.183 J2.346 E.04616
G3 X100.536 Y102.023 I-1.144 J1.996 E.23909
M204 S250
G1 X100.702 Y101.664 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.493 Y98.115 I.96 J-1.649 E.14802
G3 X102.385 Y98.25 I.176 J1.858 E.02802
G3 X100.755 Y101.693 I-.723 J1.765 E.19043
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11759
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09494
G1 X99.76 Y100.265 E-.09496
G1 X99.748 Y100.074 E-.07264
; WIPE_END
G1 E-.04 F1800
G1 X97.213 Y93.593 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.206 Y93.647 E.00181
G3 X94.369 Y90.247 I-2.615 J-.701 E.39237
G3 X96.234 Y90.793 I.228 J2.676 E.06594
G3 X97.276 Y93.299 I-1.643 J2.152 E.09428
G1 X97.225 Y93.534 E.00799
G1 X96.814 Y93.513 F30000
G1 F8843.478
G1 X96.813 Y93.542 E.00094
G3 X94.396 Y90.653 I-2.222 J-.596 E.3332
G3 X95.735 Y90.949 I.183 J2.347 E.04616
G3 X96.872 Y93.245 I-1.144 J1.996 E.09014
G1 X96.826 Y93.455 E.00711
M204 S250
G1 X96.429 Y93.437 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X96.434 Y93.44 E.00018
G3 X94.422 Y91.044 I-1.843 J-.495 E.25569
G3 X95.314 Y91.179 I.176 J1.858 E.02802
G3 X96.483 Y93.194 I-.723 J1.766 E.07699
G1 X96.442 Y93.378 E.0058
; WIPE_START
M204 S10000
G1 X96.434 Y93.44 E-.02364
G1 X96.348 Y93.675 E-.09511
G1 X96.238 Y93.899 E-.09498
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09498
G1 X95.136 Y94.77 E-.07147
; WIPE_END
G1 E-.04 F1800
G1 X102.482 Y96.843 Z1.6 F30000
G1 X108.713 Y98.601 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X106.833 Y96.722 E.50833
G1 X108.67 Y98.559 E.08616
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X107.121 Y96.434 E.52183
G1 X109.246 Y98.559 E.09967
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X107.398 Y96.157 E.49543
G1 X109.8 Y98.559 E.10437
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.385 Y94.218 Z1.6 F30000
G1 X100.382 Y90.763 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X99.23 Y89.611 E.05401
G1 X97.298 Y91.544 E.09066
G3 X96.747 Y95.108 I-2.838 J1.386 E.12733
G1 X99.49 Y97.851 E.12869
G3 X103.055 Y97.301 I2.16 J2.17 E.12792
G1 X104.987 Y95.368 E.09066
G1 X102.109 Y92.49 E.13504
G1 X94.129 Y100.47 E.37435
G1 X97.007 Y103.348 E.13504
G1 X98.94 Y101.415 E.09066
G2 X100.026 Y102.6 I2.732 J-1.415 E.05394
G1 X98.734 Y105.075 F30000
G1 F8843.478
G1 X99.886 Y106.227 E.05401
G1 X107.866 Y98.247 E.37435
G1 X108.22 Y98.601 E.01662
G1 X107.109 Y99.712 E.05214
G1 X94.886 Y87.49 E.57338
G1 X95.998 Y86.379 E.05214
G1 X96.352 Y86.733 E.01662
G1 X88.372 Y94.713 E.37435
G1 X88.018 Y94.358 E.01662
G1 X89.129 Y93.247 E.05214
G1 X101.352 Y105.469 E.57338
G1 X104.23 Y102.591 E.13504
G1 X103.818 Y102.179 E.01932
; WIPE_START
G1 X104.23 Y102.591 E-.22126
G1 X103.228 Y103.593 E-.53874
; WIPE_END
G1 E-.04 F1800
G1 X97.277 Y98.813 Z1.6 F30000
G1 X91.998 Y94.572 Z1.6
G1 Z1.2
M73 P56 R11
G1 E.8 F1800
G1 F8843.478
G2 X93.183 Y95.659 I2.599 J-1.645 E.05394
G1 X91.25 Y97.591 E.09066
G1 X92.402 Y98.742 E.05401
; WIPE_START
G1 X91.25 Y97.591 E-.61876
G1 X91.513 Y97.328 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X93.031 Y89.848 Z1.6 F30000
G1 X93.159 Y89.217 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.05401
G1 X92.419 Y90.78 E.01931
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X92.008 Y90.368 E-.22125
G1 X93.01 Y89.366 E-.53875
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 7/30
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
M106 S188.7
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z1.6 I.263 J1.188 P1  F30000
G1 X145.197 Y77.807 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 203
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X147.12 Y84.194 Z1.8 F30000
G1 X165.917 Y115.125 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
M73 P57 R11
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z1.8 F30000
G1 X140.698 Y115.907 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.707 Y117.311 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.139 Y113.201 Z1.8 F30000
G1 X167.593 Y98.215 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.53 Y98.251 E.002
G1 X167.578 Y98.279 E.00151
G1 X167.593 Y115.945 F30000
G1 F10696.458
G1 X167.53 Y115.981 E.002
G1 X167.578 Y116.009 E.00151
G1 X147.906 Y115.911 F30000
; LINE_WIDTH: 0.452305
G1 F8793.689
G1 X147.889 Y116.067 E.00524
G1 X147.728 Y116.321 E.01003
G1 X166.92 Y116.321 E.64025
G2 X167.929 Y116.338 I.831 J-19.816 E.03367
G3 X167.913 Y115.329 I11.402 J-.692 E.03368
G1 X167.913 Y98.904 E.54794
G2 X167.929 Y97.895 I-19.816 J-.831 E.03367
G1 X166.92 Y97.911 E.03367
G1 X139.495 Y97.911 E.9149
G2 X138.486 Y97.895 I-.831 J19.816 E.03367
G1 X138.502 Y98.904 E.03367
G1 X138.502 Y115.121 E.54102
G1 X138.709 Y115.104 E.00692
G1 X138.86 Y114.713 E.01396
G1 X138.913 Y114.69 E.00193
G1 X138.913 Y98.904 E.52662
G1 X139.095 Y98.504 E.01466
G1 X139.394 Y98.327 E.01158
G1 X166.92 Y98.321 E.91827
G1 X167.32 Y98.504 E.01466
G1 X167.502 Y98.904 E.01466
G1 X167.502 Y115.329 E.54794
G1 X167.497 Y115.43 E.00338
G1 X167.32 Y115.729 E.01158
G1 X167.021 Y115.905 E.01158
G1 X166.92 Y115.911 E.00338
G1 X147.966 Y115.911 E.63231
G1 X147.512 Y115.518 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.103 Y115.515 E.03055
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.572 Y115.518 E.5945
; WIPE_START
G1 X149.572 Y115.518 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.555 Y109.027 Z1.8 F30000
G1 X138.864 Y98.215 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X138.801 Y98.251 E.002
G1 X138.848 Y98.279 E.00151
; OBJECT_ID: 269
; WIPE_START
G1 X138.801 Y98.251 E-.32672
G1 X138.864 Y98.215 E-.43328
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.145 Y104.534 Z1.8 F30000
G1 X176.183 Y153.299 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00085
G1 X175.588 Y155.531 E.07577
G1 X175.265 Y156.736 E.0414
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X162.719 Y171.651 E.07577
G1 X161.638 Y172.275 E.0414
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X153.726 Y174.704 E.0414
G1 X151.461 Y175.002 E.07577
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X126.618 Y161.978 E.0414
G1 X125.476 Y160 E.07577
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X123.047 Y152.087 E.0414
G1 X122.749 Y149.822 E.07577
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X127.242 Y133.054 E.11717
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X135.773 Y124.98 E.0414
G1 X137.752 Y123.838 E.07577
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X150.213 Y121.111 E.07577
G1 X151.461 Y121.111 E.0414
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X164.697 Y125.604 E.11717
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.289 Y135.032 E.07577
G1 X173.913 Y136.113 E.0414
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.191 Y153.24 E.11433
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X175.21 Y155.429 E.06939
G1 X174.893 Y156.61 E.03756
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X162.523 Y171.311 E.0694
G1 X161.464 Y171.922 E.03756
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X153.674 Y174.315 E.03756
G1 X151.435 Y174.61 E.06939
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X126.958 Y161.782 E.03756
G1 X125.829 Y159.826 E.0694
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.436 Y152.036 E.03756
G1 X123.141 Y149.797 E.06939
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X127.569 Y133.272 E.10696
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X135.969 Y125.319 E.03756
G1 X137.925 Y124.19 E.0694
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X150.213 Y121.503 E.06939
G1 X151.435 Y121.503 E.03756
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X164.479 Y125.931 E.10696
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X172.95 Y135.228 E.0694
G1 X173.561 Y136.287 E.03756
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.188 E.10511
; WIPE_START
M204 S10000
G1 X175.291 Y155.122 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.38 Y148.568 Z1.8 F30000
G1 X155.04 Y121.186 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X170.293 Y129.992 E.11888
G1 X172.474 Y132.835 E.11887
G1 X173.096 Y133.911 E.04122
G1 X174.266 Y135.939 E.07766
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 7 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer7 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X163.84 Y171.457 E.04122
G1 X161.812 Y172.628 E.07766
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.915 Y163.277 E.11887
G1 X126.294 Y162.201 E.04122
G1 X125.124 Y160.174 E.07766
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y146.265 E.11887
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X125.124 Y135.939 E.11888
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X131.631 Y127.458 E.11888
G1 X134.474 Y125.277 E.11887
G1 X135.55 Y124.656 E.04122
G1 X137.578 Y123.485 E.07766
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X152.718 Y120.88 E.04122
G1 X154.98 Y121.178 E.07567
M204 S250
G1 X155.116 Y120.801 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X155.116 Y120.801 E.00001
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.588 Y129.733 E.1117
G1 X172.801 Y132.617 E.11169
G1 X173.435 Y133.715 E.03897
G1 X174.619 Y135.765 E.07273
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X164.036 Y171.797 E.03897
G1 X161.986 Y172.98 E.07273
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X125.955 Y162.397 E.03897
G1 X124.771 Y160.347 E.07273
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.771 Y135.765 E.11169
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X131.372 Y127.163 E.1117
G1 X134.256 Y124.95 E.11169
G1 X135.354 Y124.316 E.03897
G1 X137.404 Y123.133 E.07273
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X152.77 Y120.492 E.03897
G1 X155.057 Y120.793 E.07088
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X155.116 Y120.801 E-.02288
G1 X156.99 Y121.303 E-.73712
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.741 Y126.843 Z1.8 F30000
G1 X116.764 Y163.76 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z1.8 F30000
G1 X100.964 Y139.541 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
M73 P58 R11
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.617 Y143.137 Z1.8 F30000
G1 X117.641 Y165.379 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y165.415 E.002
G1 X117.625 Y165.443 E.00151
G1 X100.911 Y165.379 F30000
G1 F10696.458
G1 X100.848 Y165.415 E.002
G1 X100.895 Y165.443 E.00151
G1 X100.96 Y143.749 F30000
; LINE_WIDTH: 0.452293
G1 F8793.946
G1 X100.804 Y143.732 E.00524
G1 X100.55 Y143.571 E.01003
G1 X100.55 Y164.763 E.70695
G2 X100.533 Y165.772 I19.816 J.831 E.03367
G1 X101.542 Y165.756 E.03367
G1 X116.968 Y165.756 E.51457
G2 X117.977 Y165.772 I.831 J-19.816 E.03367
G3 X117.96 Y164.763 I11.402 J-.692 E.03368
G1 X117.96 Y138.338 E.88151
G2 X117.977 Y137.329 I-19.816 J-.831 E.03367
G1 X116.968 Y137.345 E.03367
G1 X101.75 Y137.345 E.50765
G1 X101.767 Y137.552 E.00692
G1 X102.158 Y137.703 E.01396
G1 X102.181 Y137.756 E.00193
G1 X116.968 Y137.756 E.49325
G1 X117.367 Y137.938 E.01466
G1 X117.55 Y138.338 E.01466
G1 X117.55 Y164.763 E.88151
G1 X117.544 Y164.864 E.00338
G1 X117.367 Y165.163 E.01158
G1 X117.069 Y165.34 E.01158
G1 X101.542 Y165.345 E.51794
G1 X101.142 Y165.163 E.01466
G1 X100.966 Y164.864 E.01158
G1 X100.96 Y164.763 E.00338
G1 X100.96 Y143.809 E.69901
G1 X101.354 Y143.355 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.243 Y142.13 Z1.8 F30000
G1 X117.641 Y137.649 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y137.686 E.002
G1 X117.625 Y137.713 E.00151
; OBJECT_ID: 214
; WIPE_START
G1 X117.578 Y137.686 E-.32669
G1 X117.641 Y137.649 E-.43331
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X110.253 Y139.568 Z1.8 F30000
G1 X94.964 Y143.538 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z1.8 F30000
G1 X81.345 Y142.345 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z1.8 F30000
G1 X95.153 Y143.945 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z1.8 F30000
G1 X92.366 Y109.965 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.48 Y109.257 E.06504
G1 X92.777 Y109.554 E.01396
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z1.8 F30000
G1 X95.613 Y133.039 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z1.8 F30000
G1 X96.888 Y114.504 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X92.767 Y108.969 E.07855
G1 X93.353 Y109.554 E.02746
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.045 Y108.691 E.08481
G1 X93.907 Y109.554 E.03749
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 181
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X108.253 Y118.48 Z1.8 F30000
G1 X130.791 Y120.389 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X109.982 Y105.816 E.29222
G1 X113.666 Y102.133 E.1728
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
M73 P59 R11
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X110.27 Y106.104 E.27871
G1 X113.666 Y102.709 E.15929
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X110.548 Y106.381 E.24612
G1 X113.666 Y103.263 E.13551
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z1.8 F30000
G1 X101.799 Y111.197 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.417545
G1 F9609.606
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.72 Y114.099 Z1.8 F30000
G1 X132.588 Y119.787 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.525 Y119.823 E.002
G1 X132.572 Y119.851 E.00151
G1 X121.465 Y130.91 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.402 Y130.946 E.002
G1 X121.45 Y130.974 E.00151
G1 X104.759 Y114.162 F30000
; LINE_WIDTH: 0.452271
G1 F8794.426
G1 X104.636 Y114.26 E.00524
G1 X104.343 Y114.326 E.01003
G1 X120.742 Y130.725 E.77362
G2 X121.444 Y131.451 I14.602 J-13.428 E.03367
G3 X122.146 Y130.725 I8.557 J7.578 E.03367
G1 X132.346 Y120.525 E.48118
G2 X133.071 Y119.823 I-13.416 J-14.591 E.03367
G1 X132.346 Y119.122 E.03366
G1 X114.368 Y101.143 E.84811
G2 X113.666 Y100.418 I-14.602 J13.428 E.03367
G1 X112.964 Y101.143 E.03366
G1 X102.911 Y111.197 E.47426
G1 X103.069 Y111.331 E.00692
G1 X103.452 Y111.161 E.01396
G1 X103.506 Y111.182 E.00193
G1 X113.254 Y101.433 E.45986
G1 X113.666 Y101.279 E.01466
G1 X114.078 Y101.433 E.01466
G1 X132.056 Y119.412 E.84811
G1 X132.21 Y119.823 E.01466
G1 X132.123 Y120.16 E.01158
G1 X121.856 Y130.435 E.48456
G1 X121.78 Y130.503 E.00338
G1 X121.444 Y130.589 E.01158
G1 X121.108 Y130.503 E.01158
G1 X121.032 Y130.435 E.00338
G1 X104.801 Y114.204 E.76568
G1 X104.759 Y113.605 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.432 Y113.924 E.01402
G1 X104.315 Y113.95 E.0037
G1 X104.18 Y113.896 E.00446
G1 X103.768 Y114.308 E.01791
G1 X121.444 Y131.984 E.76809
G1 X133.605 Y119.823 E.52842
G1 X113.666 Y99.885 E.86641
G1 X102.354 Y111.197 E.49155
G1 X103.057 Y111.9 E.03055
G1 X103.366 Y111.593 E.01338
G1 X103.472 Y111.554 E.00346
G1 X103.635 Y111.609 E.00531
G1 X113.533 Y101.712 E.43007
G1 X113.666 Y101.656 E.00443
G1 X113.799 Y101.712 E.00443
G1 X131.778 Y119.69 E.78123
G1 X131.833 Y119.823 E.00443
G3 X131.778 Y119.957 I-.188 J0 E.00455
G1 X121.577 Y130.157 E.44324
G1 X121.444 Y130.212 E.00443
G1 X121.311 Y130.157 E.00443
G1 X104.801 Y113.647 E.7174
; WIPE_START
G1 X106.215 Y115.062 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.774 Y108.31 Z1.8 F30000
G1 X113.687 Y100.886 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X113.624 Y100.923 E.002
G1 X113.671 Y100.95 E.00151
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.32668
G1 X113.687 Y100.886 E-.43332
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.866 Y98.294 Z1.8 F30000
G1 X135.594 Y92.974 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X125.842 Y82.092 E.25166
G1 X136.682 Y92.932 E.47105
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.105 Y93.148 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.492 Y98.765 E.244
G1 X124.359 Y98.82 E.00443
G1 X124.119 Y98.786 E.00743
G1 X114.26 Y88.93 E.42836
G1 X114.204 Y88.797 E.00443
G1 X114.239 Y88.558 E.00743
G1 X119.852 Y82.941 E.244
G1 X119.985 Y82.885 E.00443
G1 X120.224 Y82.92 E.00743
G1 X130.084 Y92.775 E.42836
G1 X130.139 Y92.909 E.00443
G1 X130.114 Y93.089 E.00559
G1 X130.414 Y93.365 F30000
G1 F9547.299
G1 X124.759 Y99.032 E.246
G1 X124.567 Y99.158 E.00705
G1 X124.228 Y99.197 E.0105
G1 X123.903 Y99.095 E.01047
G1 X123.828 Y99.032 E.00301
G1 X113.993 Y89.197 E.42735
G1 X113.867 Y89.005 E.00705
G1 X113.827 Y88.666 E.0105
G1 X113.93 Y88.341 E.01047
G1 X113.993 Y88.266 E.00301
G1 X119.585 Y82.674 E.243
G1 X119.777 Y82.548 E.00705
G1 X120.116 Y82.508 E.0105
G1 X120.441 Y82.611 E.01047
G1 X120.516 Y82.674 E.00301
G1 X130.351 Y92.509 E.42735
G1 X130.477 Y92.7 E.00705
G1 X130.517 Y93.04 E.0105
G1 X130.432 Y93.307 E.00862
G1 X130.723 Y93.581 F30000
G1 F9547.299
G1 X130.617 Y93.706 E.00502
G1 X125.025 Y99.298 E.243
G1 X124.706 Y99.508 E.01175
G1 X124.228 Y99.574 E.01483
G1 X123.881 Y99.508 E.01085
G1 X123.561 Y99.298 E.01175
G1 X113.726 Y89.464 E.42735
G1 X113.517 Y89.144 E.01175
G1 X113.45 Y88.666 E.01483
G1 X113.517 Y88.319 E.01085
G1 X113.726 Y87.999 E.01175
G1 X119.319 Y82.407 E.243
G1 X119.638 Y82.197 E.01175
G1 X120.116 Y82.131 E.01483
G1 X120.463 Y82.197 E.01085
G1 X120.783 Y82.407 E.01175
G1 X130.617 Y92.242 E.42735
G1 X130.827 Y92.562 E.01175
G1 X130.894 Y93.04 E.01483
G1 X130.827 Y93.387 E.01085
G1 X130.751 Y93.528 E.00494
G1 X131.271 Y92.974 F30000
G1 F9547.299
G1 X131.178 Y93.526 E.01718
G3 X130.884 Y93.973 I-1.227 J-.486 E.01656
G1 X125.292 Y99.565 E.243
G1 X124.845 Y99.859 E.01645
G1 X124.293 Y99.952 E.01718
G1 X124.06 Y99.912 E.00726
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X123.742 Y99.859 E.00992
G3 X123.295 Y99.565 I.486 J-1.227 E.01656
G1 X113.46 Y89.73 E.42735
G1 X113.166 Y89.283 E.01645
G1 X113.112 Y88.964 E.00992
; Slow Down End
G1 F9547.299
G1 X113.073 Y88.732 E.00726
G1 X113.166 Y88.18 E.01718
G3 X113.46 Y87.733 I1.227 J.486 E.01656
G1 X119.052 Y82.141 E.243
G1 X119.499 Y81.847 E.01645
G1 X120.051 Y81.754 E.01718
G1 X120.379 Y81.809 E.01025
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X120.602 Y81.847 E.00693
G3 X121.049 Y82.141 I-.486 J1.227 E.01656
G1 X130.884 Y91.975 E.42735
G1 X131.178 Y92.423 E.01645
G1 X131.215 Y92.645 E.00693
; Slow Down End
G1 F9547.299
G1 X131.261 Y92.915 E.0084
G1 X131.34 Y94.014 F30000
; LINE_WIDTH: 0.407344
G1 F9878.607
G1 X131.145 Y94.234 E.00872
G1 X125.553 Y99.826 E.23485
G1 X124.983 Y100.21 E.02039
G1 X124.359 Y100.329 E.01888
G1 X123.603 Y100.21 E.02272
G1 X123.254 Y100.021 E.0118
G1 X123.033 Y99.826 E.00872
G1 X113.199 Y89.992 E.41302
G1 X112.815 Y89.422 E.02039
G1 X112.696 Y88.797 E.01888
G1 X112.815 Y88.041 E.02272
G1 X113.004 Y87.692 E.0118
G1 X113.199 Y87.472 E.00872
G1 X118.791 Y81.879 E.23485
G1 X119.36 Y81.496 E.02039
G1 X119.985 Y81.377 E.01888
G1 X120.741 Y81.496 E.02272
G1 X121.09 Y81.685 E.0118
G1 X121.311 Y81.879 E.00872
G1 X131.145 Y91.714 E.41302
G1 X131.529 Y92.284 E.02039
G1 X131.648 Y92.909 E.01888
G1 X131.529 Y93.664 E.02272
G1 X131.368 Y93.961 E.01002
G1 X109.304 Y88.732 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.293 Y103.721 E.65133
G1 X135.04 Y92.974 E.46697
G1 X120.051 Y77.985 E.65133
G1 X109.347 Y88.689 E.46512
G1 X109.838 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y103.187 E.62815
G1 X134.506 Y92.974 E.4438
G1 X120.051 Y78.518 E.62815
G1 X109.88 Y88.689 E.44195
G1 X110.371 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.654 E.60498
G1 X133.973 Y92.974 E.42062
G1 X120.051 Y79.052 E.60498
G1 X110.413 Y88.689 E.41878
G1 X110.904 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.121 E.58181
G1 X133.44 Y92.974 E.39745
G1 X120.051 Y79.585 E.58181
G1 X110.947 Y88.689 E.39561
G1 X111.437 Y88.732 F30000
; LINE_WIDTH: 0.408327
G1 F9852.027
G3 X112.943 Y90.248 I-76.701 J77.665 E.06361
G1 X122.777 Y100.082 E.41414
G3 X124.293 Y101.587 I-76.23 J78.288 E.06361
G3 X125.809 Y100.082 I77.746 J76.783 E.06361
G1 X131.401 Y94.49 E.23548
G3 X132.907 Y92.974 I78.206 J76.149 E.06361
G3 X131.401 Y91.458 I76.701 J-77.665 E.06361
G1 X121.567 Y81.624 E.41414
G3 X120.051 Y80.118 I76.189 J-78.247 E.06361
G3 X118.535 Y81.624 I-77.705 J-76.742 E.06361
G1 X112.943 Y87.216 E.23548
G3 X111.48 Y88.689 I-76.055 J-74.04 E.06183
G1 X111.939 Y88.732 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X112.42 Y89.213 E.01846
G1 X112.341 Y88.666 E.01498
G1 X112.42 Y88.25 E.01148
G1 X111.982 Y88.689 E.01683
G1 X119.57 Y81.101 F30000
; LINE_WIDTH: 0.37581
G1 F10814.383
G1 X120.116 Y81.022 E.01498
G1 X120.532 Y81.101 E.01148
G1 X120.051 Y80.62 E.01846
G1 X119.612 Y81.059 E.01683
G1 X131.923 Y92.493 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X132.003 Y93.04 E.01498
G1 X131.923 Y93.455 E.01148
G1 X132.405 Y92.974 E.01846
G1 X131.966 Y92.535 E.01683
G1 X124.774 Y100.604 F30000
; LINE_WIDTH: 0.3758
G1 F10814.707
G1 X124.228 Y100.684 E.01498
G1 X123.812 Y100.604 E.01148
G1 X124.293 Y101.085 E.01846
G1 X124.732 Y100.647 E.01683
G1 X115.424 Y89.541 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.576 Y90.692 E.05401
G1 X122.011 Y85.257 E.25498
G1 X124.89 Y88.135 E.13504
G1 X119.454 Y93.571 E.25498
G1 X122.333 Y96.449 E.13504
G1 X127.768 Y91.014 E.25498
G1 X129.729 Y92.974 E.09197
G1 X127.011 Y95.692 E.12749
G1 X117.333 Y86.014 E.45401
G1 X118.484 Y84.862 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X117.333 Y86.014 E-.61876
G1 X117.596 Y86.277 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X111.996 Y91.463 Z1.8 F30000
G1 X100.256 Y102.335 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.008 Y102.161 E.01006
G3 X101.454 Y97.317 I1.655 J-2.144 E.21627
G3 X103.305 Y97.864 I.215 J2.676 E.06549
G3 X100.309 Y102.363 I-1.643 J2.153 E.27068
G1 X100.482 Y101.996 F30000
G1 F8843.478
G1 X100.256 Y101.838 E.00917
G3 X101.481 Y97.723 I1.406 J-1.821 E.18354
G3 X102.806 Y98.02 I.17 J2.345 E.04571
G3 X100.536 Y102.023 I-1.144 J1.996 E.23911
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.506 Y98.114 I.961 J-1.649 E.14845
G3 X102.385 Y98.25 I.164 J1.855 E.0276
G3 X100.754 Y101.694 I-.723 J1.766 E.19053
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11764
G1 X100.303 Y101.366 E-.09497
M73 P60 R11
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09495
G1 X99.748 Y100.074 E-.07261
; WIPE_END
G1 E-.04 F1800
G1 X97.212 Y93.598 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.207 Y93.647 E.00165
G3 X94.383 Y90.246 I-2.616 J-.701 E.39292
G3 X96.234 Y90.793 I.215 J2.676 E.06549
G3 X97.276 Y93.299 I-1.643 J2.153 E.09429
G1 X97.224 Y93.539 E.00815
G1 X96.813 Y93.518 F30000
G1 F8843.478
G1 X96.812 Y93.541 E.00077
G3 X94.409 Y90.652 I-2.221 J-.597 E.3334
G3 X95.735 Y90.949 I.17 J2.346 E.04571
G3 X96.871 Y93.245 I-1.143 J1.995 E.09013
G1 X96.825 Y93.46 E.00727
M204 S250
G1 X96.435 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.435 Y91.043 I-1.843 J-.495 E.25611
G3 X95.314 Y91.179 I.164 J1.855 E.0276
G3 X96.449 Y93.382 I-.723 J1.766 E.08288
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11779
G1 X96.238 Y93.899 E-.09497
G1 X96.099 Y94.107 E-.09496
G1 X95.934 Y94.295 E-.09496
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09498
G1 X95.134 Y94.77 E-.07243
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z1.8 F30000
G1 X108.713 Y98.601 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X106.362 Y96.25 E.48622
G1 X108.67 Y98.559 E.10828
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X106.65 Y95.963 E.49972
G1 X109.246 Y98.559 E.12178
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X106.927 Y95.685 E.47494
G1 X109.8 Y98.559 E.12485
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.818 Y102.179 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.23 Y102.591 E.01932
G1 X101.352 Y105.469 E.13504
G1 X89.129 Y93.247 E.57338
G1 X88.018 Y94.358 E.05214
G1 X88.372 Y94.713 E.01662
G1 X96.352 Y86.733 E.37435
G1 X95.998 Y86.379 E.01662
G1 X94.886 Y87.49 E.05214
G1 X107.109 Y99.712 E.57338
G1 X108.22 Y98.601 E.05214
G1 X107.866 Y98.247 E.01662
G1 X99.886 Y106.227 E.37435
G1 X98.734 Y105.075 E.05401
G1 X92.402 Y98.742 F30000
G1 F8843.478
G1 X91.25 Y97.591 E.05401
G1 X93.183 Y95.658 E.09066
G3 X91.998 Y94.572 I1.414 J-2.731 E.05394
; WIPE_START
G1 X92.419 Y95.108 E-.25893
G1 X93.183 Y95.658 E-.35775
G1 X92.916 Y95.925 E-.14333
; WIPE_END
G1 E-.04 F1800
G1 X92.419 Y90.78 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.01931
G1 X93.159 Y89.217 E.05401
G1 X100.382 Y90.763 F30000
G1 F8843.478
G1 X99.23 Y89.611 E.05401
G1 X97.298 Y91.544 E.09066
G3 X96.747 Y95.108 I-2.735 J1.402 E.12785
G1 X99.49 Y97.851 E.12869
G2 X98.94 Y101.415 I2.287 J2.178 E.12733
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X104.987 Y95.368 E.13504
G1 X103.055 Y97.301 E.09066
G3 X104.239 Y98.387 I-1.414 J2.731 E.05394
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P60 R10
G1 F8843.478
G1 X103.818 Y97.851 E-.25895
G1 X103.055 Y97.301 E-.35772
G1 X103.321 Y97.034 E-.14333
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 8/30
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M106 S191.25
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z1.8 I.508 J1.106 P1  F30000
G1 X145.197 Y77.807 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 203
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X147.12 Y84.194 Z2 F30000
G1 X165.917 Y115.125 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z2 F30000
G1 X140.698 Y115.907 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.707 Y117.311 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.139 Y113.201 Z2 F30000
G1 X167.593 Y98.215 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.53 Y98.251 E.002
G1 X167.578 Y98.279 E.00151
G1 X167.593 Y115.945 F30000
G1 F10696.458
G1 X167.53 Y115.981 E.002
G1 X167.578 Y116.009 E.00151
G1 X147.906 Y115.911 F30000
; LINE_WIDTH: 0.452305
G1 F8793.689
G1 X147.889 Y116.067 E.00524
G1 X147.728 Y116.321 E.01003
G1 X166.92 Y116.321 E.64025
G2 X167.929 Y116.338 I.831 J-19.816 E.03367
G3 X167.913 Y115.329 I11.402 J-.692 E.03368
G1 X167.913 Y98.904 E.54794
G2 X167.929 Y97.895 I-19.816 J-.831 E.03367
G1 X166.92 Y97.911 E.03367
G1 X139.495 Y97.911 E.9149
G2 X138.486 Y97.895 I-.831 J19.816 E.03367
G1 X138.502 Y98.904 E.03367
G1 X138.502 Y115.121 E.54102
G1 X138.709 Y115.104 E.00692
G1 X138.86 Y114.713 E.01396
G1 X138.913 Y114.69 E.00193
G1 X138.913 Y98.904 E.52662
G1 X139.095 Y98.504 E.01466
G1 X139.394 Y98.327 E.01158
G1 X166.92 Y98.321 E.91827
G1 X167.32 Y98.504 E.01466
G1 X167.502 Y98.904 E.01466
G1 X167.502 Y115.329 E.54794
G1 X167.497 Y115.43 E.00338
G1 X167.32 Y115.729 E.01158
G1 X167.021 Y115.905 E.01158
G1 X166.92 Y115.911 E.00338
G1 X147.966 Y115.911 E.63231
G1 X147.512 Y115.518 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.103 Y115.515 E.03055
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.572 Y115.518 E.5945
; WIPE_START
G1 X149.572 Y115.518 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.555 Y109.027 Z2 F30000
G1 X138.864 Y98.215 Z2
G1 Z1.6
M73 P61 R10
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X138.801 Y98.251 E.002
G1 X138.848 Y98.279 E.00151
; OBJECT_ID: 269
; WIPE_START
G1 X138.801 Y98.251 E-.32672
G1 X138.864 Y98.215 E-.43328
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.145 Y104.534 Z2 F30000
G1 X176.183 Y153.298 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00087
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X162.42 Y171.823 E.08722
G1 X161.638 Y172.275 E.02995
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11717
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X125.476 Y160 E.11717
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X124.125 Y139.376 E.11717
G1 X125.476 Y136.113 E.11717
G1 X127.242 Y133.054 E.11717
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X137.752 Y123.838 E.11717
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X150.558 Y121.111 E.08722
G1 X151.461 Y121.111 E.02995
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X164.697 Y125.604 E.11717
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.462 Y135.331 E.08722
G1 X173.913 Y136.113 E.02995
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.191 Y153.239 E.11431
M204 S250
G1 X175.794 Y153.248 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10694
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X162.224 Y171.484 E.08001
G1 X161.464 Y171.922 E.02695
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.926 Y171.923 E.10696
G1 X134.911 Y170.182 E.10696
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X127.131 Y162.081 E.02695
G1 X125.829 Y159.826 E.08001
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X127.569 Y133.272 E.10696
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X135.67 Y125.492 E.02695
G1 X137.925 Y124.19 E.08001
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X150.558 Y121.503 E.08001
G1 X151.435 Y121.503 E.02695
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X164.479 Y125.931 E.10696
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.122 Y135.527 E.08001
G1 X173.561 Y136.287 E.02695
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.189 E.10513
; WIPE_START
M204 S10000
G1 X175.288 Y155.122 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.378 Y148.567 Z2 F30000
G1 X155.04 Y121.186 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X159.311 Y122.449 E.02906
G1 X161.812 Y123.485 E.08981
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11887
G1 X168.378 Y128.078 E.02907
G1 X170.293 Y129.992 E.08981
G1 X172.474 Y132.835 E.11888
G1 X174.266 Y135.939 E.11887
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y147.141 E.02906
G1 X177.033 Y149.848 E.08981
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11888
G1 X170.293 Y166.12 E.11887
G1 X167.759 Y168.654 E.11888
; object ids of layer 8 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer8 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11888
G1 X161.812 Y172.628 E.11887
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X150.611 Y175.394 E.02906
G1 X147.903 Y175.394 E.08981
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X125.124 Y160.174 E.11888
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y148.972 E.02906
G1 X122.357 Y146.265 E.08981
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X124.087 Y138.441 E.02906
G1 X125.124 Y135.939 E.08981
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11887
G1 X129.716 Y129.373 E.02907
G1 X131.631 Y127.458 E.08982
G1 X134.474 Y125.277 E.11887
G1 X137.578 Y123.485 E.11888
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X148.779 Y120.718 E.02906
G1 X151.487 Y120.718 E.08981
G1 X154.98 Y121.178 E.11689
M204 S250
G1 X155.116 Y120.801 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X158.627 Y121.742 E.11169
G1 X159.461 Y122.087 E.02771
G1 X161.986 Y123.133 E.08398
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X168.655 Y127.801 E.02771
G1 X170.588 Y129.733 E.08398
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.11169
G1 X174.964 Y136.598 E.02771
G1 X176.01 Y139.124 E.08398
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y147.141 E.02771
G1 X177.425 Y149.874 E.08398
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.11169
G1 X172.801 Y163.495 E.1117
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.11169
G1 X161.153 Y173.325 E.02771
G1 X158.628 Y174.371 E.08398
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X150.611 Y175.786 E.02771
G1 X147.878 Y175.786 E.08398
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y148.972 E.02771
G1 X121.965 Y146.239 E.08398
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X123.725 Y138.291 E.02771
G1 X124.771 Y135.765 E.08398
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X129.439 Y129.096 E.02771
G1 X131.372 Y127.163 E.08398
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X148.779 Y120.326 E.02771
G1 X151.512 Y120.326 E.08398
G1 X155.057 Y120.793 E.10985
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X156.99 Y121.306 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.74 Y126.847 Z2 F30000
G1 X116.764 Y163.76 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z2 F30000
G1 X100.964 Y139.541 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.617 Y143.137 Z2 F30000
G1 X117.641 Y165.379 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y165.415 E.002
G1 X117.625 Y165.443 E.00151
G1 X100.911 Y165.379 F30000
G1 F10696.458
G1 X100.848 Y165.415 E.002
G1 X100.895 Y165.443 E.00151
G1 X100.96 Y143.749 F30000
; LINE_WIDTH: 0.452293
G1 F8793.946
G1 X100.804 Y143.732 E.00524
G1 X100.55 Y143.571 E.01003
G1 X100.55 Y164.763 E.70695
G2 X100.533 Y165.772 I19.816 J.831 E.03367
G1 X101.542 Y165.756 E.03367
G1 X116.968 Y165.756 E.51457
G2 X117.977 Y165.772 I.831 J-19.816 E.03367
G3 X117.96 Y164.763 I11.402 J-.692 E.03368
G1 X117.96 Y138.338 E.88151
G2 X117.977 Y137.329 I-19.816 J-.831 E.03367
G1 X116.968 Y137.345 E.03367
G1 X101.75 Y137.345 E.50765
G1 X101.767 Y137.552 E.00692
G1 X102.158 Y137.703 E.01396
G1 X102.181 Y137.756 E.00193
G1 X116.968 Y137.756 E.49325
G1 X117.367 Y137.938 E.01466
G1 X117.55 Y138.338 E.01466
G1 X117.55 Y164.763 E.88151
G1 X117.544 Y164.864 E.00338
G1 X117.367 Y165.163 E.01158
G1 X117.069 Y165.34 E.01158
G1 X101.542 Y165.345 E.51794
G1 X101.142 Y165.163 E.01466
G1 X100.966 Y164.864 E.01158
G1 X100.96 Y164.763 E.00338
G1 X100.96 Y143.809 E.69901
G1 X101.354 Y143.355 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.243 Y142.13 Z2 F30000
G1 X117.641 Y137.649 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y137.686 E.002
G1 X117.625 Y137.713 E.00151
; OBJECT_ID: 214
; WIPE_START
G1 X117.578 Y137.686 E-.32669
G1 X117.641 Y137.649 E-.43331
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X110.253 Y139.568 Z2 F30000
G1 X94.964 Y143.538 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z2 F30000
G1 X81.345 Y142.345 Z2
G1 Z1.6
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
M73 P62 R10
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z2 F30000
G1 X95.153 Y143.945 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X95.581 Y134.106 Z2 F30000
G1 X95.613 Y133.039 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X83.125 Y117.237 E.09074
G1 X91.093 Y109.268 E.37381
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X83.402 Y117.514 E.072
G1 X91.093 Y109.823 E.33421
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X93.391 Y123.698 Z2 F30000
G1 X92.366 Y109.965 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X96.471 Y114.105 Z2 F30000
G1 X96.888 Y114.504 Z2
G1 Z1.6
G1 E.8 F1800
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.217706
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21685
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.30231
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21685
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13958
; OBJECT_ID: 181
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X108.253 Y118.48 Z2 F30000
G1 X130.791 Y120.389 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X110.831 Y104.968 E.33202
G1 X113.666 Y102.133 E.13299
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X111.119 Y105.256 E.31852
G1 X113.666 Y102.709 E.11949
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X111.396 Y105.533 E.283
G1 X113.666 Y103.263 E.09863
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z2 F30000
G1 X101.799 Y111.197 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.76 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431723
G1 F9259.197
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.417568
G1 F9609.019
G1 X104.482 Y113.327 E.04961
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.72 Y114.099 Z2 F30000
G1 X132.588 Y119.787 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.525 Y119.823 E.002
G1 X132.572 Y119.851 E.00151
G1 X121.465 Y130.91 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.402 Y130.946 E.002
G1 X121.45 Y130.974 E.00151
G1 X104.759 Y114.162 F30000
; LINE_WIDTH: 0.452268
G1 F8794.475
G1 X104.636 Y114.26 E.00524
G1 X104.343 Y114.326 E.01003
G1 X120.742 Y130.725 E.77362
G2 X121.444 Y131.451 I14.602 J-13.428 E.03367
G3 X122.146 Y130.725 I8.557 J7.578 E.03367
G1 X132.346 Y120.525 E.48118
G2 X133.071 Y119.823 I-13.416 J-14.591 E.03367
G1 X132.346 Y119.122 E.03366
G1 X114.368 Y101.143 E.84811
G2 X113.666 Y100.418 I-14.602 J13.428 E.03367
G1 X112.964 Y101.143 E.03366
G1 X102.911 Y111.197 E.47426
G1 X103.069 Y111.331 E.00692
G1 X103.452 Y111.161 E.01396
G1 X103.506 Y111.182 E.00193
G1 X113.254 Y101.433 E.45986
G1 X113.666 Y101.279 E.01466
G1 X114.078 Y101.433 E.01466
G1 X132.056 Y119.412 E.84811
G1 X132.21 Y119.823 E.01466
G1 X132.123 Y120.16 E.01158
G1 X121.856 Y130.435 E.48455
G1 X121.78 Y130.503 E.00338
G1 X121.444 Y130.589 E.01158
G1 X121.108 Y130.503 E.01158
G1 X121.032 Y130.435 E.00338
G1 X104.801 Y114.204 E.76568
G1 X104.759 Y113.605 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.432 Y113.924 E.01402
G1 X104.315 Y113.95 E.0037
G1 X104.18 Y113.896 E.00446
G1 X103.768 Y114.308 E.01791
G1 X121.444 Y131.984 E.76809
G1 X133.605 Y119.823 E.52842
G1 X113.666 Y99.885 E.86641
G1 X102.354 Y111.197 E.49155
G1 X103.057 Y111.9 E.03055
G1 X103.366 Y111.593 E.01338
G1 X103.472 Y111.554 E.00346
G1 X103.635 Y111.609 E.00531
G1 X113.533 Y101.712 E.43007
G1 X113.666 Y101.656 E.00443
G1 X113.799 Y101.712 E.00443
G1 X131.778 Y119.69 E.78123
G1 X131.833 Y119.823 E.00443
G3 X131.778 Y119.957 I-.188 J0 E.00455
G1 X121.577 Y130.157 E.44324
G1 X121.444 Y130.212 E.00443
G1 X121.311 Y130.157 E.00443
G1 X104.801 Y113.647 E.7174
; WIPE_START
G1 X106.215 Y115.062 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.774 Y108.31 Z2 F30000
G1 X113.687 Y100.886 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X113.624 Y100.923 E.002
G1 X113.671 Y100.95 E.00151
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.32668
G1 X113.687 Y100.886 E-.43332
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.866 Y98.294 Z2 F30000
G1 X135.594 Y92.974 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
M73 P63 R10
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.105 Y93.148 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.492 Y98.765 E.244
G1 X124.359 Y98.82 E.00443
G1 X124.119 Y98.786 E.00743
G1 X114.26 Y88.93 E.42836
G1 X114.204 Y88.797 E.00443
G1 X114.239 Y88.558 E.00743
G1 X119.852 Y82.941 E.244
G1 X119.985 Y82.885 E.00443
G1 X120.224 Y82.92 E.00743
G1 X130.084 Y92.775 E.42836
G1 X130.139 Y92.909 E.00443
G1 X130.114 Y93.089 E.00559
G1 X130.414 Y93.365 F30000
G1 F9547.299
G1 X124.759 Y99.032 E.246
G1 X124.567 Y99.158 E.00705
G1 X124.228 Y99.197 E.0105
G1 X123.903 Y99.095 E.01047
G1 X123.828 Y99.032 E.00301
G1 X113.993 Y89.197 E.42735
G1 X113.867 Y89.005 E.00705
G1 X113.827 Y88.666 E.0105
G1 X113.93 Y88.341 E.01047
G1 X113.993 Y88.266 E.00301
G1 X119.585 Y82.674 E.243
G1 X119.777 Y82.548 E.00705
G1 X120.116 Y82.508 E.0105
G1 X120.441 Y82.611 E.01047
G1 X120.516 Y82.674 E.00301
G1 X130.351 Y92.509 E.42735
G1 X130.477 Y92.7 E.00705
G1 X130.517 Y93.04 E.0105
G1 X130.432 Y93.307 E.00862
G1 X130.723 Y93.581 F30000
G1 F9547.299
G1 X130.617 Y93.706 E.00502
G1 X125.025 Y99.298 E.243
G1 X124.706 Y99.508 E.01175
G1 X124.228 Y99.574 E.01483
G1 X123.881 Y99.508 E.01085
G1 X123.561 Y99.298 E.01175
G1 X113.726 Y89.464 E.42735
G1 X113.517 Y89.144 E.01175
G1 X113.45 Y88.666 E.01483
G1 X113.517 Y88.319 E.01085
G1 X113.726 Y87.999 E.01175
G1 X119.319 Y82.407 E.243
G1 X119.638 Y82.197 E.01175
G1 X120.116 Y82.131 E.01483
G1 X120.463 Y82.197 E.01085
G1 X120.783 Y82.407 E.01175
G1 X130.617 Y92.242 E.42735
G1 X130.827 Y92.562 E.01175
G1 X130.894 Y93.04 E.01483
G1 X130.827 Y93.387 E.01085
G1 X130.751 Y93.528 E.00494
G1 X131.031 Y93.798 F30000
G1 F9547.299
G1 X130.884 Y93.973 E.00703
G1 X125.292 Y99.565 E.243
G1 X124.845 Y99.859 E.01645
G1 X124.293 Y99.952 E.01718
G1 X123.742 Y99.859 E.01718
G3 X123.295 Y99.565 I.486 J-1.227 E.01656
G1 X113.46 Y89.73 E.42735
G1 X113.166 Y89.283 E.01645
G1 X113.073 Y88.732 E.01718
G1 X113.166 Y88.18 E.01718
G3 X113.46 Y87.733 I1.227 J.486 E.01656
G1 X119.052 Y82.141 E.243
G1 X119.499 Y81.847 E.01645
G1 X120.051 Y81.754 E.01718
G1 X120.602 Y81.847 E.01718
G3 X121.049 Y82.141 I-.486 J1.227 E.01656
G1 X130.884 Y91.975 E.42735
G1 X131.178 Y92.423 E.01645
G1 X131.271 Y92.974 E.01718
G1 X131.178 Y93.526 E.01718
G1 X131.06 Y93.745 E.00766
G1 X131.34 Y94.014 F30000
; LINE_WIDTH: 0.407344
G1 F9878.607
G1 X131.145 Y94.234 E.00872
G1 X125.553 Y99.826 E.23485
G1 X124.983 Y100.21 E.02039
G1 X124.359 Y100.329 E.01888
G1 X123.603 Y100.21 E.02272
G1 X123.254 Y100.021 E.0118
G1 X123.033 Y99.826 E.00872
G1 X113.199 Y89.992 E.41302
G1 X112.815 Y89.422 E.02039
G1 X112.696 Y88.797 E.01888
G1 X112.815 Y88.041 E.02272
G1 X113.004 Y87.692 E.0118
G1 X113.199 Y87.472 E.00872
G1 X118.791 Y81.879 E.23485
G1 X119.36 Y81.496 E.02039
G1 X119.985 Y81.377 E.01888
G1 X120.741 Y81.496 E.02272
G1 X121.09 Y81.685 E.0118
G1 X121.311 Y81.879 E.00872
G1 X131.145 Y91.714 E.41302
G1 X131.529 Y92.284 E.02039
G1 X131.648 Y92.909 E.01888
G1 X131.529 Y93.664 E.02272
G1 X131.368 Y93.961 E.01002
G1 X109.304 Y88.732 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.293 Y103.721 E.65133
G1 X135.04 Y92.974 E.46697
G1 X120.051 Y77.985 E.65133
G1 X109.347 Y88.689 E.46512
G1 X109.838 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y103.187 E.62815
G1 X134.506 Y92.974 E.4438
G1 X120.051 Y78.518 E.62815
G1 X109.88 Y88.689 E.44195
G1 X110.371 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.654 E.60498
G1 X133.973 Y92.974 E.42062
G1 X120.051 Y79.052 E.60498
G1 X110.413 Y88.689 E.41878
G1 X110.904 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.121 E.58181
G1 X133.44 Y92.974 E.39745
G1 X120.051 Y79.585 E.58181
G1 X110.947 Y88.689 E.39561
G1 X111.437 Y88.732 F30000
; LINE_WIDTH: 0.408327
G1 F9852.027
G3 X112.943 Y90.248 I-76.701 J77.665 E.06361
G1 X122.777 Y100.082 E.41414
G3 X124.293 Y101.587 I-76.23 J78.288 E.06361
G3 X125.809 Y100.082 I77.746 J76.783 E.06361
G1 X131.401 Y94.49 E.23548
G3 X132.907 Y92.974 I78.206 J76.149 E.06361
G3 X131.401 Y91.458 I76.701 J-77.665 E.06361
G1 X121.567 Y81.624 E.41414
G3 X120.051 Y80.118 I76.189 J-78.247 E.06361
G3 X118.535 Y81.624 I-77.705 J-76.742 E.06361
G1 X112.943 Y87.216 E.23548
G3 X111.48 Y88.689 I-76.055 J-74.04 E.06183
G1 X111.939 Y88.732 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X112.42 Y89.213 E.01846
G1 X112.341 Y88.666 E.01498
G1 X112.42 Y88.25 E.01148
G1 X111.982 Y88.689 E.01683
G1 X119.57 Y81.101 F30000
; LINE_WIDTH: 0.37581
G1 F10814.383
G1 X120.116 Y81.022 E.01498
G1 X120.532 Y81.101 E.01148
G1 X120.051 Y80.62 E.01846
G1 X119.612 Y81.059 E.01683
G1 X131.923 Y92.493 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X132.003 Y93.04 E.01498
G1 X131.923 Y93.455 E.01148
G1 X132.405 Y92.974 E.01846
G1 X131.966 Y92.535 E.01683
G1 X124.774 Y100.604 F30000
; LINE_WIDTH: 0.3758
G1 F10814.707
G1 X124.228 Y100.684 E.01498
G1 X123.812 Y100.604 E.01148
G1 X124.293 Y101.085 E.01846
G1 X124.732 Y100.647 E.01683
G1 X118.484 Y84.862 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X117.333 Y86.014 E.05401
G1 X127.011 Y95.692 E.45401
G1 X129.729 Y92.974 E.12749
G1 X127.768 Y91.014 E.09197
G1 X122.333 Y96.449 E.25498
G1 X119.454 Y93.571 E.13504
G1 X124.89 Y88.135 E.25498
G1 X122.011 Y85.257 E.13504
G1 X116.576 Y90.692 E.25498
G1 X115.424 Y89.541 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X116.576 Y90.692 E-.61876
G1 X116.839 Y90.429 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X110.639 Y94.881 Z2 F30000
G1 X100.256 Y102.335 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.007 Y102.162 E.01005
G3 X101.467 Y97.316 I1.655 J-2.144 E.21674
G3 X103.305 Y97.864 I.203 J2.676 E.06505
G3 X100.308 Y102.364 I-1.643 J2.154 E.27076
G1 X100.482 Y101.996 F30000
G1 F8843.478
G1 X100.257 Y101.837 E.00916
G3 X101.494 Y97.722 I1.406 J-1.82 E.18391
G3 X102.806 Y98.02 I.157 J2.346 E.04527
G3 X100.536 Y102.022 I-1.143 J1.996 E.23906
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.52 Y98.114 I.961 J-1.648 E.14884
G3 X102.385 Y98.25 I.151 J1.853 E.02719
G3 X100.754 Y101.694 I-.722 J1.766 E.19055
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11763
G1 X100.303 Y101.366 E-.09497
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09496
G1 X99.748 Y100.074 E-.07262
; WIPE_END
G1 E-.04 F1800
G1 X97.188 Y93.688 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.093 Y93.984 E.01031
G3 X94.396 Y90.245 I-2.502 J-1.037 E.38155
G3 X96.234 Y90.793 I.203 J2.676 E.06505
G3 X97.211 Y93.632 I-1.643 J2.153 E.10557
G1 X96.812 Y93.523 F30000
G1 F8843.478
G1 X96.814 Y93.542 E.00062
G3 X94.423 Y90.651 I-2.222 J-.596 E.33404
G3 X95.735 Y90.949 I.157 J2.346 E.04527
G3 X96.873 Y93.246 I-1.143 J1.996 E.09015
G1 X96.824 Y93.465 E.00744
M204 S250
G1 X96.435 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.449 Y91.043 I-1.843 J-.495 E.2565
G3 X95.314 Y91.179 I.151 J1.853 E.02719
G3 X96.45 Y93.382 I-.722 J1.766 E.08288
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11781
G1 X96.238 Y93.899 E-.09499
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09497
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.134 Y94.77 E-.07241
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z2 F30000
G1 X108.713 Y98.601 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X105.891 Y95.779 E.4641
G1 X108.67 Y98.559 E.13039
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X106.178 Y95.491 E.47761
G1 X109.246 Y98.559 E.1439
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X106.456 Y95.214 E.45446
G1 X109.8 Y98.559 E.14534
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.239 Y98.387 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G2 X103.055 Y97.301 I-2.599 J1.645 E.05394
G1 X104.987 Y95.368 E.09066
G1 X102.109 Y92.49 E.13504
G1 X94.129 Y100.47 E.37435
G1 X97.007 Y103.348 E.13504
G1 X98.94 Y101.415 E.09066
G3 X99.49 Y97.851 I2.838 J-1.386 E.12732
G1 X96.747 Y95.108 E.12869
G2 X97.298 Y91.544 I-2.288 J-2.178 E.12733
G1 X99.23 Y89.611 E.09066
G1 X100.382 Y90.763 E.05401
G1 X93.159 Y89.217 F30000
G1 F8843.478
G1 X92.008 Y90.368 E.05401
G1 X92.419 Y90.78 E.01931
; WIPE_START
G1 X92.008 Y90.368 E-.22126
G1 X93.01 Y89.366 E-.53874
; WIPE_END
G1 E-.04 F1800
G1 X91.998 Y94.572 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F8843.478
G2 X93.183 Y95.659 I2.599 J-1.645 E.05394
G1 X91.25 Y97.591 E.09066
G1 X92.402 Y98.742 E.05401
G1 X98.734 Y105.075 F30000
G1 F8843.478
G1 X99.886 Y106.227 E.05401
G1 X107.866 Y98.247 E.37435
G1 X108.22 Y98.601 E.01662
G1 X107.109 Y99.712 E.05214
G1 X94.886 Y87.49 E.57338
G1 X95.998 Y86.379 E.05214
G1 X96.352 Y86.733 E.01662
G1 X88.372 Y94.713 E.37435
G1 X88.018 Y94.358 E.01662
G1 X89.129 Y93.247 E.05214
G1 X101.352 Y105.469 E.57338
G1 X104.23 Y102.591 E.13504
G1 X103.818 Y102.179 E.01932
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X104.23 Y102.591 E-.22126
G1 X103.228 Y103.593 E-.53874
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 9/30
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z2 I.646 J1.032 P1  F30000
G1 X145.197 Y77.326 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X145.197 Y77.807 E.01595
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.266 E.00467
; WIPE_START
G1 X145.197 Y77.807 E-.20553
G1 X143.738 Y77.807 E-.55447
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P63 R9
G1 X145.604 Y77.326 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X145.604 Y77.718 E.01301
G1 X148.009 Y77.718 E.07975
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.266 E.01818
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
M73 P64 R9
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 203
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X147.12 Y84.194 Z2.2 F30000
G1 X165.917 Y115.125 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X139.698 Y115.125 E.86974
G1 X139.698 Y99.107 E.53136
G1 X166.717 Y99.107 E.89625
G1 X166.717 Y115.125 E.53136
G1 X165.977 Y115.125 E.02452
G1 X166.31 Y114.326 F30000
G1 F8843.478
G1 X166.31 Y114.718 E.01301
G1 X140.105 Y114.718 E.86924
G1 X140.105 Y99.514 E.50435
G1 X166.31 Y99.514 E.86924
G1 X166.31 Y114.266 E.48935
M204 S250
G1 X165.917 Y114.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.304 Y114.808 Z2.2 F30000
G1 X140.698 Y115.907 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X137.717 Y115.907 E.09891
G1 X137.717 Y97.125 E.62302
G1 X168.698 Y97.125 E1.02772
G1 X168.698 Y117.107 E.66283
G1 X146.917 Y117.107 E.72254
G1 X146.917 Y115.907 E.03981
G1 X140.758 Y115.907 E.20428
G1 X141.105 Y116.314 F30000
G1 F8843.478
G1 X141.105 Y117.514 E.03981
G1 X140.51 Y117.514 E.01977
G1 X140.51 Y116.314 E.03981
G1 X138.105 Y116.314 E.07975
G1 X138.105 Y117.514 E.03981
G1 X137.31 Y117.514 E.0264
G1 X137.31 Y96.718 E.68984
G1 X169.105 Y96.718 E1.05473
G1 X169.105 Y117.514 E.68984
G1 X146.51 Y117.514 E.74955
G1 X146.51 Y116.314 E.03981
G1 X144.105 Y116.314 E.07975
G1 X144.105 Y117.514 E.03981
G1 X143.51 Y117.514 E.01977
G1 X143.51 Y116.314 E.03981
G1 X141.165 Y116.314 E.07776
M204 S250
G1 X141.497 Y116.706 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
M204 S10000
G1 X140.807 Y116.111 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X140.807 Y117.311 E.01846
; WIPE_START
G1 X140.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.495 Y115.516 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X147.12 Y115.516 E.2328
; WIPE_START
G1 X145.12 Y115.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.807 Y116.111 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.23172
G1 F15000
G1 X143.807 Y117.311 E.01846
; WIPE_START
G1 X143.807 Y116.111 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.707 Y117.311 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X137.707 Y116.111 E.03802
; WIPE_START
G1 X137.707 Y117.311 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.139 Y113.201 Z2.2 F30000
G1 X167.593 Y98.215 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X167.53 Y98.251 E.002
G1 X167.578 Y98.279 E.00151
G1 X167.593 Y115.945 F30000
G1 F10696.458
G1 X167.53 Y115.981 E.002
G1 X167.578 Y116.009 E.00151
G1 X147.906 Y115.911 F30000
; LINE_WIDTH: 0.452305
G1 F8793.689
G1 X147.889 Y116.067 E.00524
G1 X147.728 Y116.321 E.01003
G1 X166.92 Y116.321 E.64025
G2 X167.929 Y116.338 I.831 J-19.816 E.03367
G3 X167.913 Y115.329 I11.402 J-.692 E.03368
G1 X167.913 Y98.904 E.54794
G2 X167.929 Y97.895 I-19.816 J-.831 E.03367
G1 X166.92 Y97.911 E.03367
G1 X139.495 Y97.911 E.9149
G2 X138.486 Y97.895 I-.831 J19.816 E.03367
G1 X138.502 Y98.904 E.03367
G1 X138.502 Y115.121 E.54102
G1 X138.709 Y115.104 E.00692
G1 X138.86 Y114.713 E.01396
G1 X138.913 Y114.69 E.00193
G1 X138.913 Y98.904 E.52662
G1 X139.095 Y98.504 E.01466
G1 X139.394 Y98.327 E.01158
G1 X166.92 Y98.321 E.91827
G1 X167.32 Y98.504 E.01466
G1 X167.502 Y98.904 E.01466
G1 X167.502 Y115.329 E.54794
G1 X167.497 Y115.43 E.00338
G1 X167.32 Y115.729 E.01158
G1 X167.021 Y115.905 E.01158
G1 X166.92 Y115.911 E.00338
G1 X147.966 Y115.911 E.63231
G1 X147.512 Y115.518 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X147.507 Y115.974 E.01402
G1 X147.442 Y116.075 E.0037
G1 X147.309 Y116.132 E.00446
G1 X147.309 Y116.715 E.01791
G1 X168.306 Y116.715 E.64518
G1 X168.306 Y97.517 E.58987
G1 X138.109 Y97.517 E.92787
G1 X138.109 Y115.515 E.553
G1 X139.103 Y115.515 E.03055
G1 X139.104 Y115.08 E.01338
G1 X139.152 Y114.977 E.00346
G1 X139.306 Y114.9 E.00531
G1 X139.306 Y98.904 E.49153
G1 X139.362 Y98.77 E.00443
G1 X139.495 Y98.715 E.00443
G1 X166.92 Y98.715 E.84268
G1 X167.053 Y98.77 E.00443
G1 X167.109 Y98.904 E.00443
G1 X167.109 Y115.329 E.50469
G1 X167.053 Y115.462 E.00443
G1 X166.92 Y115.518 E.00443
G1 X147.572 Y115.518 E.5945
; WIPE_START
G1 X149.572 Y115.518 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.555 Y109.027 Z2.2 F30000
G1 X138.864 Y98.215 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X138.801 Y98.251 E.002
G1 X138.848 Y98.279 E.00151
; OBJECT_ID: 269
; WIPE_START
G1 X138.801 Y98.251 E-.32672
G1 X138.864 Y98.215 E-.43328
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X143.145 Y104.534 Z2.2 F30000
G1 X176.183 Y153.298 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X176.179 Y153.324 E.00089
G1 X175.265 Y156.736 E.11717
G1 X173.913 Y160 E.11717
G1 X172.147 Y163.058 E.11717
G1 X169.997 Y165.861 E.11717
G1 X167.5 Y168.358 E.11717
G1 X164.697 Y170.509 E.11717
G1 X162.121 Y171.996 E.09868
G1 X161.638 Y172.275 E.01849
G1 X158.375 Y173.627 E.11717
G1 X154.963 Y174.541 E.11717
G1 X151.461 Y175.002 E.11717
G1 X147.929 Y175.002 E.11717
G1 X144.427 Y174.541 E.11717
G1 X141.015 Y173.627 E.11717
G1 X137.752 Y172.275 E.11717
G1 X134.693 Y170.509 E.11716
G1 X131.89 Y168.359 E.11717
G1 X129.393 Y165.861 E.11717
G1 X127.242 Y163.059 E.11717
G1 X126.964 Y162.576 E.01849
G1 X125.476 Y160 E.09868
G1 X124.125 Y156.736 E.11717
G1 X123.21 Y153.325 E.11717
G1 X122.749 Y149.822 E.11717
G1 X122.749 Y146.29 E.11717
G1 X123.21 Y142.788 E.11717
G1 X123.355 Y142.25 E.01849
G1 X124.125 Y139.376 E.09868
G1 X125.476 Y136.113 E.11717
G1 X127.242 Y133.054 E.11717
G1 X129.393 Y130.252 E.11717
G1 X131.89 Y127.754 E.11717
G1 X134.693 Y125.604 E.11717
G1 X135.175 Y125.325 E.01849
G1 X137.752 Y123.838 E.09868
G1 X141.015 Y122.486 E.11717
G1 X144.427 Y121.572 E.11717
G1 X147.929 Y121.111 E.11717
G1 X150.903 Y121.111 E.09868
G1 X151.461 Y121.111 E.01849
G1 X154.963 Y121.572 E.11717
G1 X158.375 Y122.486 E.11717
G1 X161.638 Y123.838 E.11717
G1 X164.697 Y125.604 E.11717
G1 X167.499 Y127.754 E.11717
G1 X169.997 Y130.252 E.11717
G1 X172.147 Y133.054 E.11717
G1 X173.635 Y135.63 E.09868
G1 X173.913 Y136.113 E.01849
G1 X175.265 Y139.376 E.11717
G1 X176.179 Y142.788 E.11717
G1 X176.64 Y146.29 E.11717
G1 X176.64 Y149.822 E.11717
G1 X176.191 Y153.238 E.11429
M204 S250
G1 X175.794 Y153.249 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X174.893 Y156.61 E.10692
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.925 Y171.657 E.09062
G1 X161.464 Y171.922 E.01634
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10695
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X143.99 Y174.018 E.01634
G1 X141.141 Y173.255 E.09062
G1 X137.925 Y171.923 E.10696
G1 X134.911 Y170.182 E.10695
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10695
G1 X127.303 Y162.38 E.01634
G1 X125.829 Y159.826 E.09062
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10695
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X123.733 Y142.351 E.01634
G1 X124.497 Y139.503 E.09062
G1 X125.829 Y136.287 E.10696
G1 X127.569 Y133.272 E.10696
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X135.371 Y125.665 E.01634
G1 X137.925 Y124.19 E.09062
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X150.903 Y121.503 E.09062
G1 X151.435 Y121.503 E.01634
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10695
G1 X161.464 Y124.19 E.10696
G1 X164.479 Y125.931 E.10696
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
G1 X171.821 Y133.272 E.10695
G1 X173.295 Y135.826 E.09062
G1 X173.561 Y136.287 E.01634
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.189 E.10515
; WIPE_START
M204 S10000
G1 X175.288 Y155.122 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X171.377 Y148.568 Z2.2 F30000
G1 X155.04 Y121.186 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X158.501 Y122.114 E.11888
G1 X161.812 Y123.485 E.11888
G1 X164.916 Y125.277 E.11888
G1 X167.759 Y127.458 E.11888
G1 X170.293 Y129.992 E.11888
G1 X172.474 Y132.835 E.11887
G1 X172.729 Y133.277 E.01692
G1 X174.266 Y135.939 E.10196
G1 X175.638 Y139.25 E.11888
G1 X176.565 Y142.711 E.11888
G1 X177.033 Y146.264 E.11888
G1 X177.033 Y149.848 E.11887
G1 X176.565 Y153.401 E.11888
G1 X175.638 Y156.863 E.11888
G1 X174.266 Y160.173 E.11888
G1 X172.474 Y163.277 E.11887
G1 X170.293 Y166.12 E.11888
G1 X167.759 Y168.654 E.11888
; object ids of layer 9 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer9 end: 181,192,203,214,225,236,247,258,269
M625
G1 X164.916 Y170.836 E.11887
G1 X164.474 Y171.091 E.01692
G1 X161.812 Y172.628 E.10196
G1 X158.501 Y173.999 E.11888
G1 X155.04 Y174.927 E.11888
G1 X151.487 Y175.394 E.11888
G1 X147.903 Y175.394 E.11887
G1 X144.35 Y174.927 E.11888
G1 X140.889 Y173.999 E.11888
G1 X137.578 Y172.628 E.11888
G1 X134.474 Y170.836 E.11888
G1 X131.631 Y168.654 E.11887
G1 X129.097 Y166.12 E.11888
G1 X126.916 Y163.277 E.11887
G1 X126.661 Y162.836 E.01692
G1 X125.124 Y160.174 E.10196
G1 X123.752 Y156.863 E.11888
G1 X122.825 Y153.401 E.11888
G1 X122.357 Y149.848 E.11888
G1 X122.357 Y146.265 E.11887
G1 X122.825 Y142.712 E.11888
G1 X123.752 Y139.25 E.11888
G1 X125.124 Y135.939 E.11888
G1 X126.915 Y132.836 E.11888
G1 X129.097 Y129.993 E.11888
G1 X131.631 Y127.458 E.11888
G1 X134.474 Y125.277 E.11887
G1 X134.916 Y125.022 E.01692
G1 X137.578 Y123.485 E.10196
G1 X140.888 Y122.114 E.11888
G1 X144.35 Y121.186 E.11888
G1 X147.903 Y120.718 E.11888
G1 X151.487 Y120.718 E.11887
G1 X151.992 Y120.785 E.01692
G1 X154.98 Y121.178 E.09997
M204 S250
G1 X155.116 Y120.801 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.588 Y129.733 E.1117
G1 X172.801 Y132.617 E.11169
G1 X173.069 Y133.081 E.01646
G1 X174.619 Y135.765 E.09524
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.1117
G1 X172.801 Y163.495 E.11169
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
G1 X165.134 Y171.162 E.11169
G1 X164.67 Y171.43 E.01646
G1 X161.986 Y172.98 E.09524
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.11169
G1 X134.256 Y171.163 E.1117
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X126.321 Y163.032 E.01646
G1 X124.771 Y160.347 E.09524
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.771 Y135.765 E.11169
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X131.372 Y127.163 E.1117
G1 X134.256 Y124.95 E.11169
G1 X134.72 Y124.682 E.01646
G1 X137.404 Y123.133 E.09524
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X152.043 Y120.396 E.01646
G1 X155.057 Y120.793 E.09339
; OBJECT_ID: 192
; WIPE_START
M204 S10000
G1 X156.99 Y121.306 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X151.74 Y126.847 Z2.2 F30000
G1 X116.764 Y163.76 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.764 Y164.56 E.02651
G1 X101.746 Y164.56 E.49818
G1 X101.746 Y138.541 E.86307
G1 X116.764 Y138.541 E.49818
G1 X116.764 Y163.7 E.83457
G1 X116.357 Y163.76 F30000
G1 F8843.478
M73 P65 R9
G1 X116.357 Y164.153 E.01301
G1 X102.153 Y164.153 E.47118
G1 X102.153 Y138.948 E.83607
G1 X116.357 Y138.948 E.47118
G1 X116.357 Y163.7 E.82107
M204 S250
G1 X115.965 Y163.76 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.349 Y156.988 Z2.2 F30000
G1 X100.964 Y139.541 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.964 Y136.56 E.09891
G1 X118.746 Y136.56 E.58985
G1 X118.746 Y166.541 E.99455
G1 X99.764 Y166.541 E.62966
G1 X99.764 Y142.76 E.78888
G1 X100.964 Y142.76 E.03981
G1 X100.964 Y139.601 E.10477
G1 X100.557 Y139.948 F30000
G1 F8843.478
G1 X99.357 Y139.948 E.03981
G1 X99.357 Y139.353 E.01977
G1 X100.557 Y139.353 E.03981
G1 X100.557 Y136.948 E.07975
G1 X99.357 Y136.948 E.03981
G1 X99.357 Y136.153 E.0264
G1 X119.153 Y136.153 E.65667
G1 X119.153 Y166.948 E1.02156
G1 X99.357 Y166.948 E.65667
G1 X99.357 Y142.353 E.81589
G1 X100.557 Y142.353 E.03981
G1 X100.557 Y140.008 E.07776
M204 S250
G1 X100.165 Y140.34 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
M204 S10000
G1 X100.76 Y139.65 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X99.56 Y139.65 E.01846
; WIPE_START
G1 X100.76 Y139.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.355 Y138.338 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X101.355 Y142.963 E.14121
; WIPE_START
G1 X101.355 Y140.963 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.76 Y136.55 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.43172
G1 F9259.259
G1 X99.56 Y136.55 E.03802
; WIPE_START
G1 X100.76 Y136.55 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.617 Y143.137 Z2.2 F30000
G1 X117.641 Y165.379 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y165.415 E.002
G1 X117.625 Y165.443 E.00151
G1 X100.911 Y165.379 F30000
G1 F10696.458
G1 X100.848 Y165.415 E.002
G1 X100.895 Y165.443 E.00151
G1 X100.96 Y143.749 F30000
; LINE_WIDTH: 0.452293
G1 F8793.946
G1 X100.804 Y143.732 E.00524
G1 X100.55 Y143.571 E.01003
G1 X100.55 Y164.763 E.70695
G2 X100.533 Y165.772 I19.816 J.831 E.03367
G1 X101.542 Y165.756 E.03367
G1 X116.968 Y165.756 E.51457
G2 X117.977 Y165.772 I.831 J-19.816 E.03367
G3 X117.96 Y164.763 I11.402 J-.692 E.03368
G1 X117.96 Y138.338 E.88151
G2 X117.977 Y137.329 I-19.816 J-.831 E.03367
G1 X116.968 Y137.345 E.03367
G1 X101.75 Y137.345 E.50765
G1 X101.767 Y137.552 E.00692
G1 X102.158 Y137.703 E.01396
G1 X102.181 Y137.756 E.00193
G1 X116.968 Y137.756 E.49325
G1 X117.367 Y137.938 E.01466
G1 X117.55 Y138.338 E.01466
G1 X117.55 Y164.763 E.88151
G1 X117.544 Y164.864 E.00338
G1 X117.367 Y165.163 E.01158
G1 X117.069 Y165.34 E.01158
G1 X101.542 Y165.345 E.51794
G1 X101.142 Y165.163 E.01466
G1 X100.966 Y164.864 E.01158
G1 X100.96 Y164.763 E.00338
G1 X100.96 Y143.809 E.69901
G1 X101.354 Y143.355 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.898 Y143.35 E.01402
G1 X100.796 Y143.285 E.0037
G1 X100.739 Y143.152 E.00446
G1 X100.156 Y143.152 E.01791
G1 X100.156 Y166.149 E.70663
G1 X118.354 Y166.149 E.55915
G1 X118.354 Y136.952 E.89714
G1 X101.356 Y136.952 E.52228
G1 X101.356 Y137.946 E.03055
G1 X101.792 Y137.947 E.01338
G1 X101.894 Y137.995 E.00346
G1 X101.971 Y138.149 E.00531
G1 X116.968 Y138.149 E.4608
G1 X117.101 Y138.205 E.00443
G1 X117.156 Y138.338 E.00443
G1 X117.156 Y164.763 E.81196
G1 X117.101 Y164.896 E.00443
G1 X116.968 Y164.952 E.00443
G1 X101.542 Y164.952 E.47397
G1 X101.409 Y164.896 E.00443
G1 X101.354 Y164.763 E.00443
G1 X101.354 Y143.415 E.65595
; WIPE_START
G1 X101.354 Y145.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.243 Y142.13 Z2.2 F30000
G1 X117.641 Y137.649 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.37948
G1 F10696.458
G1 X117.578 Y137.686 E.002
G1 X117.625 Y137.713 E.00151
; OBJECT_ID: 214
; WIPE_START
G1 X117.578 Y137.686 E-.32669
G1 X117.641 Y137.649 E-.43331
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X110.253 Y139.568 Z2.2 F30000
G1 X94.964 Y143.538 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z2.2 F30000
G1 X81.345 Y142.345 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z2.2 F30000
G1 X95.153 Y143.945 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z2.2 F30000
G1 X92.366 Y109.965 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z2.2 F30000
G1 X95.613 Y133.039 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z2.2 F30000
G1 X96.888 Y114.504 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P66 R9
G1 X92.428 Y109.616 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 181
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X108.253 Y118.48 Z2.2 F30000
G1 X130.791 Y120.389 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X121.444 Y129.736 E.4385
G1 X103.753 Y112.045 E.8299
G1 X113.666 Y102.133 E.46501
G1 X131.357 Y119.823 E.8299
G1 X130.834 Y120.346 E.02452
G1 X130.504 Y120.101 F30000
G1 F8843.478
G1 X121.444 Y129.16 E.425
G1 X104.329 Y112.045 E.8029
G1 X113.666 Y102.709 E.43801
G1 X130.781 Y119.823 E.8029
G1 X130.546 Y120.058 E.01102
M204 S250
G1 X130.226 Y119.823 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X112.245 Y104.684 E.31987
G1 X113.666 Y103.263 E.06176
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.62 Y118.548 Z2.2 F30000
G1 X101.799 Y111.197 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X113.666 Y99.33 E.55668
G1 X134.159 Y119.823 E.96138
G1 X121.444 Y132.538 E.59649
G1 X103.214 Y114.308 E.85523
G1 X104.062 Y113.459 E.03981
G1 X101.842 Y111.239 E.10416
G1 X101.787 Y111.759 F30000
G1 F8843.478
G1 X100.938 Y112.608 E.03981
G1 X100.375 Y112.045 E.0264
G1 X113.666 Y98.755 E.62349
G1 X134.735 Y119.823 E.98838
G1 X121.444 Y133.114 E.62349
G1 X102.638 Y114.308 E.88223
G1 X103.486 Y113.459 E.03981
G1 X101.829 Y111.802 E.07776
M204 S250
G1 X101.787 Y112.314 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X101.649 Y111.334 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.431717
G1 F9259.337
G1 X100.801 Y112.183 E.03802
; WIPE_START
G1 X101.649 Y111.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.333 Y112.178 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.417579
G1 F9608.741
G1 X104.482 Y113.327 E.04962
; WIPE_START
G1 X103.333 Y112.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.72 Y114.099 Z2.2 F30000
G1 X132.588 Y119.787 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.37946
G1 F10697.095
G1 X132.525 Y119.823 E.002
G1 X132.572 Y119.851 E.00151
G1 X121.465 Y130.91 F30000
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X121.402 Y130.946 E.002
G1 X121.45 Y130.974 E.00151
G1 X104.759 Y114.162 F30000
; LINE_WIDTH: 0.452269
G1 F8794.456
G1 X104.636 Y114.26 E.00524
G1 X104.343 Y114.326 E.01003
G1 X120.742 Y130.725 E.77362
G2 X121.444 Y131.451 I14.602 J-13.428 E.03367
G3 X122.146 Y130.725 I8.557 J7.578 E.03367
G1 X132.346 Y120.525 E.48118
G2 X133.071 Y119.823 I-13.416 J-14.591 E.03367
G1 X132.346 Y119.122 E.03366
G1 X114.368 Y101.143 E.84811
G2 X113.666 Y100.418 I-14.62 J13.445 E.03367
G1 X112.964 Y101.143 E.03366
G1 X102.911 Y111.197 E.47426
G1 X103.069 Y111.331 E.00692
G1 X103.452 Y111.161 E.01396
G1 X103.506 Y111.182 E.00193
G1 X113.254 Y101.433 E.45986
G1 X113.666 Y101.279 E.01466
G1 X114.078 Y101.433 E.01466
G1 X132.056 Y119.412 E.84811
G1 X132.21 Y119.823 E.01466
G1 X132.123 Y120.16 E.01158
G1 X121.856 Y130.435 E.48456
G1 X121.78 Y130.503 E.00338
G1 X121.444 Y130.589 E.01158
G1 X121.108 Y130.503 E.01158
G1 X121.032 Y130.435 E.00338
G1 X104.801 Y114.204 E.76568
G1 X104.759 Y113.605 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.432 Y113.924 E.01402
G1 X104.315 Y113.95 E.0037
G1 X104.18 Y113.896 E.00446
G1 X103.768 Y114.308 E.01791
G1 X121.444 Y131.984 E.76809
G1 X133.605 Y119.823 E.52842
G1 X113.666 Y99.885 E.86641
G1 X102.354 Y111.197 E.49155
G1 X103.057 Y111.9 E.03055
G1 X103.366 Y111.593 E.01338
G1 X103.472 Y111.554 E.00346
G1 X103.635 Y111.609 E.00531
G1 X113.533 Y101.712 E.43007
G1 X113.666 Y101.656 E.00443
G1 X113.799 Y101.712 E.00443
G1 X131.778 Y119.69 E.78123
G1 X131.833 Y119.823 E.00443
G3 X131.778 Y119.957 I-.188 J0 E.00455
G1 X121.577 Y130.157 E.44324
G1 X121.444 Y130.212 E.00443
G1 X121.311 Y130.157 E.00443
G1 X104.801 Y113.647 E.7174
; WIPE_START
G1 X106.215 Y115.062 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.774 Y108.31 Z2.2 F30000
G1 X113.687 Y100.886 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.37944
G1 F10697.73
G1 X113.624 Y100.923 E.002
G1 X113.671 Y100.95 E.00151
; OBJECT_ID: 247
; WIPE_START
G1 X113.624 Y100.923 E-.32668
G1 X113.687 Y100.886 E-.43332
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X120.866 Y98.294 Z2.2 F30000
G1 X135.594 Y92.974 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y104.275 E.53014
G1 X108.75 Y88.732 E.72917
G1 X120.051 Y77.431 E.53014
G1 X135.552 Y92.932 E.72718
G1 X136.17 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y104.851 E.55715
G1 X108.174 Y88.732 E.75618
G1 X120.051 Y76.855 E.55715
G1 X136.127 Y92.932 E.75419
M204 S250
G1 X136.724 Y92.974 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
; WIPE_START
M204 S10000
G1 X135.272 Y94.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.105 Y93.148 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.492 Y98.765 E.244
G1 X124.359 Y98.82 E.00443
G1 X124.119 Y98.786 E.00743
G1 X114.26 Y88.93 E.42836
G1 X114.204 Y88.797 E.00443
G1 X114.239 Y88.558 E.00743
G1 X119.852 Y82.941 E.244
G1 X119.985 Y82.885 E.00443
G1 X120.224 Y82.92 E.00743
G1 X130.084 Y92.775 E.42836
G1 X130.139 Y92.909 E.00443
G1 X130.114 Y93.089 E.00559
G1 X130.414 Y93.365 F30000
G1 F9547.299
G1 X124.759 Y99.032 E.246
G1 X124.567 Y99.158 E.00705
G1 X124.228 Y99.197 E.0105
G1 X123.903 Y99.095 E.01047
G1 X123.828 Y99.032 E.00301
G1 X113.993 Y89.197 E.42735
G1 X113.867 Y89.005 E.00705
G1 X113.827 Y88.666 E.0105
G1 X113.93 Y88.341 E.01047
G1 X113.993 Y88.266 E.00301
G1 X119.585 Y82.674 E.243
G1 X119.777 Y82.548 E.00705
G1 X120.116 Y82.508 E.0105
G1 X120.441 Y82.611 E.01047
G1 X120.516 Y82.674 E.00301
G1 X130.351 Y92.509 E.42735
G1 X130.477 Y92.7 E.00705
G1 X130.517 Y93.04 E.0105
G1 X130.432 Y93.307 E.00862
G1 X130.723 Y93.581 F30000
G1 F9547.299
G1 X130.617 Y93.706 E.00502
G1 X125.025 Y99.298 E.243
G1 X124.706 Y99.508 E.01175
G1 X124.228 Y99.574 E.01483
G1 X123.881 Y99.508 E.01085
G1 X123.561 Y99.298 E.01175
G1 X113.726 Y89.464 E.42735
G1 X113.517 Y89.144 E.01175
G1 X113.45 Y88.666 E.01483
G1 X113.517 Y88.319 E.01085
G1 X113.726 Y87.999 E.01175
G1 X119.319 Y82.407 E.243
G1 X119.638 Y82.197 E.01175
G1 X120.116 Y82.131 E.01483
G1 X120.463 Y82.197 E.01085
G1 X120.783 Y82.407 E.01175
G1 X130.617 Y92.242 E.42735
G1 X130.827 Y92.562 E.01175
G1 X130.894 Y93.04 E.01483
G1 X130.827 Y93.387 E.01085
G1 X130.751 Y93.528 E.00494
G1 X131.031 Y93.798 F30000
G1 F9547.299
G1 X130.884 Y93.973 E.00703
G1 X125.292 Y99.565 E.243
G1 X124.845 Y99.859 E.01645
G1 X124.293 Y99.952 E.01718
G1 X123.742 Y99.859 E.01718
G3 X123.295 Y99.565 I.486 J-1.227 E.01656
G1 X113.46 Y89.73 E.42735
G1 X113.166 Y89.283 E.01645
G1 X113.073 Y88.732 E.01718
G1 X113.166 Y88.18 E.01718
G3 X113.46 Y87.733 I1.227 J.486 E.01656
G1 X119.052 Y82.141 E.243
G1 X119.499 Y81.847 E.01645
G1 X120.051 Y81.754 E.01718
G1 X120.602 Y81.847 E.01718
G3 X121.049 Y82.141 I-.486 J1.227 E.01656
G1 X130.884 Y91.975 E.42735
G1 X131.178 Y92.423 E.01645
G1 X131.271 Y92.974 E.01718
G1 X131.178 Y93.526 E.01718
G1 X131.06 Y93.745 E.00766
G1 X131.34 Y94.014 F30000
; LINE_WIDTH: 0.407344
G1 F9878.607
G1 X131.145 Y94.234 E.00872
G1 X125.553 Y99.826 E.23485
G1 X124.983 Y100.21 E.02039
G1 X124.359 Y100.329 E.01888
G1 X123.603 Y100.21 E.02272
G1 X123.254 Y100.021 E.0118
G1 X123.033 Y99.826 E.00872
G1 X113.199 Y89.992 E.41302
G1 X112.815 Y89.422 E.02039
G1 X112.696 Y88.797 E.01888
G1 X112.815 Y88.041 E.02272
G1 X113.004 Y87.692 E.0118
G1 X113.199 Y87.472 E.00872
G1 X118.791 Y81.879 E.23485
G1 X119.36 Y81.496 E.02039
G1 X119.985 Y81.377 E.01888
G1 X120.741 Y81.496 E.02272
G1 X121.09 Y81.685 E.0118
G1 X121.311 Y81.879 E.00872
G1 X131.145 Y91.714 E.41302
G1 X131.529 Y92.284 E.02039
G1 X131.648 Y92.909 E.01888
G1 X131.529 Y93.664 E.02272
G1 X131.368 Y93.961 E.01002
G1 X109.304 Y88.732 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.293 Y103.721 E.65133
G1 X135.04 Y92.974 E.46697
G1 X120.051 Y77.985 E.65133
G1 X109.347 Y88.689 E.46512
G1 X109.838 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y103.187 E.62815
G1 X134.506 Y92.974 E.4438
G1 X120.051 Y78.518 E.62815
G1 X109.88 Y88.689 E.44195
G1 X110.371 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.654 E.60498
G1 X133.973 Y92.974 E.42062
G1 X120.051 Y79.052 E.60498
G1 X110.413 Y88.689 E.41878
G1 X110.904 Y88.732 F30000
G1 F9547.299
G1 X124.293 Y102.121 E.58181
G1 X133.44 Y92.974 E.39745
G1 X120.051 Y79.585 E.58181
G1 X110.947 Y88.689 E.39561
G1 X111.437 Y88.732 F30000
; LINE_WIDTH: 0.408327
G1 F9852.027
G3 X112.943 Y90.248 I-76.701 J77.665 E.06361
G1 X122.777 Y100.082 E.41414
G3 X124.293 Y101.587 I-76.23 J78.288 E.06361
G3 X125.809 Y100.082 I77.746 J76.783 E.06361
G1 X131.401 Y94.49 E.23548
G3 X132.907 Y92.974 I78.206 J76.149 E.06361
G3 X131.401 Y91.458 I76.701 J-77.665 E.06361
G1 X121.567 Y81.624 E.41414
G3 X120.051 Y80.118 I76.189 J-78.247 E.06361
G3 X118.535 Y81.624 I-77.705 J-76.742 E.06361
G1 X112.943 Y87.216 E.23548
G3 X111.48 Y88.689 I-76.055 J-74.04 E.06183
G1 X111.939 Y88.732 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X112.42 Y89.213 E.01846
G1 X112.341 Y88.666 E.01498
G1 X112.42 Y88.25 E.01148
G1 X111.982 Y88.689 E.01683
G1 X119.57 Y81.101 F30000
; LINE_WIDTH: 0.37581
G1 F10814.383
G1 X120.116 Y81.022 E.01498
G1 X120.532 Y81.101 E.01148
G1 X120.051 Y80.62 E.01846
G1 X119.612 Y81.059 E.01683
G1 X131.923 Y92.493 F30000
; LINE_WIDTH: 0.37582
G1 F10814.059
G1 X132.003 Y93.04 E.01498
G1 X131.923 Y93.455 E.01148
G1 X132.405 Y92.974 E.01846
G1 X131.966 Y92.535 E.01683
G1 X124.774 Y100.604 F30000
; LINE_WIDTH: 0.3758
G1 F10814.707
G1 X124.228 Y100.684 E.01498
G1 X123.812 Y100.604 E.01148
G1 X124.293 Y101.085 E.01846
G1 X124.732 Y100.647 E.01683
G1 X115.424 Y89.541 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.576 Y90.692 E.05401
G1 X122.011 Y85.257 E.25498
G1 X124.89 Y88.135 E.13504
M73 P67 R9
G1 X119.454 Y93.571 E.25498
G1 X122.333 Y96.449 E.13504
G1 X127.768 Y91.014 E.25498
G1 X129.729 Y92.974 E.09197
G1 X127.011 Y95.692 E.12749
G1 X117.333 Y86.014 E.45401
G1 X118.484 Y84.862 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X117.333 Y86.014 E-.61876
G1 X117.596 Y86.277 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X112.017 Y91.486 Z2.2 F30000
G1 X100.345 Y102.386 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.301 Y102.359 E.00171
G3 X101.481 Y97.315 I1.361 J-2.341 E.22888
G3 X103.305 Y97.864 I.189 J2.677 E.0646
G3 X100.619 Y102.516 I-1.642 J2.153 E.25923
G1 X100.399 Y102.412 E.00806
G1 X100.525 Y102.021 F30000
G1 F8843.478
G1 X100.504 Y102.008 E.00083
G3 X99.401 Y99.564 I1.153 J-1.991 E.09498
G3 X101.507 Y97.722 I2.254 J.452 E.0998
G3 X100.774 Y102.142 I.149 J2.296 E.27474
G1 X100.579 Y102.047 E.00718
M204 S250
G1 X100.703 Y101.664 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.533 Y98.113 I.961 J-1.648 E.14919
G3 X102.385 Y98.25 I.139 J1.851 E.02677
G3 X100.755 Y101.693 I-.722 J1.766 E.19049
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11762
G1 X100.303 Y101.366 E-.09496
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09496
G1 X99.748 Y100.074 E-.07262
; WIPE_END
G1 E-.04 F1800
G1 X97.21 Y93.608 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.207 Y93.647 E.00132
G3 X94.41 Y90.244 I-2.616 J-.701 E.39379
G3 X96.234 Y90.793 I.189 J2.676 E.0646
G3 X97.276 Y93.299 I-1.643 J2.153 E.09429
G1 X97.222 Y93.549 E.0085
G1 X96.811 Y93.528 F30000
G1 F8843.478
G1 X96.803 Y93.539 E.00043
G3 X94.132 Y95.198 I-2.22 J-.595 E.11488
G3 X94.436 Y90.65 I.452 J-2.254 E.21956
G3 X96.838 Y93.389 I.147 J2.294 E.1395
G1 X96.822 Y93.469 E.00271
M204 S250
G1 X96.435 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.462 Y91.042 I-1.843 J-.495 E.25692
G3 X95.314 Y91.179 I.139 J1.852 E.02678
G3 X96.45 Y93.382 I-.722 J1.766 E.08289
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.1178
G1 X96.238 Y93.899 E-.09498
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.134 Y94.77 E-.07241
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z2.2 F30000
G1 X108.713 Y98.601 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X105.419 Y95.308 E.44199
G1 X108.67 Y98.559 E.15251
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X105.707 Y95.02 E.45549
G1 X109.246 Y98.559 E.16601
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X105.984 Y94.743 E.43397
G1 X109.8 Y98.559 E.16582
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.818 Y102.179 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.23 Y102.591 E.01932
G1 X101.352 Y105.469 E.13504
G1 X89.129 Y93.247 E.57338
G1 X88.018 Y94.358 E.05214
G1 X88.372 Y94.713 E.01662
G1 X96.352 Y86.733 E.37435
G1 X95.998 Y86.379 E.01662
G1 X94.886 Y87.49 E.05214
G1 X107.109 Y99.712 E.57338
G1 X108.22 Y98.601 E.05214
G1 X107.866 Y98.247 E.01662
G1 X99.886 Y106.227 E.37435
G1 X98.734 Y105.075 E.05401
G1 X92.402 Y98.742 F30000
G1 F8843.478
G1 X91.25 Y97.591 E.05401
G1 X93.183 Y95.658 E.09066
G2 X96.747 Y95.108 I1.403 J-2.731 E.12787
G1 X99.49 Y97.851 E.12869
G2 X98.94 Y101.415 I2.175 J2.16 E.1279
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X104.987 Y95.368 E.13504
G1 X103.055 Y97.301 E.09066
G3 X104.239 Y98.387 I-1.414 J2.731 E.05394
G1 X96.211 Y90.359 F30000
G1 F8843.478
G3 X97.298 Y91.544 I-1.645 J2.599 E.05394
G1 X99.23 Y89.611 E.09066
G1 X100.382 Y90.763 E.05401
; WIPE_START
G1 X99.23 Y89.611 E-.61876
G1 X98.967 Y89.874 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X92.419 Y90.78 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.01931
G1 X90.856 Y91.52 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X92.008 Y90.368 E-.61876
G1 X92.27 Y90.631 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 10/30
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S181.05
; OBJECT_ID: 225
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G17
G3 Z2.2 I.287 J1.183 P1  F30000
G1 X145.197 Y77.807 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
M73 P67 R8
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 203
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 203
M624 BAAAAAAAAAA=
G1 X147.183 Y84.155 Z2.4 F30000
G1 X165.917 Y114.326 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X140.497 Y114.326 E.78109
G1 X140.497 Y99.906 E.44309
G1 X165.917 Y99.906 E.78109
G1 X165.917 Y114.266 E.44124
; WIPE_START
M204 S10000
G1 X163.917 Y114.271 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X156.33 Y115.095 Z2.4 F30000
G1 X141.497 Y116.706 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X141.497 Y117.906 E.03687
G1 X140.117 Y117.906 E.0424
G1 X140.117 Y116.706 E.03687
G1 X138.497 Y116.706 E.04978
G1 X138.497 Y117.906 E.03687
G1 X136.917 Y117.906 E.04855
G1 X136.917 Y96.326 E.66309
G1 X169.498 Y96.326 E1.00109
G1 X169.498 Y117.906 E.66309
G1 X146.117 Y117.906 E.7184
G1 X146.117 Y116.706 E.03687
G1 X144.497 Y116.706 E.04978
G1 X144.497 Y117.906 E.03687
G1 X143.117 Y117.906 E.0424
G1 X143.117 Y116.706 E.03687
G1 X141.557 Y116.706 E.04793
; WIPE_START
M204 S10000
G1 X141.497 Y117.906 E-.45657
G1 X140.699 Y117.906 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X148.331 Y117.849 Z2.4 F30000
G1 X168.488 Y117.699 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X169.29 Y116.897 E.03487
G1 X169.29 Y116.363
G1 X167.955 Y117.699 E.05804
G1 X167.421 Y117.699
G1 X169.29 Y115.83 E.08121
G1 X169.29 Y115.297
G1 X166.888 Y117.699 E.10438
G1 X166.355 Y117.699
G1 X169.29 Y114.764 E.12756
G1 X169.29 Y114.23
G1 X165.821 Y117.699 E.15073
G1 X165.288 Y117.699
G1 X169.29 Y113.697 E.1739
G1 X169.29 Y113.164
G1 X164.755 Y117.699 E.19707
G1 X164.222 Y117.699
G1 X169.29 Y112.631 E.22025
G1 X169.29 Y112.097
G1 X163.688 Y117.699 E.24342
G1 X163.155 Y117.699
G1 X169.29 Y111.564 E.26659
G1 X169.29 Y111.031
G1 X166.125 Y114.196 E.13755
G1 X166.125 Y113.663
G1 X169.29 Y110.498 E.13754
G1 X169.29 Y109.964
G1 X166.125 Y113.129 E.13754
G1 X166.125 Y112.596
G1 X169.29 Y109.431 E.13754
G1 X169.29 Y108.898
G1 X166.125 Y112.063 E.13755
G1 X166.125 Y111.53
G1 X169.29 Y108.364 E.13754
G1 X169.29 Y107.831
G1 X166.125 Y110.996 E.13754
G1 X166.125 Y110.463
G1 X169.29 Y107.298 E.13754
G1 X169.29 Y106.765
G1 X166.125 Y109.93 E.13754
G1 X166.125 Y109.397
G1 X169.29 Y106.231 E.13754
G1 X169.29 Y105.698
G1 X166.125 Y108.863 E.13754
G1 X166.125 Y108.33
G1 X169.29 Y105.165 E.13754
G1 X169.29 Y104.632
G1 X166.125 Y107.797 E.13754
G1 X166.125 Y107.264
G1 X169.29 Y104.098 E.13754
G1 X169.29 Y103.565
G1 X166.125 Y106.73 E.13755
G1 X166.125 Y106.197
G1 X169.29 Y103.032 E.13755
G1 X169.29 Y102.499
G1 X166.125 Y105.664 E.13755
G1 X166.125 Y105.131
G1 X169.29 Y101.965 E.13755
G1 X169.29 Y101.432
G1 X166.125 Y104.597 E.13755
G1 X166.125 Y104.064
G1 X169.29 Y100.899 E.13755
G1 X169.29 Y100.366
G1 X166.125 Y103.531 E.13755
G1 X166.125 Y102.998
G1 X169.29 Y99.832 E.13755
G1 X169.29 Y99.299
G1 X166.125 Y102.464 E.13755
G1 X166.125 Y101.931
G1 X169.29 Y98.766 E.13755
G1 X169.29 Y98.233
G1 X166.125 Y101.398 E.13755
G1 X166.125 Y100.865
G1 X169.29 Y97.699 E.13755
G1 X169.29 Y97.166
G1 X166.125 Y100.331 E.13755
G1 X166.125 Y99.798
G1 X169.29 Y96.633 E.13755
G1 X168.856 Y96.534
G1 X165.691 Y99.699 E.13755
G1 X165.157 Y99.699
G1 X168.323 Y96.534 E.13755
G1 X167.789 Y96.534
G1 X164.624 Y99.699 E.13754
G1 X164.091 Y99.699
G1 X167.256 Y96.534 E.13754
G1 X166.723 Y96.534
G1 X163.558 Y99.699 E.13755
G1 X163.024 Y99.699
G1 X166.19 Y96.534 E.13755
G1 X165.656 Y96.534
G1 X162.491 Y99.699 E.13754
G1 X161.958 Y99.699
G1 X165.123 Y96.534 E.13754
G1 X164.59 Y96.534
G1 X161.425 Y99.699 E.13755
G1 X160.891 Y99.699
G1 X164.057 Y96.534 E.13755
G1 X163.523 Y96.534
G1 X160.358 Y99.699 E.13754
G1 X159.825 Y99.699
G1 X162.99 Y96.534 E.13754
G1 X162.457 Y96.534
G1 X159.292 Y99.699 E.13755
M73 P68 R8
G1 X158.758 Y99.699
G1 X161.924 Y96.534 E.13755
G1 X161.39 Y96.534
G1 X158.225 Y99.699 E.13754
G1 X157.692 Y99.699
G1 X160.857 Y96.534 E.13754
G1 X160.324 Y96.534
G1 X157.159 Y99.699 E.13755
G1 X156.625 Y99.699
G1 X159.791 Y96.534 E.13755
G1 X159.257 Y96.534
G1 X156.092 Y99.699 E.13754
G1 X155.559 Y99.699
G1 X158.724 Y96.534 E.13754
G1 X158.191 Y96.534
G1 X155.026 Y99.699 E.13755
G1 X154.492 Y99.699
G1 X157.658 Y96.534 E.13755
G1 X157.124 Y96.534
G1 X153.959 Y99.699 E.13754
G1 X153.426 Y99.699
G1 X156.591 Y96.534 E.13754
G1 X156.058 Y96.534
G1 X152.893 Y99.699 E.13755
G1 X152.359 Y99.699
G1 X155.525 Y96.534 E.13755
G1 X154.991 Y96.534
G1 X151.826 Y99.699 E.13755
G1 X151.293 Y99.699
G1 X154.458 Y96.534 E.13755
G1 X153.925 Y96.534
G1 X150.76 Y99.699 E.13755
G1 X150.226 Y99.699
G1 X153.392 Y96.534 E.13755
G1 X152.858 Y96.534
G1 X149.693 Y99.699 E.13755
G1 X149.16 Y99.699
G1 X152.325 Y96.534 E.13755
G1 X151.792 Y96.534
G1 X148.627 Y99.699 E.13755
G1 X148.093 Y99.699
G1 X151.259 Y96.534 E.13755
G1 X150.725 Y96.534
G1 X147.56 Y99.699 E.13755
G1 X147.027 Y99.699
G1 X150.192 Y96.534 E.13755
G1 X149.659 Y96.534
G1 X146.493 Y99.699 E.13755
G1 X145.96 Y99.699
G1 X149.125 Y96.534 E.13755
G1 X148.592 Y96.534
G1 X145.427 Y99.699 E.13755
G1 X144.894 Y99.699
G1 X148.059 Y96.534 E.13755
G1 X147.526 Y96.534
G1 X144.36 Y99.699 E.13755
G1 X143.827 Y99.699
G1 X146.992 Y96.534 E.13755
G1 X146.459 Y96.534
G1 X143.294 Y99.699 E.13755
G1 X142.761 Y99.699
G1 X145.926 Y96.534 E.13755
G1 X145.393 Y96.534
G1 X142.227 Y99.699 E.13755
G1 X141.694 Y99.699
G1 X144.859 Y96.534 E.13755
G1 X144.326 Y96.534
G1 X141.161 Y99.699 E.13755
G1 X140.628 Y99.699
G1 X143.793 Y96.534 E.13755
; WIPE_START
M204 S10000
G1 X142.379 Y97.948 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.842 Y103.278 Z2.4 F30000
G1 X162.622 Y117.699 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X165.787 Y114.534 E.13755
G1 X165.254 Y114.534
G1 X162.089 Y117.699 E.13755
G1 X161.555 Y117.699
G1 X164.721 Y114.534 E.13755
G1 X164.187 Y114.534
G1 X161.022 Y117.699 E.13755
G1 X160.489 Y117.699
G1 X163.654 Y114.534 E.13754
G1 X163.121 Y114.534
G1 X159.956 Y117.699 E.13754
G1 X159.422 Y117.699
G1 X162.588 Y114.534 E.13755
G1 X162.054 Y114.534
G1 X158.889 Y117.699 E.13755
G1 X158.356 Y117.699
G1 X161.521 Y114.534 E.13754
G1 X160.988 Y114.534
G1 X157.823 Y117.699 E.13754
G1 X157.289 Y117.699
G1 X160.455 Y114.534 E.13755
G1 X159.921 Y114.534
G1 X156.756 Y117.699 E.13755
G1 X156.223 Y117.699
G1 X159.388 Y114.534 E.13754
G1 X158.855 Y114.534
G1 X155.69 Y117.699 E.13754
G1 X155.156 Y117.699
G1 X158.322 Y114.534 E.13755
G1 X157.788 Y114.534
G1 X154.623 Y117.699 E.13755
G1 X154.09 Y117.699
G1 X157.255 Y114.534 E.13754
G1 X156.722 Y114.534
G1 X153.557 Y117.699 E.13754
G1 X153.023 Y117.699
G1 X156.189 Y114.534 E.13755
G1 X155.655 Y114.534
G1 X152.49 Y117.699 E.13755
G1 X151.957 Y117.699
G1 X155.122 Y114.534 E.13754
G1 X154.589 Y114.534
G1 X151.424 Y117.699 E.13754
G1 X150.89 Y117.699
G1 X154.056 Y114.534 E.13755
G1 X153.522 Y114.534
G1 X150.357 Y117.699 E.13755
G1 X149.824 Y117.699
G1 X152.989 Y114.534 E.13754
G1 X152.456 Y114.534
G1 X149.291 Y117.699 E.13754
G1 X148.757 Y117.699
G1 X151.923 Y114.534 E.13755
G1 X151.389 Y114.534
G1 X148.224 Y117.699 E.13755
G1 X147.691 Y117.699
G1 X150.856 Y114.534 E.13754
G1 X150.323 Y114.534
G1 X147.157 Y117.699 E.13754
G1 X146.624 Y117.699
G1 X149.789 Y114.534 E.13755
G1 X149.256 Y114.534
G1 X146.325 Y117.465 E.12738
G1 X146.325 Y116.932
G1 X148.723 Y114.534 E.10421
G1 X148.19 Y114.534
G1 X146.224 Y116.499 E.0854
G1 X145.691 Y116.499
G1 X147.656 Y114.534 E.0854
G1 X147.123 Y114.534
G1 X145.158 Y116.499 E.0854
G1 X144.625 Y116.499
G1 X146.59 Y114.534 E.0854
; WIPE_START
M204 S10000
G1 X145.176 Y115.948 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X144.29 Y116.833 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X143.425 Y117.699 E.03761
G1 X143.325 Y117.265
G1 X146.057 Y114.534 E.11871
G1 X145.523 Y114.534
G1 X143.325 Y116.732 E.09554
G1 X143.025 Y116.499
G1 X144.99 Y114.534 E.0854
G1 X144.457 Y114.534
G1 X142.492 Y116.499 E.0854
G1 X141.958 Y116.499
G1 X143.924 Y114.534 E.0854
G1 X143.39 Y114.534
G1 X141.425 Y116.499 E.0854
G1 X141.29 Y117.167
G1 X140.758 Y117.699 E.02311
G1 X140.325 Y117.599
G1 X141.29 Y116.634 E.04195
G1 X140.325 Y117.066
G1 X142.857 Y114.534 E.11004
G1 X142.324 Y114.534
G1 X140.325 Y116.533 E.08687
G1 X139.825 Y116.499
G1 X141.791 Y114.534 E.0854
G1 X141.257 Y114.534
G1 X139.292 Y116.499 E.0854
G1 X138.759 Y116.499
G1 X140.724 Y114.534 E.0854
; WIPE_START
M204 S10000
G1 X139.31 Y115.948 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X138.29 Y116.968 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X137.559 Y117.699 E.03178
G1 X137.125 Y117.6
G1 X140.29 Y114.434 E.13755
G1 X140.29 Y113.901
G1 X137.125 Y117.066 E.13755
G1 X137.125 Y116.533
G1 X140.29 Y113.368 E.13755
G1 X140.29 Y112.835
G1 X137.125 Y116 E.13755
G1 X137.125 Y115.467
G1 X140.29 Y112.301 E.13755
G1 X140.29 Y111.768
G1 X137.125 Y114.933 E.13755
G1 X137.125 Y114.4
G1 X140.29 Y111.235 E.13755
G1 X140.29 Y110.702
G1 X137.125 Y113.867 E.13755
G1 X137.125 Y113.334
G1 X140.29 Y110.168 E.13755
G1 X140.29 Y109.635
G1 X137.125 Y112.8 E.13755
G1 X137.125 Y112.267
G1 X140.29 Y109.102 E.13755
G1 X140.29 Y108.569
G1 X137.125 Y111.734 E.13755
G1 X137.125 Y111.201
G1 X140.29 Y108.035 E.13755
G1 X140.29 Y107.502
G1 X137.125 Y110.667 E.13755
G1 X137.125 Y110.134
G1 X140.29 Y106.969 E.13755
G1 X140.29 Y106.436
G1 X137.125 Y109.601 E.13755
G1 X137.125 Y109.068
G1 X140.29 Y105.902 E.13755
G1 X140.29 Y105.369
G1 X137.125 Y108.534 E.13755
G1 X137.125 Y108.001
G1 X140.29 Y104.836 E.13755
G1 X140.29 Y104.303
G1 X137.125 Y107.468 E.13755
G1 X137.125 Y106.935
G1 X140.29 Y103.769 E.13755
G1 X140.29 Y103.236
G1 X137.125 Y106.401 E.13755
G1 X137.125 Y105.868
G1 X140.29 Y102.703 E.13755
G1 X140.29 Y102.169
G1 X137.125 Y105.335 E.13755
G1 X137.125 Y104.801
G1 X140.29 Y101.636 E.13755
G1 X140.29 Y101.103
G1 X137.125 Y104.268 E.13755
G1 X137.125 Y103.735
G1 X140.29 Y100.57 E.13755
G1 X140.29 Y100.036
G1 X137.125 Y103.202 E.13755
G1 X137.125 Y102.668
G1 X143.26 Y96.534 E.26659
G1 X142.726 Y96.534
G1 X137.125 Y102.135 E.24341
G1 X137.125 Y101.602
G1 X142.193 Y96.534 E.22024
G1 X141.66 Y96.534
G1 X137.125 Y101.069 E.19707
G1 X137.125 Y100.535
G1 X141.127 Y96.534 E.17389
G1 X140.593 Y96.534
G1 X137.125 Y100.002 E.15072
G1 X137.125 Y99.469
G1 X140.06 Y96.534 E.12755
G1 X139.527 Y96.534
G1 X137.125 Y98.936 E.10438
G1 X137.125 Y98.402
G1 X138.994 Y96.534 E.0812
G1 X138.46 Y96.534
G1 X137.125 Y97.869 E.05803
G1 X137.125 Y97.336
G1 X137.927 Y96.534 E.03486
; WIPE_START
M204 S10000
G1 X137.125 Y97.336 E-.4311
G1 X137.125 Y97.869 E-.20264
G1 X137.36 Y97.634 E-.12626
; WIPE_END
G1 E-.04 F1800
G1 X138.572 Y105.17 Z2.4 F30000
G1 X140.413 Y116.621 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112015
G1 F15000
G1 X140.338 Y116.74 E.00079
; LINE_WIDTH: 0.094357
G1 X140.322 Y116.732 E.00008
; LINE_WIDTH: 0.0677103
G1 X140.306 Y116.724 E.00004
; OBJECT_ID: 269
; WIPE_START
G1 X140.322 Y116.732 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 203
M625
; start printing object, unique label id: 269
M624 AAEAAAAAAAA=
G1 X145.64 Y122.206 Z2.4 F30000
G1 X175.794 Y153.246 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X175.794 Y153.248 E.00005
G1 X174.941 Y156.43 E.10123
G1 X174.893 Y156.61 E.00573
G1 X173.561 Y159.826 E.10696
G1 X171.821 Y162.84 E.10696
G1 X169.702 Y165.602 E.10695
G1 X167.24 Y168.063 E.10696
G1 X164.479 Y170.182 E.10695
G1 X161.464 Y171.922 E.10696
G1 X158.249 Y173.255 E.10695
G1 X154.886 Y174.155 E.10696
G1 X151.435 Y174.61 E.10696
G1 X147.955 Y174.61 E.10696
G1 X144.504 Y174.155 E.10696
G1 X141.141 Y173.255 E.10695
G1 X137.925 Y171.923 E.10696
G1 X134.911 Y170.182 E.10695
G1 X132.15 Y168.063 E.10695
G1 X129.688 Y165.602 E.10696
G1 X127.569 Y162.84 E.10696
G1 X127.476 Y162.679 E.00573
G1 X125.829 Y159.826 E.10123
G1 X124.497 Y156.61 E.10695
G1 X123.596 Y153.248 E.10696
G1 X123.141 Y149.797 E.10696
G1 X123.141 Y146.316 E.10696
G1 X123.596 Y142.865 E.10696
G1 X124.497 Y139.503 E.10695
G1 X125.829 Y136.287 E.10696
G1 X127.569 Y133.272 E.10696
G1 X129.688 Y130.511 E.10695
G1 X132.149 Y128.05 E.10696
G1 X134.911 Y125.931 E.10695
G1 X135.072 Y125.837 E.00573
G1 X137.925 Y124.19 E.10123
G1 X141.141 Y122.858 E.10695
G1 X144.503 Y121.957 E.10696
G1 X147.954 Y121.503 E.10696
G1 X151.249 Y121.503 E.10123
G1 X151.435 Y121.503 E.00573
G1 X154.886 Y121.957 E.10696
G1 X158.248 Y122.858 E.10696
G1 X161.464 Y124.19 E.10696
G1 X164.479 Y125.931 E.10696
G1 X167.24 Y128.049 E.10695
G1 X169.702 Y130.511 E.10696
M73 P69 R8
G1 X171.821 Y133.272 E.10695
G1 X173.561 Y136.287 E.10696
G1 X174.893 Y139.503 E.10695
G1 X175.794 Y142.865 E.10696
G1 X176.248 Y146.316 E.10696
G1 X176.248 Y149.797 E.10696
G1 X175.802 Y153.187 E.10506
; WIPE_START
M204 S10000
G1 X175.794 Y153.248 E-.02341
G1 X175.292 Y155.12 E-.73659
; WIPE_END
G1 E-.04 F1800
G1 X171.424 Y148.54 Z2.4 F30000
G1 X155.116 Y120.801 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X158.627 Y121.742 E.11169
G1 X161.986 Y123.133 E.11169
G1 X165.134 Y124.95 E.1117
G1 X168.018 Y127.163 E.11169
G1 X170.588 Y129.733 E.1117
G1 X172.801 Y132.617 E.11169
G1 X174.619 Y135.765 E.1117
G1 X176.01 Y139.124 E.11169
G1 X176.95 Y142.635 E.11169
G1 X177.425 Y146.239 E.1117
G1 X177.425 Y149.874 E.11169
G1 X176.95 Y153.478 E.1117
G1 X176.01 Y156.989 E.11169
G1 X174.619 Y160.347 E.1117
G1 X172.801 Y163.495 E.11169
G1 X170.588 Y166.379 E.11169
G1 X168.018 Y168.95 E.1117
; object ids of layer 10 start: 181,192,203,214,225,236,247,258,269
M624 /wEAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer10 end: 181,192,203,214,225,236,247,258,269
M625
G1 X165.134 Y171.162 E.11169
G1 X161.986 Y172.98 E.1117
G1 X158.628 Y174.371 E.11169
G1 X155.116 Y175.312 E.11169
G1 X151.512 Y175.786 E.1117
G1 X147.878 Y175.786 E.11169
G1 X144.274 Y175.312 E.1117
G1 X140.762 Y174.371 E.11169
G1 X137.404 Y172.98 E.1117
G1 X134.256 Y171.163 E.11169
G1 X131.372 Y168.95 E.11169
G1 X128.802 Y166.379 E.1117
G1 X126.589 Y163.495 E.11169
G1 X124.771 Y160.347 E.1117
G1 X123.38 Y156.989 E.11169
G1 X122.439 Y153.478 E.11169
G1 X121.965 Y149.874 E.1117
G1 X121.965 Y146.239 E.11169
G1 X122.439 Y142.635 E.1117
G1 X123.38 Y139.124 E.11169
G1 X124.771 Y135.765 E.11169
G1 X126.589 Y132.617 E.1117
G1 X128.801 Y129.734 E.11169
G1 X131.372 Y127.163 E.1117
G1 X134.256 Y124.95 E.11169
G1 X137.404 Y123.133 E.1117
G1 X140.762 Y121.742 E.11169
G1 X144.273 Y120.801 E.11169
G1 X147.877 Y120.326 E.1117
G1 X151.512 Y120.326 E.11169
G1 X151.68 Y120.348 E.00521
G1 X155.057 Y120.793 E.10465
; WIPE_START
M204 S10000
G1 X156.99 Y121.306 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X159.359 Y128.562 Z2.4 F30000
G1 X171.295 Y165.117 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X166.755 Y169.657 E.19728
; WIPE_START
M204 S10000
G1 X168.17 Y168.243 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X164.713 Y171.166 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X172.805 Y163.074 E.35162
; WIPE_START
M204 S10000
G1 X171.39 Y164.489 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X170.686 Y164.66 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X173.533 Y161.813 E.12374
; WIPE_START
M204 S10000
G1 X172.119 Y163.227 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X174.262 Y160.551 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X172.18 Y162.632 E.09044
; WIPE_START
M204 S10000
G1 X173.594 Y161.218 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X172.909 Y161.371 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X174.721 Y159.558 E.07875
G1 X175.098 Y158.648
G1 X173.637 Y160.109 E.06348
G1 X174.067 Y159.145
G1 X175.475 Y157.738 E.06117
G1 X175.833 Y156.846
G1 X174.444 Y158.235 E.06035
G1 X174.822 Y157.325
G1 X176.028 Y156.118 E.05244
G1 X176.224 Y155.389
G1 X175.146 Y156.467 E.04682
G1 X175.341 Y155.738
G1 X176.419 Y154.661 E.04682
G1 X176.614 Y153.933
G1 X175.537 Y155.01 E.04682
G1 X175.732 Y154.281
G1 X176.773 Y153.241 E.04523
G1 X176.853 Y152.627
G1 X175.927 Y153.553 E.04026
G1 X176.049 Y152.897
G1 X176.934 Y152.012 E.03845
G1 X177.015 Y151.398
G1 X176.13 Y152.283 E.03845
G1 X176.211 Y151.669
G1 X177.096 Y150.784 E.03845
G1 X177.177 Y150.17
G1 X176.292 Y151.055 E.03845
G1 X176.373 Y150.441
G1 X177.218 Y149.596 E.03671
G1 X177.218 Y149.063
G1 X176.454 Y149.827 E.0332
G1 X176.456 Y149.291
G1 X177.218 Y148.53 E.0331
G1 X177.218 Y147.996
G1 X176.456 Y148.758 E.0331
G1 X176.456 Y148.225
G1 X177.218 Y147.463 E.0331
G1 X177.218 Y146.93
G1 X176.456 Y147.692 E.03311
G1 X176.456 Y147.158
G1 X177.218 Y146.397 E.0331
G1 X177.172 Y145.909
G1 X176.456 Y146.625 E.03114
G1 X176.431 Y146.116
G1 X177.11 Y145.437 E.02951
G1 X177.048 Y144.966
G1 X176.369 Y145.645 E.02951
G1 X176.307 Y145.174
G1 X176.986 Y144.495 E.02951
G1 X176.924 Y144.024
G1 X176.245 Y144.703 E.02951
G1 X176.183 Y144.231
G1 X176.862 Y143.552 E.02951
G1 X176.8 Y143.081
G1 X176.121 Y143.76 E.02951
G1 X176.059 Y143.289
G1 X176.731 Y142.617 E.0292
G1 X176.618 Y142.196
G1 X175.996 Y142.819 E.02703
G1 X175.884 Y142.398
G1 X176.506 Y141.776 E.02703
G1 X176.393 Y141.355
G1 X175.771 Y141.977 E.02703
G1 X175.658 Y141.557
G1 X176.28 Y140.935 E.02703
G1 X176.168 Y140.514
G1 X175.546 Y141.136 E.02703
G1 X175.433 Y140.716
G1 X176.055 Y140.094 E.02703
G1 X175.942 Y139.673
G1 X175.32 Y140.295 E.02703
G1 X175.207 Y139.875
G1 X175.829 Y139.253 E.02703
G1 X175.68 Y138.869
G1 X175.095 Y139.454 E.02542
G1 X174.94 Y139.075
G1 X175.524 Y138.492 E.02534
G1 X175.367 Y138.115
G1 X174.784 Y138.698 E.02534
G1 X174.628 Y138.321
G1 X175.211 Y137.738 E.02534
G1 X175.055 Y137.361
G1 X174.472 Y137.944 E.02534
G1 X174.316 Y137.567
G1 X174.899 Y136.984 E.02534
G1 X174.743 Y136.607
G1 X174.16 Y137.19 E.02534
G1 X174.003 Y136.813
G1 X174.586 Y136.23 E.02534
G1 X174.43 Y135.853
G1 X173.847 Y136.436 E.02532
G1 X173.677 Y136.073
G1 X174.235 Y135.515 E.02423
G1 X174.039 Y135.177
G1 X173.482 Y135.735 E.02423
G1 X173.286 Y135.396
G1 X173.844 Y134.839 E.02423
G1 X173.649 Y134.501
G1 X173.091 Y135.058 E.02423
G1 X172.896 Y134.72
G1 X173.454 Y134.163 E.02423
G1 X173.259 Y133.825
G1 X172.701 Y134.382 E.02423
G1 X172.506 Y134.044
G1 X173.063 Y133.486 E.02423
G1 X172.868 Y133.148
G1 X172.311 Y133.706 E.02423
G1 X172.115 Y133.368
G1 X172.673 Y132.81 E.02423
G1 X172.45 Y132.5
G1 X171.907 Y133.044 E.02361
G1 X171.675 Y132.742
G1 X172.218 Y132.199 E.02361
G1 X171.987 Y131.897
G1 X171.443 Y132.44 E.02361
G1 X171.212 Y132.138
G1 X171.755 Y131.595 E.02361
G1 X171.524 Y131.293
G1 X170.98 Y131.837 E.02361
G1 X170.749 Y131.535
G1 X171.292 Y130.992 E.02361
G1 X171.061 Y130.69
G1 X170.517 Y131.233 E.02361
G1 X170.286 Y130.931
G1 X170.829 Y130.388 E.02361
G1 X170.598 Y130.086
G1 X170.054 Y130.63 E.02361
G1 X169.817 Y130.333
G1 X170.356 Y129.795 E.02341
G1 X170.09 Y129.528
G1 X169.551 Y130.067 E.02341
G1 X169.284 Y129.8
G1 X169.823 Y129.261 E.02341
G1 X169.556 Y128.995
G1 X169.018 Y129.533 E.02341
G1 X168.751 Y129.267
G1 X169.29 Y128.728 E.02341
G1 X169.023 Y128.462
G1 X168.484 Y129 E.02341
G1 X168.218 Y128.734
G1 X168.756 Y128.195 E.02341
G1 X168.49 Y127.928
G1 X167.951 Y128.467 E.02341
G1 X167.684 Y128.2
G1 X168.223 Y127.662 E.02341
G1 X167.956 Y127.395
G1 X167.418 Y127.934 E.02341
G1 X167.121 Y127.697
G1 X167.665 Y127.153 E.02361
G1 X167.363 Y126.922
G1 X166.82 Y127.465 E.02361
G1 X166.518 Y127.234
G1 X167.061 Y126.69 E.02361
G1 X166.76 Y126.459
G1 X166.216 Y127.002 E.02361
G1 X165.914 Y126.771
G1 X166.458 Y126.227 E.02361
G1 X166.156 Y125.996
G1 X165.613 Y126.539 E.02361
G1 X165.311 Y126.308
G1 X165.854 Y125.764 E.02361
G1 X165.553 Y125.533
G1 X165.009 Y126.076 E.02361
G1 X164.708 Y125.845
G1 X165.251 Y125.301 E.02361
G1 X164.941 Y125.078
G1 X164.383 Y125.636 E.02423
G1 X164.045 Y125.441
G1 X164.603 Y124.883 E.02423
G1 X164.265 Y124.688
G1 X163.707 Y125.245 E.02423
G1 X163.369 Y125.05
G1 X163.927 Y124.493 E.02423
G1 X163.589 Y124.297
G1 X163.031 Y124.855 E.02423
G1 X162.693 Y124.66
G1 X163.25 Y124.102 E.02423
G1 X162.912 Y123.907
G1 X162.355 Y124.465 E.02423
G1 X162.017 Y124.269
G1 X162.574 Y123.712 E.02423
G1 X162.236 Y123.517
G1 X161.679 Y124.074 E.02423
G1 X161.316 Y123.904
G1 X161.898 Y123.321 E.02532
G1 X161.522 Y123.165
G1 X160.939 Y123.748 E.02534
G1 X160.561 Y123.592
G1 X161.145 Y123.009 E.02534
G1 X160.767 Y122.852
G1 X160.184 Y123.435 E.02534
G1 X159.807 Y123.279
G1 X160.39 Y122.696 E.02534
G1 X160.013 Y122.54
G1 X159.43 Y123.123 E.02534
G1 X159.053 Y122.967
G1 X159.636 Y122.384 E.02534
G1 X159.259 Y122.228
G1 X158.676 Y122.811 E.02534
G1 X158.297 Y122.656
G1 X158.882 Y122.071 E.02542
G1 X158.499 Y121.922
G1 X157.877 Y122.544 E.02703
G1 X157.456 Y122.431
G1 X158.078 Y121.809 E.02703
G1 X157.657 Y121.696
G1 X157.035 Y122.318 E.02703
G1 X156.615 Y122.206
G1 X157.237 Y121.584 E.02703
G1 X156.816 Y121.471
G1 X156.194 Y122.093 E.02703
G1 X155.774 Y121.98
G1 X156.396 Y121.358 E.02703
G1 X155.975 Y121.246
G1 X155.353 Y121.868 E.02703
G1 X154.933 Y121.755
G1 X155.555 Y121.133 E.02703
G1 X155.134 Y121.02
G1 X154.462 Y121.692 E.0292
G1 X153.991 Y121.63
G1 X154.67 Y120.951 E.02951
G1 X154.199 Y120.889
G1 X153.52 Y121.568 E.02951
G1 X153.048 Y121.506
G1 X153.727 Y120.827 E.02951
G1 X153.256 Y120.765
G1 X152.577 Y121.444 E.02951
G1 X152.106 Y121.382
G1 X152.785 Y120.703 E.02951
G1 X152.314 Y120.641
G1 X151.635 Y121.32 E.02951
G1 X151.126 Y121.295
G1 X151.843 Y120.579 E.03114
G1 X151.355 Y120.534
G1 X150.593 Y121.295 E.03311
G1 X150.059 Y121.295
G1 X150.821 Y120.534 E.03311
G1 X150.288 Y120.534
G1 X149.526 Y121.295 E.0331
G1 X148.993 Y121.295
G1 X149.755 Y120.534 E.0331
G1 X149.221 Y120.534
G1 X148.46 Y121.295 E.0331
G1 X147.924 Y121.298
G1 X148.688 Y120.534 E.0332
G1 X148.155 Y120.534
G1 X147.31 Y121.379 E.03671
G1 X146.696 Y121.459
G1 X147.581 Y120.574 E.03845
G1 X146.967 Y120.655
G1 X146.082 Y121.54 E.03845
G1 X145.468 Y121.621
G1 X146.353 Y120.736 E.03845
G1 X145.739 Y120.817
G1 X144.854 Y121.702 E.03845
G1 X144.198 Y121.824
G1 X145.124 Y120.898 E.04026
G1 X144.51 Y120.979
G1 X143.47 Y122.02 E.04523
G1 X142.741 Y122.215
G1 X143.818 Y121.137 E.04682
G1 X143.09 Y121.333
G1 X142.013 Y122.41 E.04682
G1 X141.284 Y122.605
G1 X142.362 Y121.528 E.04682
G1 X141.633 Y121.723
G1 X140.426 Y122.93 E.05245
G1 X139.516 Y123.307
G1 X140.905 Y121.918 E.06035
G1 X140.013 Y122.276
G1 X138.606 Y123.684 E.06117
G1 X137.642 Y124.114
G1 X139.103 Y122.653 E.06349
G1 X138.193 Y123.03
G1 X136.38 Y124.843 E.07876
; WIPE_START
M204 S10000
G1 X137.794 Y123.429 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.118 Y125.571 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X137.2 Y123.49 E.09044
; WIPE_START
M204 S10000
G1 X135.786 Y124.904 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.938 Y124.218 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X133.09 Y127.066 E.12375
; WIPE_START
M204 S10000
G1 X134.505 Y125.652 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.016 Y131.809 Z2.4 F30000
G1 X166.299 Y169.047 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X163.451 Y171.894 E.12374
; WIPE_START
M204 S10000
G1 X164.866 Y170.48 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X162.19 Y172.623 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X164.271 Y170.542 E.09044
; WIPE_START
M204 S10000
G1 X162.857 Y171.956 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X163.009 Y171.27 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X161.197 Y173.082 E.07875
G1 X160.287 Y173.459
G1 X161.748 Y171.998 E.06348
G1 X160.784 Y172.429
G1 X159.376 Y173.836 E.06117
G1 X158.485 Y174.195
G1 X159.874 Y172.806 E.06035
G1 X158.963 Y173.183
G1 X157.756 Y174.39 E.05244
G1 X157.028 Y174.585
G1 X158.105 Y173.508 E.04682
G1 X157.377 Y173.703
G1 X156.3 Y174.78 E.04682
G1 X155.571 Y174.975
G1 X156.648 Y173.898 E.04682
G1 X155.92 Y174.093
G1 X154.879 Y175.134 E.04523
G1 X154.265 Y175.215
G1 X155.192 Y174.288 E.04026
G1 X154.536 Y174.411
G1 X153.651 Y175.296 E.03845
G1 X153.037 Y175.376
G1 X153.922 Y174.492 E.03845
G1 X153.308 Y174.572
G1 X152.423 Y175.457 E.03845
G1 X151.809 Y175.538
G1 X152.694 Y174.653 E.03845
G1 X152.08 Y174.734
G1 X151.235 Y175.579 E.03671
G1 X150.701 Y175.579
G1 X151.465 Y174.815 E.0332
G1 X150.93 Y174.817
G1 X150.168 Y175.579 E.0331
G1 X149.635 Y175.579
G1 X150.397 Y174.817 E.03311
G1 X149.863 Y174.817
G1 X149.102 Y175.579 E.03311
G1 X148.568 Y175.579
G1 X149.33 Y174.817 E.03311
G1 X148.797 Y174.817
G1 X148.035 Y175.579 E.03311
G1 X147.547 Y175.534
G1 X148.264 Y174.817 E.03114
G1 X147.755 Y174.793
G1 X147.076 Y175.472 E.02951
G1 X146.605 Y175.41
G1 X147.284 Y174.731 E.02951
G1 X146.812 Y174.669
G1 X146.133 Y175.348 E.02951
G1 X145.662 Y175.286
G1 X146.341 Y174.607 E.02951
G1 X145.87 Y174.545
G1 X145.191 Y175.224 E.02951
G1 X144.72 Y175.162
G1 X145.399 Y174.483 E.02951
G1 X144.928 Y174.42
G1 X144.256 Y175.092 E.0292
G1 X143.835 Y174.98
G1 X144.457 Y174.358 E.02703
G1 X144.037 Y174.245
G1 X143.414 Y174.867 E.02703
G1 X142.994 Y174.754
G1 X143.616 Y174.132 E.02703
G1 X143.195 Y174.02
G1 X142.573 Y174.642 E.02703
G1 X142.153 Y174.529
G1 X142.775 Y173.907 E.02703
G1 X142.354 Y173.794
G1 X141.732 Y174.416 E.02703
G1 X141.312 Y174.304
G1 X141.934 Y173.682 E.02703
G1 X141.513 Y173.569
G1 X140.891 Y174.191 E.02703
G1 X140.508 Y174.041
G1 X141.093 Y173.456 E.02542
G1 X140.714 Y173.302
G1 X140.131 Y173.885 E.02534
G1 X139.753 Y173.729
G1 X140.337 Y173.146 E.02534
G1 X139.959 Y172.99
G1 X139.376 Y173.573 E.02534
G1 X138.999 Y173.416
G1 X139.582 Y172.833 E.02534
G1 X139.205 Y172.677
G1 X138.622 Y173.26 E.02534
G1 X138.245 Y173.104
G1 X138.828 Y172.521 E.02534
G1 X138.451 Y172.365
G1 X137.868 Y172.948 E.02534
G1 X137.492 Y172.791
G1 X138.074 Y172.209 E.02532
G1 X137.711 Y172.038
G1 X137.153 Y172.596 E.02423
G1 X136.815 Y172.401
G1 X137.373 Y171.843 E.02423
G1 X137.035 Y171.648
G1 X136.477 Y172.206 E.02423
G1 X136.139 Y172.01
G1 X136.697 Y171.453 E.02423
G1 X136.359 Y171.258
G1 X135.801 Y171.815 E.02423
G1 X135.463 Y171.62
G1 X136.021 Y171.062 E.02423
G1 X135.683 Y170.867
G1 X135.125 Y171.425 E.02423
G1 X134.787 Y171.23
G1 X135.345 Y170.672 E.02423
G1 X135.007 Y170.477
G1 X134.449 Y171.034 E.02423
G1 X134.139 Y170.811
G1 X134.682 Y170.268 E.02361
G1 X134.38 Y170.036
G1 X133.837 Y170.58 E.02361
G1 X133.535 Y170.348
G1 X134.079 Y169.805 E.02361
G1 X133.777 Y169.573
G1 X133.234 Y170.117 E.02361
G1 X132.932 Y169.885
G1 X133.475 Y169.342 E.02361
G1 X133.173 Y169.11
G1 X132.63 Y169.654 E.02361
G1 X132.328 Y169.422
G1 X132.872 Y168.879 E.02361
G1 X132.57 Y168.647
G1 X132.027 Y169.191 E.02361
G1 X131.725 Y168.959
G1 X132.268 Y168.416 E.02361
G1 X131.972 Y168.179
G1 X131.433 Y168.718 E.02341
G1 X131.167 Y168.451
G1 X131.705 Y167.912 E.02341
G1 X131.439 Y167.646
G1 X130.9 Y168.184 E.02341
G1 X130.633 Y167.918
G1 X131.172 Y167.379 E.02341
G1 X130.905 Y167.112
G1 X130.367 Y167.651 E.02341
G1 X130.1 Y167.384
G1 X130.639 Y166.846 E.02341
G1 X130.372 Y166.579
G1 X129.833 Y167.118 E.02341
G1 X129.567 Y166.851
M73 P70 R8
G1 X130.105 Y166.312 E.02341
G1 X129.839 Y166.046
G1 X129.3 Y166.585 E.02341
G1 X129.034 Y166.318
G1 X129.572 Y165.779 E.02341
G1 X129.335 Y165.483
G1 X128.792 Y166.026 E.02361
G1 X128.561 Y165.724
G1 X129.104 Y165.181 E.02361
G1 X128.872 Y164.879
G1 X128.329 Y165.423 E.02361
G1 X128.097 Y165.121
G1 X128.641 Y164.578 E.02361
G1 X128.409 Y164.276
G1 X127.866 Y164.819 E.02361
G1 X127.634 Y164.518
G1 X128.178 Y163.974 E.02361
G1 X127.946 Y163.672
G1 X127.403 Y164.216 E.02361
G1 X127.171 Y163.914
G1 X127.715 Y163.371 E.02361
G1 X127.483 Y163.069
G1 X126.94 Y163.612 E.02361
G1 X126.717 Y163.302
G1 X127.274 Y162.745 E.02423
G1 X127.079 Y162.406
G1 X126.521 Y162.964 E.02423
G1 X126.326 Y162.626
G1 X126.884 Y162.068 E.02423
G1 X126.689 Y161.73
G1 X126.131 Y162.288 E.02423
G1 X125.936 Y161.95
G1 X126.494 Y161.392 E.02423
G1 X126.298 Y161.054
G1 X125.741 Y161.612 E.02423
G1 X125.546 Y161.274
G1 X126.103 Y160.716 E.02423
G1 X125.908 Y160.378
G1 X125.35 Y160.936 E.02423
G1 X125.155 Y160.598
G1 X125.713 Y160.04 E.02423
G1 X125.543 Y159.677
G1 X124.96 Y160.26 E.02532
G1 X124.803 Y159.883
G1 X125.386 Y159.3 E.02534
G1 X125.23 Y158.923
G1 X124.647 Y159.506 E.02534
G1 X124.491 Y159.129
G1 X125.074 Y158.546 E.02534
G1 X124.918 Y158.169
G1 X124.335 Y158.752 E.02534
G1 X124.179 Y158.375
G1 X124.762 Y157.792 E.02534
G1 X124.605 Y157.415
G1 X124.022 Y157.998 E.02534
G1 X123.866 Y157.621
G1 X124.449 Y157.038 E.02534
G1 X124.295 Y156.659
G1 X123.71 Y157.244 E.02542
G1 X123.56 Y156.86
G1 X124.182 Y156.238 E.02703
G1 X124.07 Y155.817
G1 X123.448 Y156.439 E.02703
G1 X123.335 Y156.019
G1 X123.957 Y155.397 E.02703
G1 X123.844 Y154.976
G1 X123.222 Y155.598 E.02703
G1 X123.109 Y155.178
G1 X123.732 Y154.556 E.02703
G1 X123.619 Y154.135
G1 X122.997 Y154.757 E.02703
G1 X122.884 Y154.337
G1 X123.506 Y153.715 E.02703
G1 X123.393 Y153.294
G1 X122.771 Y153.916 E.02703
G1 X122.659 Y153.495
G1 X123.331 Y152.823 E.0292
G1 X123.269 Y152.352
G1 X122.59 Y153.031 E.02951
G1 X122.528 Y152.56
G1 X123.207 Y151.881 E.02951
G1 X123.145 Y151.41
G1 X122.466 Y152.089 E.02951
G1 X122.404 Y151.618
G1 X123.083 Y150.939 E.02951
G1 X123.021 Y150.467
G1 X122.342 Y151.146 E.02951
G1 X122.279 Y150.675
G1 X122.958 Y149.996 E.02951
G1 X122.934 Y149.487
G1 X122.217 Y150.204 E.03114
G1 X122.172 Y149.716
G1 X122.934 Y148.954 E.0331
G1 X122.934 Y148.421
G1 X122.172 Y149.183 E.0331
G1 X122.172 Y148.649
G1 X122.934 Y147.888 E.0331
G1 X122.934 Y147.354
G1 X122.172 Y148.116 E.0331
G1 X122.172 Y147.583
G1 X122.934 Y146.821 E.0331
G1 X122.936 Y146.286
G1 X122.172 Y147.05 E.0332
G1 X122.172 Y146.516
G1 X123.017 Y145.672 E.03671
G1 X123.098 Y145.057
G1 X122.213 Y145.942 E.03845
G1 X122.294 Y145.328
G1 X123.179 Y144.443 E.03845
G1 X123.26 Y143.829
G1 X122.375 Y144.714 E.03845
G1 X122.456 Y144.1
G1 X123.34 Y143.215 E.03845
G1 X123.463 Y142.559
G1 X122.536 Y143.486 E.04026
G1 X122.617 Y142.872
G1 X123.658 Y141.831 E.04523
G1 X123.853 Y141.103
G1 X122.776 Y142.18 E.04682
G1 X122.971 Y141.451
G1 X124.048 Y140.374 E.04682
G1 X124.244 Y139.646
G1 X123.166 Y140.723 E.04682
G1 X123.361 Y139.995
G1 X124.568 Y138.788 E.05245
G1 X124.945 Y137.877
G1 X123.557 Y139.266 E.06035
G1 X123.915 Y138.375
G1 X125.322 Y136.967 E.06117
G1 X125.753 Y136.003
G1 X124.292 Y137.464 E.06349
G1 X124.669 Y136.554
G1 X126.481 Y134.742 E.07876
; WIPE_START
M204 S10000
G1 X125.067 Y136.156 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.21 Y133.48 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X125.128 Y135.561 E.09044
; WIPE_START
M204 S10000
G1 X126.543 Y134.147 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.857 Y134.3 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X128.705 Y131.452 E.12375
; WIPE_START
M204 S10000
G1 X127.29 Y132.866 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.585 Y133.038 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X134.676 Y124.947 E.3516
; WIPE_START
M204 S10000
G1 X133.262 Y126.361 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.634 Y126.456 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X128.095 Y130.995 E.19724
; WIPE_START
M204 S10000
G1 X129.509 Y129.581 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.933 Y136.324 Z2.4 F30000
G1 X124.363 Y139.286 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102026
G1 F15000
G1 X124.317 Y139.354 E.0004
; LINE_WIDTH: 0.140352
G2 X124.175 Y139.577 I3.257 J2.226 E.0021
; WIPE_START
G1 X124.317 Y139.354 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.354 Y137.527 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.18988
G1 F15000
G1 X124.276 Y137.643 E.00168
; LINE_WIDTH: 0.149196
G1 X124.198 Y137.76 E.00121
; LINE_WIDTH: 0.108512
G1 X124.121 Y137.876 E.00075
; WIPE_START
G1 X124.198 Y137.76 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.189 Y135.622 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.208577
G1 F15000
G1 X125.092 Y135.749 E.00216
; LINE_WIDTH: 0.178752
G1 X124.995 Y135.876 E.00177
; LINE_WIDTH: 0.144915
G1 X124.935 Y135.966 E.0009
; LINE_WIDTH: 0.107085
G1 X124.875 Y136.056 E.00057
; WIPE_START
G1 X124.935 Y135.966 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.077 Y135.441 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.11072
G1 F15000
G1 X125.948 Y135.608 E.00116
; LINE_WIDTH: 0.155833
G1 X125.82 Y135.775 E.00194
; LINE_WIDTH: 0.200945
G1 X125.692 Y135.942 E.00271
; WIPE_START
G1 X125.82 Y135.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.918 Y134.361 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200933
G1 F15000
G1 X125.79 Y134.528 E.00271
; LINE_WIDTH: 0.155825
G1 X125.661 Y134.695 E.00194
; LINE_WIDTH: 0.110717
G1 X125.533 Y134.862 E.00116
; WIPE_START
G1 X125.661 Y134.695 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.805 Y134.179 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.110719
G1 F15000
G1 X126.677 Y134.346 E.00116
; LINE_WIDTH: 0.155831
G1 X126.549 Y134.514 E.00194
; LINE_WIDTH: 0.200943
G1 X126.42 Y134.681 E.00271
; WIPE_START
G1 X126.549 Y134.514 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.646 Y133.099 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200933
G1 F15000
G1 X126.518 Y133.266 E.00271
; LINE_WIDTH: 0.155825
G1 X126.39 Y133.433 E.00194
; LINE_WIDTH: 0.110717
G1 X126.262 Y133.6 E.00116
; WIPE_START
G1 X126.39 Y133.433 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.714 Y132.739 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.104581
G1 F15000
G1 X127.541 Y132.937 E.00132
; LINE_WIDTH: 0.137872
G1 X127.363 Y133.139 E.00209
; LINE_WIDTH: 0.172307
G1 X127.256 Y133.279 E.00186
; LINE_WIDTH: 0.206426
G1 X127.149 Y133.419 E.00235
; WIPE_START
G1 X127.256 Y133.279 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.155 Y131.055 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.211999
G1 F15000
G1 X127.879 Y131.37 E.00577
; LINE_WIDTH: 0.162467
G1 X127.603 Y131.685 E.00408
; LINE_WIDTH: 0.112935
G1 X127.327 Y132 E.00239
; WIPE_START
G1 X127.603 Y131.685 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.472 Y130.448 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.112936
G1 F15000
G1 X129.196 Y130.762 E.00239
; LINE_WIDTH: 0.162468
G1 X128.92 Y131.077 E.00408
; LINE_WIDTH: 0.212
G1 X128.644 Y131.392 E.00577
; WIPE_START
G1 X128.92 Y131.077 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.03 Y127.006 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.212002
G1 F15000
G1 X132.716 Y127.282 E.00577
; LINE_WIDTH: 0.162466
G1 X132.401 Y127.558 E.00408
; LINE_WIDTH: 0.112929
G1 X132.086 Y127.834 E.00239
; WIPE_START
G1 X132.401 Y127.558 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.638 Y125.688 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.11293
G1 F15000
G1 X133.323 Y125.964 E.00239
; LINE_WIDTH: 0.162466
G1 X133.009 Y126.24 E.00408
; LINE_WIDTH: 0.212002
G1 X132.694 Y126.516 E.00577
; WIPE_START
G1 X133.009 Y126.24 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.058 Y125.51 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.206423
G1 F15000
G1 X134.918 Y125.618 E.00235
; LINE_WIDTH: 0.171575
G1 X134.772 Y125.73 E.00193
; LINE_WIDTH: 0.137366
G1 X134.575 Y125.902 E.00202
; LINE_WIDTH: 0.104563
G1 X134.378 Y126.075 E.00132
; WIPE_START
G1 X134.575 Y125.902 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.239 Y124.623 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.110729
G1 F15000
G1 X135.072 Y124.751 E.00116
; LINE_WIDTH: 0.155838
G1 X134.905 Y124.88 E.00194
; LINE_WIDTH: 0.200946
G1 X134.737 Y125.008 E.00271
; WIPE_START
G1 X134.905 Y124.88 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.319 Y124.782 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.20094
G1 F15000
G1 X136.152 Y124.91 E.00271
; LINE_WIDTH: 0.155834
G1 X135.985 Y125.038 E.00194
; LINE_WIDTH: 0.110728
G1 X135.818 Y125.167 E.00116
; WIPE_START
G1 X135.985 Y125.038 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.501 Y123.895 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.110728
G1 F15000
G1 X136.333 Y124.023 E.00116
; LINE_WIDTH: 0.155833
G1 X136.166 Y124.151 E.00194
; LINE_WIDTH: 0.200939
G1 X135.999 Y124.279 E.00271
; WIPE_START
G1 X136.166 Y124.151 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.581 Y124.053 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.200938
G1 F15000
G1 X137.414 Y124.182 E.00271
; LINE_WIDTH: 0.155833
G1 X137.247 Y124.31 E.00194
; LINE_WIDTH: 0.110728
G1 X137.079 Y124.438 E.00116
; WIPE_START
G1 X137.247 Y124.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.694 Y123.236 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.107107
G1 F15000
G1 X137.604 Y123.296 E.00057
; LINE_WIDTH: 0.144971
G1 X137.514 Y123.356 E.0009
; LINE_WIDTH: 0.178803
G1 X137.388 Y123.454 E.00177
; LINE_WIDTH: 0.208597
G1 X137.261 Y123.551 E.00216
; WIPE_START
G1 X137.388 Y123.454 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.454 Y123.245 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.189873
G1 F15000
G1 X139.337 Y123.322 E.00168
; LINE_WIDTH: 0.149194
G1 X139.22 Y123.4 E.00121
; LINE_WIDTH: 0.108515
G1 X139.104 Y123.478 E.00075
; WIPE_START
G1 X139.22 Y123.4 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.515 Y122.482 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108516
G1 F15000
G1 X139.398 Y122.56 E.00075
; LINE_WIDTH: 0.149196
G1 X139.282 Y122.638 E.00121
; LINE_WIDTH: 0.189876
G1 X139.165 Y122.716 E.00168
; WIPE_START
G1 X139.282 Y122.638 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.216 Y122.537 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.14504
G1 F15000
G1 X141.061 Y122.633 E.00151
; LINE_WIDTH: 0.12965
G1 X140.993 Y122.678 E.00058
; LINE_WIDTH: 0.102
G1 X140.924 Y122.724 E.0004
; WIPE_START
G1 X140.993 Y122.678 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X148.621 Y122.438 Z2.4 F30000
G1 X159.023 Y122.11 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0930466
G1 F15000
G3 X158.925 Y122.088 I-.033 J-.084 E.00044
G1 X159.822 Y122.441 F30000
; LINE_WIDTH: 0.104614
G1 F15000
G3 X159.769 Y122.461 I-.064 J-.086 E.00029
G1 X159.679 Y122.401 E.00055
; WIPE_START
G1 X159.769 Y122.461 E-.49911
G1 X159.822 Y122.441 E-.26089
; WIPE_END
G1 E-.04 F1800
G1 X162.963 Y129.397 Z2.4 F30000
G1 X175.214 Y156.535 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.145075
G1 F15000
G1 X175.032 Y156.83 E.00289
; WIPE_START
G1 X175.214 Y156.535 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X175.269 Y158.236 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108507
G1 F15000
G1 X175.191 Y158.353 E.00075
; LINE_WIDTH: 0.149182
G1 X175.114 Y158.469 E.00121
; LINE_WIDTH: 0.189856
G1 X175.036 Y158.586 E.00168
G1 X174.507 Y158.297 F30000
; LINE_WIDTH: 0.18988
G1 F15000
G1 X174.429 Y158.414 E.00168
; LINE_WIDTH: 0.149196
G1 X174.351 Y158.531 E.00121
; LINE_WIDTH: 0.108512
G1 X174.273 Y158.647 E.00075
; WIPE_START
G1 X174.351 Y158.531 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X174.515 Y160.057 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.107123
G1 F15000
G1 X174.455 Y160.147 E.00057
; LINE_WIDTH: 0.145016
G1 X174.395 Y160.237 E.0009
; LINE_WIDTH: 0.178852
G1 X174.298 Y160.363 E.00177
; LINE_WIDTH: 0.208609
G1 X174.201 Y160.49 E.00215
G1 X173.698 Y160.17 F30000
; LINE_WIDTH: 0.200945
G1 F15000
G1 X173.57 Y160.337 E.00271
; LINE_WIDTH: 0.155832
G1 X173.442 Y160.504 E.00194
; LINE_WIDTH: 0.11072
G1 X173.313 Y160.671 E.00116
G1 X173.857 Y161.25 F30000
; LINE_WIDTH: 0.110723
G1 F15000
G1 X173.729 Y161.417 E.00116
; LINE_WIDTH: 0.15584
G1 X173.6 Y161.585 E.00194
; LINE_WIDTH: 0.200957
G1 X173.472 Y161.752 E.00271
G1 X172.97 Y161.432 F30000
; LINE_WIDTH: 0.200933
G1 F15000
G1 X172.841 Y161.599 E.00271
; LINE_WIDTH: 0.155825
G1 X172.713 Y161.766 E.00194
; LINE_WIDTH: 0.110717
G1 X172.585 Y161.933 E.00116
G1 X173.128 Y162.512 F30000
G1 F15000
G1 X173 Y162.679 E.00116
; LINE_WIDTH: 0.155825
G1 X172.872 Y162.846 E.00194
; LINE_WIDTH: 0.200933
G1 X172.744 Y163.013 E.00271
G1 X172.241 Y162.693 F30000
; LINE_WIDTH: 0.206404
G1 F15000
G1 X172.134 Y162.833 E.00235
; LINE_WIDTH: 0.17153
G1 X172.022 Y162.979 E.00193
; LINE_WIDTH: 0.137331
G1 X171.849 Y163.176 E.00201
; LINE_WIDTH: 0.104557
G1 X171.676 Y163.373 E.00132
G1 X172.063 Y164.113 F30000
; LINE_WIDTH: 0.112933
G1 F15000
G1 X171.787 Y164.427 E.00239
; LINE_WIDTH: 0.162461
G1 X171.511 Y164.742 E.00408
; LINE_WIDTH: 0.211989
G1 X171.235 Y165.057 E.00577
G1 X170.746 Y164.72 F30000
; LINE_WIDTH: 0.211999
G1 F15000
G1 X170.47 Y165.035 E.00577
; LINE_WIDTH: 0.162467
G1 X170.194 Y165.35 E.00408
; LINE_WIDTH: 0.112935
G1 X169.918 Y165.664 E.00239
; WIPE_START
G1 X170.194 Y165.35 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X167.303 Y168.279 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.112929
G1 F15000
G1 X166.988 Y168.555 E.00239
; LINE_WIDTH: 0.162464
G1 X166.674 Y168.831 E.00408
; LINE_WIDTH: 0.211999
G1 X166.359 Y169.107 E.00577
G1 X166.695 Y169.597 F30000
; LINE_WIDTH: 0.212003
G1 F15000
G1 X166.381 Y169.873 E.00577
; LINE_WIDTH: 0.162466
G1 X166.066 Y170.149 E.00408
; LINE_WIDTH: 0.11293
G1 X165.751 Y170.425 E.00239
G1 X165.011 Y170.038 F30000
; LINE_WIDTH: 0.104542
G1 F15000
G1 X164.814 Y170.21 E.00131
; LINE_WIDTH: 0.137768
G1 X164.612 Y170.388 E.00208
; LINE_WIDTH: 0.172212
G1 X164.472 Y170.495 E.00186
; LINE_WIDTH: 0.206399
G1 X164.332 Y170.603 E.00235
G1 X164.652 Y171.105 F30000
; LINE_WIDTH: 0.200942
G1 F15000
G1 X164.485 Y171.233 E.00271
; LINE_WIDTH: 0.155835
G1 X164.318 Y171.362 E.00194
; LINE_WIDTH: 0.110728
G1 X164.151 Y171.49 E.00116
G1 X163.572 Y170.946 F30000
; LINE_WIDTH: 0.110728
G1 F15000
G1 X163.405 Y171.074 E.00116
; LINE_WIDTH: 0.155834
G1 X163.237 Y171.203 E.00194
; LINE_WIDTH: 0.20094
G1 X163.07 Y171.331 E.00271
G1 X163.39 Y171.833 F30000
; LINE_WIDTH: 0.200942
G1 F15000
G1 X163.223 Y171.962 E.00271
; LINE_WIDTH: 0.155835
G1 X163.056 Y172.09 E.00194
; LINE_WIDTH: 0.110728
G1 X162.889 Y172.218 E.00116
G1 X162.31 Y171.675 F30000
; LINE_WIDTH: 0.110728
G1 F15000
G1 X162.143 Y171.803 E.00116
; LINE_WIDTH: 0.155834
G1 X161.976 Y171.931 E.00194
; LINE_WIDTH: 0.200939
G1 X161.809 Y172.059 E.00271
G1 X162.129 Y172.562 F30000
; LINE_WIDTH: 0.208624
G1 F15000
G1 X162.002 Y172.659 E.00215
; LINE_WIDTH: 0.178878
G1 X161.876 Y172.756 E.00177
; LINE_WIDTH: 0.145038
G1 X161.785 Y172.816 E.0009
; LINE_WIDTH: 0.107129
G1 X161.695 Y172.877 E.00057
; WIPE_START
G1 X161.785 Y172.816 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X160.286 Y172.634 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108514
G1 F15000
G1 X160.169 Y172.712 E.00075
; LINE_WIDTH: 0.149191
G1 X160.053 Y172.79 E.00121
; LINE_WIDTH: 0.189868
G1 X159.936 Y172.868 E.00168
G1 X160.224 Y173.397 F30000
G1 F15000
G1 X160.108 Y173.475 E.00168
; LINE_WIDTH: 0.149191
G1 X159.991 Y173.553 E.00121
; LINE_WIDTH: 0.108514
G1 X159.875 Y173.631 E.00075
; WIPE_START
G1 X159.991 Y173.553 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X158.465 Y173.389 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.10198
G1 F15000
G1 X158.397 Y173.434 E.0004
; LINE_WIDTH: 0.140181
G3 X158.174 Y173.576 I-2.226 J-3.257 E.00209
; OBJECT_ID: 192
; WIPE_START
G1 X158.397 Y173.434 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 269
M625
; start printing object, unique label id: 192
M624 AgAAAAAAAAA=
G1 X150.955 Y171.738 Z2.4 F30000
G1 X115.965 Y163.76 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.545 Y163.76 E.41236
G1 X102.545 Y139.34 E.75036
G1 X115.965 Y139.34 E.41236
G1 X115.965 Y163.7 E.74851
; WIPE_START
M204 S10000
G1 X113.965 Y163.709 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.084 Y157.137 Z2.4 F30000
G1 X100.165 Y140.34 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X98.965 Y140.34 E.03687
G1 X98.965 Y138.96 E.0424
G1 X100.165 Y138.96 E.03687
G1 X100.165 Y137.34 E.04978
G1 X98.965 Y137.34 E.03687
G1 X98.965 Y135.76 E.04855
G1 X119.545 Y135.76 E.63237
G1 X119.545 Y167.341 E.97037
G1 X98.965 Y167.341 E.63237
G1 X98.965 Y141.96 E.77986
G1 X100.165 Y141.96 E.03687
G1 X100.165 Y140.4 E.04793
; WIPE_START
M204 S10000
G1 X98.965 Y140.34 E-.45657
G1 X98.965 Y139.542 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X103.592 Y145.612 Z2.4 F30000
G1 X119.337 Y166.264 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X118.469 Y167.133 E.03776
G1 X117.935 Y167.133
G1 X119.337 Y165.731 E.06093
G1 X119.337 Y165.198
G1 X117.402 Y167.133 E.0841
G1 X116.869 Y167.133
G1 X119.337 Y164.665 E.10727
G1 X119.337 Y164.131
G1 X116.336 Y167.133 E.13045
G1 X115.802 Y167.133
G1 X119.337 Y163.598 E.15362
G1 X119.337 Y163.065
G1 X115.269 Y167.133 E.17679
G1 X114.736 Y167.133
G1 X119.337 Y162.531 E.19996
G1 X119.337 Y161.998
G1 X114.203 Y167.133 E.22314
G1 X113.669 Y167.133
G1 X119.337 Y161.465 E.24631
G1 X119.337 Y160.932
G1 X113.136 Y167.133 E.26948
G1 X112.603 Y167.133
G1 X115.768 Y163.968 E.13755
G1 X115.235 Y163.968
G1 X112.07 Y167.133 E.13755
G1 X111.536 Y167.133
G1 X114.702 Y163.968 E.13755
G1 X114.168 Y163.968
G1 X111.003 Y167.133 E.13755
G1 X110.47 Y167.133
G1 X113.635 Y163.968 E.13755
G1 X113.102 Y163.968
G1 X109.937 Y167.133 E.13755
G1 X109.403 Y167.133
G1 X112.569 Y163.968 E.13755
G1 X112.035 Y163.968
G1 X108.87 Y167.133 E.13755
G1 X108.337 Y167.133
G1 X111.502 Y163.968 E.13755
G1 X110.969 Y163.968
G1 X107.803 Y167.133 E.13755
G1 X107.27 Y167.133
G1 X110.435 Y163.968 E.13755
G1 X109.902 Y163.968
G1 X106.737 Y167.133 E.13755
G1 X106.204 Y167.133
G1 X109.369 Y163.968 E.13755
G1 X108.836 Y163.968
G1 X105.67 Y167.133 E.13754
G1 X105.137 Y167.133
G1 X108.302 Y163.968 E.13754
G1 X107.769 Y163.968
G1 X104.604 Y167.133 E.13755
G1 X104.071 Y167.133
G1 X107.236 Y163.968 E.13754
G1 X106.703 Y163.968
G1 X103.537 Y167.133 E.13754
G1 X103.004 Y167.133
G1 X106.169 Y163.968 E.13754
G1 X105.636 Y163.968
G1 X102.471 Y167.133 E.13755
G1 X101.938 Y167.133
G1 X105.103 Y163.968 E.13754
G1 X104.57 Y163.968
G1 X101.404 Y167.133 E.13754
G1 X100.871 Y167.133
G1 X104.036 Y163.968 E.13754
G1 X103.503 Y163.968
G1 X100.338 Y167.133 E.13755
G1 X99.805 Y167.133
G1 X102.97 Y163.968 E.13754
G1 X102.437 Y163.968
G1 X99.271 Y167.133 E.13755
G1 X99.172 Y166.699
G1 X102.337 Y163.534 E.13755
G1 X102.337 Y163.001
G1 X99.172 Y166.166 E.13755
G1 X99.172 Y165.632
G1 X102.337 Y162.467 E.13755
G1 X102.337 Y161.934
G1 X99.172 Y165.099 E.13755
G1 X99.172 Y164.566
G1 X102.337 Y161.401 E.13755
G1 X102.337 Y160.867
G1 X99.172 Y164.033 E.13755
G1 X99.172 Y163.499
G1 X102.337 Y160.334 E.13755
G1 X102.337 Y159.801
G1 X99.172 Y162.966 E.13755
G1 X99.172 Y162.433
G1 X102.337 Y159.268 E.13755
G1 X102.337 Y158.734
G1 X99.172 Y161.9 E.13755
G1 X99.172 Y161.366
G1 X102.337 Y158.201 E.13755
G1 X102.337 Y157.668
G1 X99.172 Y160.833 E.13755
G1 X99.172 Y160.3
G1 X102.337 Y157.135 E.13755
G1 X102.337 Y156.601
G1 X99.172 Y159.767 E.13755
G1 X99.172 Y159.233
G1 X102.337 Y156.068 E.13755
G1 X102.337 Y155.535
G1 X99.172 Y158.7 E.13755
G1 X99.172 Y158.167
G1 X102.337 Y155.002 E.13755
G1 X102.337 Y154.468
G1 X99.172 Y157.634 E.13755
G1 X99.172 Y157.1
G1 X102.337 Y153.935 E.13755
G1 X102.337 Y153.402
G1 X99.172 Y156.567 E.13755
M73 P71 R8
G1 X99.172 Y156.034
G1 X102.337 Y152.869 E.13755
G1 X102.337 Y152.335
G1 X99.172 Y155.501 E.13755
G1 X99.172 Y154.967
G1 X102.337 Y151.802 E.13755
G1 X102.337 Y151.269
G1 X99.172 Y154.434 E.13755
G1 X99.172 Y153.901
G1 X102.337 Y150.736 E.13755
G1 X102.337 Y150.202
G1 X99.172 Y153.368 E.13755
G1 X99.172 Y152.834
G1 X102.337 Y149.669 E.13755
G1 X102.337 Y149.136
G1 X99.172 Y152.301 E.13755
G1 X99.172 Y151.768
G1 X102.337 Y148.603 E.13755
G1 X102.337 Y148.069
G1 X99.172 Y151.235 E.13755
G1 X99.172 Y150.701
G1 X102.337 Y147.536 E.13755
M73 P71 R7
G1 X102.337 Y147.003
G1 X99.172 Y150.168 E.13755
G1 X99.172 Y149.635
G1 X102.337 Y146.47 E.13755
G1 X102.337 Y145.936
G1 X99.172 Y149.102 E.13755
G1 X99.172 Y148.568
G1 X102.337 Y145.403 E.13755
G1 X102.337 Y144.87
G1 X99.172 Y148.035 E.13755
G1 X99.172 Y147.502
G1 X102.337 Y144.336 E.13755
G1 X102.337 Y143.803
G1 X99.172 Y146.968 E.13755
G1 X99.172 Y146.435
G1 X102.337 Y143.27 E.13755
G1 X102.337 Y142.737
G1 X99.172 Y145.902 E.13755
G1 X99.172 Y145.369
G1 X102.337 Y142.203 E.13755
G1 X102.337 Y141.67
G1 X99.172 Y144.835 E.13755
G1 X99.172 Y144.302
G1 X102.337 Y141.137 E.13755
G1 X102.337 Y140.604
G1 X99.172 Y143.769 E.13755
G1 X99.172 Y143.236
G1 X100.24 Y142.168 E.0464
G1 X99.707 Y142.168
G1 X99.172 Y142.702 E.02323
; WIPE_START
M204 S10000
G1 X99.707 Y142.168 E-.28727
G1 X100.24 Y142.168 E-.20264
G1 X99.737 Y142.67 E-.27009
; WIPE_END
G1 E-.04 F1800
G1 X100.372 Y142.036 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X102.337 Y140.07 E.0854
G1 X102.337 Y139.537
G1 X100.372 Y141.502 E.0854
; WIPE_START
M204 S10000
G1 X101.786 Y140.088 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.777 Y145.863 Z2.4 F30000
G1 X119.337 Y160.398 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X116.172 Y163.564 E.13755
G1 X116.172 Y163.03
G1 X119.337 Y159.865 E.13755
G1 X119.337 Y159.332
G1 X116.172 Y162.497 E.13755
G1 X116.172 Y161.964
G1 X119.337 Y158.799 E.13755
G1 X119.337 Y158.265
G1 X116.172 Y161.431 E.13755
G1 X116.172 Y160.897
G1 X119.337 Y157.732 E.13755
G1 X119.337 Y157.199
G1 X116.172 Y160.364 E.13755
G1 X116.172 Y159.831
G1 X119.337 Y156.666 E.13755
G1 X119.337 Y156.132
G1 X116.172 Y159.298 E.13755
G1 X116.172 Y158.764
G1 X119.337 Y155.599 E.13755
G1 X119.337 Y155.066
G1 X116.172 Y158.231 E.13755
G1 X116.172 Y157.698
G1 X119.337 Y154.533 E.13755
G1 X119.337 Y153.999
G1 X116.172 Y157.165 E.13755
G1 X116.172 Y156.631
G1 X119.337 Y153.466 E.13755
G1 X119.337 Y152.933
G1 X116.172 Y156.098 E.13755
G1 X116.172 Y155.565
G1 X119.337 Y152.4 E.13755
G1 X119.337 Y151.866
G1 X116.172 Y155.032 E.13755
G1 X116.172 Y154.498
G1 X119.337 Y151.333 E.13754
G1 X119.337 Y150.8
G1 X116.172 Y153.965 E.13754
G1 X116.172 Y153.432
G1 X119.337 Y150.267 E.13755
G1 X119.337 Y149.733
G1 X116.172 Y152.899 E.13754
G1 X116.172 Y152.365
G1 X119.337 Y149.2 E.13754
G1 X119.337 Y148.667
G1 X116.172 Y151.832 E.13754
G1 X116.172 Y151.299
G1 X119.337 Y148.134 E.13755
G1 X119.337 Y147.6
G1 X116.172 Y150.766 E.13755
G1 X116.172 Y150.232
G1 X119.337 Y147.067 E.13755
G1 X119.337 Y146.534
G1 X116.172 Y149.699 E.13755
G1 X116.172 Y149.166
G1 X119.337 Y146 E.13755
G1 X119.337 Y145.467
G1 X116.172 Y148.632 E.13755
G1 X116.172 Y148.099
G1 X119.337 Y144.934 E.13755
G1 X119.337 Y144.401
G1 X116.172 Y147.566 E.13755
G1 X116.172 Y147.033
G1 X119.337 Y143.867 E.13755
G1 X119.337 Y143.334
G1 X116.172 Y146.499 E.13755
G1 X116.172 Y145.966
G1 X119.337 Y142.801 E.13755
G1 X119.337 Y142.268
G1 X116.172 Y145.433 E.13755
G1 X116.172 Y144.9
G1 X119.337 Y141.734 E.13755
G1 X119.337 Y141.201
G1 X116.172 Y144.366 E.13755
G1 X116.172 Y143.833
G1 X119.337 Y140.668 E.13755
G1 X119.337 Y140.135
G1 X116.172 Y143.3 E.13755
G1 X116.172 Y142.767
G1 X119.337 Y139.601 E.13755
G1 X119.337 Y139.068
G1 X116.172 Y142.233 E.13755
G1 X116.172 Y141.7
G1 X119.337 Y138.535 E.13755
G1 X119.337 Y138.002
G1 X116.172 Y141.167 E.13755
G1 X116.172 Y140.634
G1 X119.337 Y137.468 E.13755
G1 X119.337 Y136.935
G1 X116.172 Y140.1 E.13755
G1 X116.172 Y139.567
G1 X119.337 Y136.402 E.13755
G1 X119.238 Y135.968
G1 X116.073 Y139.133 E.13755
G1 X115.54 Y139.133
G1 X118.705 Y135.968 E.13755
G1 X118.172 Y135.968
G1 X115.006 Y139.133 E.13755
G1 X114.473 Y139.133
G1 X117.638 Y135.968 E.13755
G1 X117.105 Y135.968
G1 X113.94 Y139.133 E.13755
G1 X113.407 Y139.133
G1 X116.572 Y135.968 E.13755
G1 X116.039 Y135.968
G1 X112.873 Y139.133 E.13755
G1 X112.34 Y139.133
G1 X115.505 Y135.968 E.13755
G1 X114.972 Y135.968
G1 X111.807 Y139.133 E.13755
G1 X111.274 Y139.133
G1 X114.439 Y135.968 E.13755
G1 X113.906 Y135.968
G1 X110.74 Y139.133 E.13755
G1 X110.207 Y139.133
G1 X113.372 Y135.968 E.13755
G1 X112.839 Y135.968
G1 X109.674 Y139.133 E.13755
G1 X109.141 Y139.133
G1 X112.306 Y135.968 E.13755
G1 X111.773 Y135.968
G1 X108.607 Y139.133 E.13755
G1 X108.074 Y139.133
G1 X111.239 Y135.968 E.13755
G1 X110.706 Y135.968
G1 X107.541 Y139.133 E.13755
G1 X107.008 Y139.133
G1 X110.173 Y135.968 E.13755
G1 X109.64 Y135.968
G1 X106.474 Y139.133 E.13755
G1 X105.941 Y139.133
G1 X109.106 Y135.968 E.13755
G1 X108.573 Y135.968
G1 X105.408 Y139.133 E.13755
G1 X104.875 Y139.133
G1 X108.04 Y135.968 E.13755
G1 X107.507 Y135.968
G1 X104.341 Y139.133 E.13755
G1 X103.808 Y139.133
G1 X106.973 Y135.968 E.13755
G1 X106.44 Y135.968
G1 X103.275 Y139.133 E.13755
G1 X102.742 Y139.133
G1 X105.907 Y135.968 E.13755
G1 X105.374 Y135.968
G1 X100.372 Y140.969 E.21733
G1 X100.372 Y140.436
G1 X104.84 Y135.968 E.19416
G1 X104.307 Y135.968
G1 X100.142 Y140.133 E.181
G1 X99.609 Y140.133
G1 X103.774 Y135.968 E.181
G1 X103.241 Y135.968
G1 X100.372 Y138.836 E.12464
G1 X100.372 Y138.303
G1 X102.707 Y135.968 E.10147
G1 X102.174 Y135.968
G1 X100.372 Y137.77 E.07829
G1 X100.372 Y137.236
G1 X101.641 Y135.968 E.05512
G1 X101.107 Y135.968
G1 X99.942 Y137.133 E.05064
G1 X99.409 Y137.133
G1 X100.574 Y135.968 E.05064
G1 X100.041 Y135.968
G1 X99.172 Y136.837 E.03775
; WIPE_START
M204 S10000
G1 X100.041 Y135.968 E-.46685
G1 X100.574 Y135.968 E-.20264
G1 X100.406 Y136.136 E-.09051
; WIPE_END
G1 E-.04 F1800
G1 X100.041 Y139.168 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X99.172 Y140.036 E.03773
; WIPE_START
M204 S10000
G1 X100.041 Y139.168 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.371 Y142.035 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.163618
G1 F15000
G1 X100.415 Y142.169 E.00138
G1 X100.373 Y142.21 E.00057
G1 X100.239 Y142.167 E.00138
; OBJECT_ID: 214
; WIPE_START
G1 X100.373 Y142.21 E-.31476
G1 X100.415 Y142.169 E-.13042
G1 X100.371 Y142.035 E-.31481
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 192
M625
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G1 X94.964 Y143.538 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z2.4 F30000
G1 X81.345 Y142.345 Z2.4
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z2.4 F30000
G1 X95.153 Y143.945 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
M73 P72 R7
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X95.581 Y134.106 Z2.4 F30000
G1 X95.613 Y133.039 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X93.391 Y123.698 Z2.4 F30000
G1 X92.366 Y109.965 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.013 Y108.79 E.04315
G1 X92.777 Y109.554 E.03585
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X96.471 Y114.105 Z2.4 F30000
G1 X96.888 Y114.504 Z2.4
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X92.301 Y108.502 E.05665
G1 X93.353 Y109.554 E.04936
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X92.578 Y108.225 E.06453
G1 X93.907 Y109.554 E.05777
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 181
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 181
M624 AQAAAAAAAAA=
G1 X108.263 Y118.348 Z2.4 F30000
G1 X130.226 Y119.823 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X121.444 Y128.606 E.38163
G1 X104.884 Y112.045 E.71963
G1 X113.093 Y103.836 E.35674
G1 X113.666 Y103.263 E.02489
G1 X130.184 Y119.781 E.71779
; WIPE_START
M204 S10000
G1 X128.777 Y121.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.527 Y118.815 Z2.4 F30000
G1 X101.787 Y112.314 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X100.938 Y113.162 E.03687
G1 X99.821 Y112.045 E.04855
G1 X113.666 Y98.2 E.60164
G1 X135.289 Y119.823 E.93964
G1 X121.444 Y133.669 E.60164
G1 X102.083 Y114.308 E.84131
G1 X102.932 Y113.459 E.03687
G1 X101.829 Y112.356 E.04793
; WIPE_START
M204 S10000
G1 X100.938 Y113.162 E-.45657
G1 X100.373 Y112.598 E-.30343
; WIPE_END
G1 E-.04 F1800
G1 X107.849 Y114.135 Z2.4 F30000
G1 X134.863 Y119.69 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X121.311 Y133.242 E.5889
G1 X121.044 Y132.975
G1 X134.596 Y119.424 E.58889
G1 X134.329 Y119.157
G1 X120.778 Y132.709 E.58889
G1 X120.511 Y132.442
G1 X134.063 Y118.89 E.58889
G1 X133.796 Y118.624
G1 X120.244 Y132.176 E.58889
G1 X119.978 Y131.909
G1 X133.53 Y118.357 E.58889
G1 X133.263 Y118.09
G1 X119.711 Y131.642 E.58889
G1 X119.444 Y131.376
G1 X132.996 Y117.824 E.5889
G1 X132.73 Y117.557
G1 X130.492 Y119.795 E.09726
G1 X130.225 Y119.529
G1 X132.463 Y117.291 E.09726
G1 X132.196 Y117.024
G1 X129.958 Y119.262 E.09726
G1 X129.692 Y118.995
G1 X131.93 Y116.757 E.09726
G1 X131.663 Y116.491
G1 X129.425 Y118.729 E.09726
G1 X129.158 Y118.462
G1 X131.397 Y116.224 E.09726
G1 X131.13 Y115.957
G1 X128.892 Y118.196 E.09726
G1 X128.625 Y117.929
G1 X130.863 Y115.691 E.09726
G1 X130.597 Y115.424
G1 X128.358 Y117.662 E.09726
G1 X128.092 Y117.396
G1 X130.33 Y115.158 E.09726
G1 X130.063 Y114.891
G1 X127.825 Y117.129 E.09726
G1 X127.559 Y116.862
G1 X129.797 Y114.624 E.09726
G1 X129.53 Y114.358
G1 X127.292 Y116.596 E.09726
G1 X127.025 Y116.329
G1 X129.264 Y114.091 E.09726
G1 X128.997 Y113.824
G1 X126.759 Y116.063 E.09726
G1 X126.492 Y115.796
G1 X128.73 Y113.558 E.09726
G1 X128.464 Y113.291
G1 X126.225 Y115.529 E.09726
G1 X125.959 Y115.263
G1 X128.197 Y113.024 E.09726
G1 X127.93 Y112.758
G1 X125.692 Y114.996 E.09726
G1 X125.426 Y114.729
G1 X127.664 Y112.491 E.09726
G1 X127.397 Y112.225
G1 X125.159 Y114.463 E.09726
G1 X124.892 Y114.196
G1 X127.13 Y111.958 E.09726
G1 X126.864 Y111.691
G1 X124.626 Y113.93 E.09726
G1 X124.359 Y113.663
G1 X126.597 Y111.425 E.09726
G1 X126.331 Y111.158
G1 X124.092 Y113.396 E.09726
G1 X123.826 Y113.13
G1 X126.064 Y110.891 E.09726
G1 X125.797 Y110.625
G1 X123.559 Y112.863 E.09726
G1 X123.293 Y112.596
G1 X125.531 Y110.358 E.09726
G1 X125.264 Y110.092
G1 X123.026 Y112.33 E.09726
G1 X122.759 Y112.063
G1 X124.997 Y109.825 E.09726
G1 X124.731 Y109.558
G1 X122.493 Y111.796 E.09726
G1 X122.226 Y111.53
G1 X124.464 Y109.292 E.09726
G1 X124.198 Y109.025
G1 X121.959 Y111.263 E.09726
G1 X121.693 Y110.997
G1 X123.931 Y108.758 E.09726
G1 X123.664 Y108.492
G1 X121.426 Y110.73 E.09726
G1 X121.16 Y110.463
G1 X123.398 Y108.225 E.09726
G1 X123.131 Y107.959
G1 X120.893 Y110.197 E.09726
G1 X120.626 Y109.93
G1 X122.864 Y107.692 E.09726
G1 X122.598 Y107.425
G1 X120.36 Y109.663 E.09726
G1 X120.093 Y109.397
G1 X122.331 Y107.159 E.09726
G1 X122.065 Y106.892
G1 X119.826 Y109.13 E.09726
G1 X119.56 Y108.864
G1 X121.798 Y106.625 E.09726
G1 X121.531 Y106.359
G1 X119.293 Y108.597 E.09726
G1 X119.026 Y108.33
G1 X121.265 Y106.092 E.09726
G1 X120.998 Y105.826
G1 X118.76 Y108.064 E.09726
G1 X118.493 Y107.797
G1 X120.731 Y105.559 E.09726
G1 X120.465 Y105.292
G1 X118.227 Y107.53 E.09726
G1 X117.96 Y107.264
G1 X120.198 Y105.026 E.09726
G1 X119.932 Y104.759
G1 X117.693 Y106.997 E.09726
G1 X117.427 Y106.731
G1 X119.665 Y104.492 E.09726
G1 X119.398 Y104.226
G1 X117.16 Y106.464 E.09726
G1 X116.893 Y106.197
G1 X119.132 Y103.959 E.09726
G1 X118.865 Y103.692
G1 X116.627 Y105.931 E.09726
G1 X116.36 Y105.664
G1 X118.598 Y103.426 E.09726
G1 X118.332 Y103.159
G1 X116.094 Y105.397 E.09726
G1 X115.827 Y105.131
G1 X118.065 Y102.893 E.09726
G1 X117.798 Y102.626
G1 X115.56 Y104.864 E.09726
G1 X115.294 Y104.597
G1 X117.532 Y102.359 E.09726
G1 X117.265 Y102.093
G1 X115.027 Y104.331 E.09726
G1 X114.76 Y104.064
G1 X116.999 Y101.826 E.09726
G1 X116.732 Y101.559
G1 X114.494 Y103.798 E.09726
G1 X114.227 Y103.531
G1 X116.465 Y101.293 E.09726
G1 X116.199 Y101.026
G1 X113.961 Y103.264 E.09726
G1 X113.694 Y102.998
G1 X115.932 Y100.76 E.09726
; WIPE_START
M204 S10000
G1 X114.518 Y102.174 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.427 Y109.564 Z2.4 F30000
G1 X121.416 Y128.871 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X119.178 Y131.109 E.09726
G1 X118.911 Y130.842
G1 X121.149 Y128.604 E.09726
G1 X120.883 Y128.338
G1 X118.645 Y130.576 E.09726
G1 X118.378 Y130.309
G1 X120.616 Y128.071 E.09726
G1 X120.349 Y127.804
G1 X118.111 Y130.043 E.09726
G1 X117.845 Y129.776
G1 X120.083 Y127.538 E.09726
G1 X119.816 Y127.271
G1 X117.578 Y129.509 E.09726
G1 X117.311 Y129.243
G1 X119.55 Y127.004 E.09726
G1 X119.283 Y126.738
G1 X117.045 Y128.976 E.09726
G1 X116.778 Y128.709
G1 X119.016 Y126.471 E.09726
M73 P73 R7
G1 X118.75 Y126.205
G1 X116.512 Y128.443 E.09726
G1 X116.245 Y128.176
G1 X118.483 Y125.938 E.09726
G1 X118.216 Y125.671
G1 X115.978 Y127.91 E.09726
G1 X115.712 Y127.643
G1 X117.95 Y125.405 E.09726
G1 X117.683 Y125.138
G1 X115.445 Y127.376 E.09726
G1 X115.178 Y127.11
G1 X117.417 Y124.871 E.09726
G1 X117.15 Y124.605
G1 X114.912 Y126.843 E.09726
G1 X114.645 Y126.576
G1 X116.883 Y124.338 E.09726
G1 X116.617 Y124.072
G1 X114.378 Y126.31 E.09726
G1 X114.112 Y126.043
G1 X116.35 Y123.805 E.09726
G1 X116.083 Y123.538
G1 X113.845 Y125.776 E.09726
G1 X113.579 Y125.51
G1 X115.817 Y123.272 E.09726
G1 X115.55 Y123.005
G1 X113.312 Y125.243 E.09726
G1 X113.045 Y124.977
G1 X115.284 Y122.738 E.09726
G1 X115.017 Y122.472
G1 X112.779 Y124.71 E.09726
G1 X112.512 Y124.443
G1 X114.75 Y122.205 E.09726
G1 X114.484 Y121.939
G1 X112.245 Y124.177 E.09726
G1 X111.979 Y123.91
G1 X114.217 Y121.672 E.09726
G1 X113.95 Y121.405
G1 X111.712 Y123.643 E.09726
G1 X111.446 Y123.377
G1 X113.684 Y121.139 E.09726
G1 X113.417 Y120.872
G1 X111.179 Y123.11 E.09726
G1 X110.912 Y122.844
G1 X113.15 Y120.605 E.09726
G1 X112.884 Y120.339
G1 X110.646 Y122.577 E.09726
G1 X110.379 Y122.31
G1 X112.617 Y120.072 E.09726
G1 X112.351 Y119.806
G1 X110.112 Y122.044 E.09726
G1 X109.846 Y121.777
G1 X112.084 Y119.539 E.09726
G1 X111.817 Y119.272
G1 X109.579 Y121.51 E.09726
G1 X109.313 Y121.244
G1 X111.551 Y119.006 E.09726
G1 X111.284 Y118.739
G1 X109.046 Y120.977 E.09726
G1 X108.779 Y120.711
G1 X111.017 Y118.472 E.09726
G1 X110.751 Y118.206
G1 X108.513 Y120.444 E.09726
G1 X108.246 Y120.177
G1 X110.484 Y117.939 E.09726
G1 X110.218 Y117.672
G1 X107.979 Y119.911 E.09726
G1 X107.713 Y119.644
G1 X109.951 Y117.406 E.09726
G1 X109.684 Y117.139
G1 X107.446 Y119.377 E.09726
G1 X107.18 Y119.111
G1 X109.418 Y116.873 E.09726
G1 X109.151 Y116.606
G1 X106.913 Y118.844 E.09726
G1 X106.646 Y118.578
G1 X108.884 Y116.339 E.09726
G1 X108.618 Y116.073
G1 X106.38 Y118.311 E.09726
G1 X106.113 Y118.044
G1 X108.351 Y115.806 E.09726
G1 X108.085 Y115.539
G1 X105.846 Y117.778 E.09726
G1 X105.58 Y117.511
G1 X107.818 Y115.273 E.09726
G1 X107.551 Y115.006
G1 X105.313 Y117.244 E.09726
G1 X105.046 Y116.978
G1 X107.285 Y114.74 E.09726
G1 X107.018 Y114.473
G1 X104.78 Y116.711 E.09726
G1 X104.513 Y116.444
G1 X106.751 Y114.206 E.09726
G1 X106.485 Y113.94
G1 X104.247 Y116.178 E.09726
G1 X103.98 Y115.911
G1 X106.218 Y113.673 E.09726
G1 X105.952 Y113.406
G1 X103.713 Y115.645 E.09726
G1 X103.447 Y115.378
G1 X105.685 Y113.14 E.09726
G1 X105.418 Y112.873
G1 X103.18 Y115.111 E.09726
G1 X102.913 Y114.845
G1 X105.152 Y112.607 E.09726
G1 X104.885 Y112.34
G1 X102.647 Y114.578 E.09726
G1 X102.38 Y114.311
G1 X104.618 Y112.073 E.09726
; WIPE_START
M204 S10000
G1 X103.204 Y113.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.962 Y113.196 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X115.665 Y100.493 E.55202
G1 X115.399 Y100.226
G1 X102.695 Y112.93 E.55202
G1 X102.429 Y112.663
G1 X115.132 Y99.96 E.55202
G1 X114.866 Y99.693
G1 X102.162 Y112.396 E.55202
G1 X101.896 Y112.13
G1 X114.599 Y99.426 E.55202
G1 X114.332 Y99.16
G1 X100.78 Y112.712 E.58889
G1 X100.514 Y112.445
G1 X114.066 Y98.893 E.58889
G1 X113.799 Y98.627
G1 X100.247 Y112.178 E.58889
; WIPE_START
M204 S10000
G1 X101.661 Y110.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.941 Y113.057 Z2.4 F30000
G1 X130.566 Y119.869 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.210476
G1 F15000
G1 X121.49 Y128.945 E.17524
; WIPE_START
G1 X122.904 Y127.531 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.21 Y120.39 Z2.4 F30000
G1 X113.62 Y102.924 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.210561
G1 F15000
G1 X104.544 Y111.999 E.17533
; WIPE_START
G1 X105.959 Y110.585 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.781 Y112.015 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0959392
G1 F15000
G1 X100.919 Y112.877 E.00527
; OBJECT_ID: 247
; WIPE_START
G1 X101.781 Y112.015 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 181
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X108.131 Y107.781 Z2.4 F30000
G1 X130.333 Y92.974 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X124.293 Y99.014 E.28335
G1 X114.011 Y88.732 E.48238
G1 X120.051 Y82.692 E.28335
G1 X130.291 Y92.932 E.48039
G1 X130.909 Y92.974 F30000
G1 F8843.478
G1 X124.293 Y99.59 E.31035
G1 X113.435 Y88.732 E.50939
G1 X120.051 Y82.116 E.31035
G1 X130.867 Y92.932 E.5074
; WIPE_START
G1 X129.461 Y94.355 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.724 Y92.974 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X124.293 Y105.405 E.54018
G1 X107.62 Y88.732 E.72455
G1 X120.051 Y76.301 E.54018
G1 X136.682 Y92.932 E.7227
M204 S10000
G1 X136.106 Y92.65 F30000
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X123.969 Y104.787 E.52744
G1 X123.702 Y104.521
G1 X135.84 Y92.383 E.52744
G1 X135.573 Y92.116
G1 X123.435 Y104.254 E.52744
G1 X123.169 Y103.987
G1 X135.306 Y91.85 E.52744
G1 X135.04 Y91.583
G1 X122.902 Y103.721 E.52744
G1 X122.636 Y103.454
G1 X134.773 Y91.316 E.52744
G1 X134.507 Y91.05
G1 X122.369 Y103.187 E.52744
G1 X122.102 Y102.921
G1 X134.24 Y90.783 E.52744
G1 X133.973 Y90.517
G1 X121.836 Y102.654 E.52744
G1 X121.569 Y102.388
G1 X124.173 Y99.784 E.11314
G1 X123.906 Y99.517
G1 X121.302 Y102.121 E.11314
G1 X121.036 Y101.854
G1 X123.639 Y99.251 E.11314
G1 X123.373 Y98.984
G1 X120.769 Y101.588 E.11314
G1 X120.502 Y101.321
G1 X123.106 Y98.717 E.11314
G1 X122.84 Y98.451
G1 X120.236 Y101.054 E.11314
G1 X119.969 Y100.788
G1 X122.573 Y98.184 E.11314
G1 X122.306 Y97.917
G1 X119.703 Y100.521 E.11314
G1 X119.436 Y100.255
G1 X122.04 Y97.651 E.11314
G1 X121.773 Y97.384
G1 X119.169 Y99.988 E.11314
G1 X118.903 Y99.721
G1 X121.506 Y97.118 E.11314
G1 X121.24 Y96.851
G1 X118.636 Y99.455 E.11314
G1 X118.369 Y99.188
G1 X120.973 Y96.584 E.11314
G1 X120.706 Y96.318
G1 X118.103 Y98.921 E.11314
G1 X117.836 Y98.655
G1 X120.44 Y96.051 E.11314
G1 X120.173 Y95.784
G1 X117.57 Y98.388 E.11314
G1 X117.303 Y98.121
G1 X119.907 Y95.518 E.11314
G1 X119.64 Y95.251
G1 X117.036 Y97.855 E.11314
G1 X116.77 Y97.588
G1 X119.373 Y94.985 E.11314
G1 X119.107 Y94.718
G1 X116.503 Y97.322 E.11314
G1 X116.236 Y97.055
G1 X118.84 Y94.451 E.11314
G1 X118.573 Y94.185
G1 X115.97 Y96.788 E.11314
G1 X115.703 Y96.522
G1 X118.307 Y93.918 E.11314
G1 X118.04 Y93.651
G1 X115.437 Y96.255 E.11314
G1 X115.17 Y95.988
G1 X117.774 Y93.385 E.11314
G1 X117.507 Y93.118
G1 X114.903 Y95.722 E.11314
G1 X114.637 Y95.455
G1 X117.24 Y92.852 E.11314
G1 X116.974 Y92.585
G1 X114.37 Y95.189 E.11314
G1 X114.103 Y94.922
G1 X116.707 Y92.318 E.11314
G1 X116.44 Y92.052
G1 X113.837 Y94.655 E.11314
G1 X113.57 Y94.389
G1 X116.174 Y91.785 E.11314
G1 X115.907 Y91.518
G1 X113.303 Y94.122 E.11314
G1 X113.037 Y93.855
G1 X115.641 Y91.252 E.11314
G1 X115.374 Y90.985
G1 X112.77 Y93.589 E.11314
G1 X112.504 Y93.322
G1 X115.107 Y90.719 E.11314
G1 X114.841 Y90.452
G1 X112.237 Y93.056 E.11314
G1 X111.97 Y92.789
G1 X114.574 Y90.185 E.11314
G1 X114.307 Y89.919
G1 X111.704 Y92.522 E.11314
G1 X111.437 Y92.256
G1 X114.041 Y89.652 E.11314
G1 X113.774 Y89.385
G1 X111.17 Y91.989 E.11314
G1 X110.904 Y91.722
G1 X113.508 Y89.119 E.11314
G1 X113.241 Y88.852
G1 X110.637 Y91.456 E.11314
; WIPE_START
M204 S10000
G1 X112.051 Y90.042 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.684 Y90.115 Z2.4 F30000
G1 X133.707 Y90.25 Z2.4
G1 Z2
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X131.103 Y92.854 E.11314
G1 X130.836 Y92.587
G1 X133.44 Y89.983 E.11314
G1 X133.173 Y89.717
G1 X130.57 Y92.32 E.11314
G1 X130.303 Y92.054
G1 X132.907 Y89.45 E.11314
G1 X132.64 Y89.183
G1 X130.036 Y91.787 E.11314
G1 X129.77 Y91.52
G1 X132.373 Y88.917 E.11314
G1 X132.107 Y88.65
G1 X129.503 Y91.254 E.11314
G1 X129.237 Y90.987
G1 X131.84 Y88.384 E.11314
G1 X131.574 Y88.117
G1 X128.97 Y90.721 E.11314
G1 X128.703 Y90.454
G1 X131.307 Y87.85 E.11314
G1 X131.04 Y87.584
G1 X128.437 Y90.187 E.11314
G1 X128.17 Y89.921
G1 X130.774 Y87.317 E.11314
G1 X130.507 Y87.05
G1 X127.903 Y89.654 E.11314
G1 X127.637 Y89.387
G1 X130.24 Y86.784 E.11314
M73 P74 R7
G1 X129.974 Y86.517
G1 X127.37 Y89.121 E.11314
G1 X127.104 Y88.854
G1 X129.707 Y86.25 E.11314
G1 X129.441 Y85.984
G1 X126.837 Y88.588 E.11314
G1 X126.57 Y88.321
G1 X129.174 Y85.717 E.11314
G1 X128.907 Y85.451
G1 X126.304 Y88.054 E.11314
G1 X126.037 Y87.788
G1 X128.641 Y85.184 E.11314
G1 X128.374 Y84.917
G1 X125.77 Y87.521 E.11314
G1 X125.504 Y87.254
G1 X128.107 Y84.651 E.11314
G1 X127.841 Y84.384
G1 X125.237 Y86.988 E.11314
G1 X124.971 Y86.721
G1 X127.574 Y84.117 E.11314
G1 X127.308 Y83.851
G1 X124.704 Y86.454 E.11314
G1 X124.437 Y86.188
G1 X127.041 Y83.584 E.11314
G1 X126.774 Y83.318
G1 X124.171 Y85.921 E.11314
G1 X123.904 Y85.655
G1 X126.508 Y83.051 E.11314
G1 X126.241 Y82.784
G1 X123.637 Y85.388 E.11314
G1 X123.371 Y85.121
G1 X125.974 Y82.518 E.11314
G1 X125.708 Y82.251
G1 X123.104 Y84.855 E.11314
G1 X122.837 Y84.588
G1 X125.441 Y81.984 E.11314
G1 X125.175 Y81.718
G1 X122.571 Y84.321 E.11314
G1 X122.304 Y84.055
G1 X124.908 Y81.451 E.11314
G1 X124.641 Y81.185
G1 X122.038 Y83.788 E.11314
G1 X121.771 Y83.522
G1 X124.375 Y80.918 E.11314
G1 X124.108 Y80.651
G1 X121.504 Y83.255 E.11314
G1 X121.238 Y82.988
G1 X123.841 Y80.385 E.11314
G1 X123.575 Y80.118
G1 X120.971 Y82.722 E.11314
G1 X120.704 Y82.455
G1 X123.308 Y79.851 E.11314
G1 X123.041 Y79.585
G1 X120.438 Y82.188 E.11314
G1 X120.171 Y81.922
G1 X122.775 Y79.318 E.11314
G1 X122.508 Y79.052
G1 X110.371 Y91.189 E.52744
G1 X110.104 Y90.923
G1 X122.242 Y78.785 E.52744
G1 X121.975 Y78.518
G1 X109.837 Y90.656 E.52744
G1 X109.571 Y90.389
G1 X121.708 Y78.252 E.52744
G1 X121.442 Y77.985
G1 X109.304 Y90.123 E.52744
G1 X109.037 Y89.856
G1 X121.175 Y77.718 E.52744
G1 X120.908 Y77.452
G1 X108.771 Y89.589 E.52744
G1 X108.504 Y89.323
G1 X120.642 Y77.185 E.52744
G1 X120.375 Y76.918
G1 X108.238 Y89.056 E.52744
; WIPE_START
M204 S10000
G1 X109.652 Y87.642 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.142 Y89.109 Z2.4 F30000
G1 X136.355 Y92.872 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.332212
G1 F12444.193
G1 X124.191 Y105.036 E.40553
; WIPE_START
G1 X125.605 Y103.622 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.092 Y96.141 Z2.4 F30000
G1 X120.153 Y76.67 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.332127
G1 F12447.846
G1 X107.989 Y88.834 E.40542
; WIPE_START
G1 X109.403 Y87.42 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.734 Y85.297 Z2.4 F30000
G1 X118.428 Y84.806 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X117.277 Y85.958 E.05401
G1 X127.067 Y95.748 E.45927
G1 X129.841 Y92.974 E.13012
G1 X127.824 Y90.958 E.0946
G1 X122.277 Y96.505 E.26024
G1 X119.398 Y93.627 E.13504
G1 X124.946 Y88.079 E.26024
G1 X122.067 Y85.201 E.13504
G1 X116.52 Y90.748 E.26024
G1 X115.368 Y89.597 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X116.52 Y90.748 E-.61876
G1 X116.783 Y90.485 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X110.6 Y94.961 Z2.4 F30000
G1 X100.345 Y102.386 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.301 Y102.359 E.00172
G3 X101.494 Y97.314 I1.361 J-2.341 E.22934
G3 X103.305 Y97.864 I.176 J2.678 E.06415
G3 X100.618 Y102.516 I-1.642 J2.153 E.25923
G1 X100.399 Y102.412 E.00805
G1 X100.482 Y101.996 F30000
G1 F8843.478
G1 X100.255 Y101.839 E.00915
G3 X99.403 Y99.55 I1.399 J-1.824 E.08539
G3 X101.521 Y97.721 I2.251 J.465 E.0998
G3 X100.535 Y102.023 I.134 J2.295 E.28273
M204 S250
G1 X100.701 Y101.666 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.546 Y98.112 I.962 J-1.649 E.14969
G3 X102.385 Y98.25 I.126 J1.852 E.02636
G3 X100.754 Y101.695 I-.722 J1.767 E.19062
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.1176
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.781 Y100.371 E-.14855
G1 X99.75 Y100.072 E-.11398
; WIPE_END
G1 E-.04 F1800
G1 X97.209 Y93.613 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.197 Y93.644 E.00112
G3 X94.423 Y90.243 I-2.613 J-.7 E.39411
G3 X97.24 Y93.455 I.171 J2.691 E.16358
G1 X97.22 Y93.554 E.00334
G1 X96.81 Y93.533 F30000
G1 F8843.478
G1 X96.813 Y93.542 E.0003
G3 X94.45 Y90.65 I-2.221 J-.596 E.33482
G3 X95.735 Y90.949 I.129 J2.349 E.04437
G3 X96.851 Y93.378 I-1.143 J1.996 E.0946
G1 X96.825 Y93.475 E.00335
M204 S250
G1 X96.436 Y93.441 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.475 Y91.041 I-1.844 J-.495 E.25742
G3 X95.314 Y91.179 I.126 J1.852 E.02636
G3 X96.45 Y93.382 I-.722 J1.767 E.0829
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11782
G1 X96.238 Y93.899 E-.09498
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09497
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.134 Y94.77 E-.0724
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z2.4 F30000
G1 X108.713 Y98.601 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X104.948 Y94.836 E.41987
G1 X108.67 Y98.559 E.17462
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X105.236 Y94.548 E.43338
G1 X109.246 Y98.559 E.18813
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X105.513 Y94.271 E.41349
G1 X109.8 Y98.559 E.18631
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.139 Y96.52 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.987 Y95.368 E.05401
G1 X103.055 Y97.301 E.09066
G3 X104.239 Y98.387 I-1.415 J2.732 E.05394
; WIPE_START
G1 X103.818 Y97.851 E-.25897
G1 X103.055 Y97.301 E-.3577
G1 X103.321 Y97.034 E-.14333
; WIPE_END
G1 E-.04 F1800
G1 X99.54 Y103.664 Z2.4 F30000
G1 X98.734 Y105.075 Z2.4
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X99.886 Y106.227 E.05401
G1 X107.866 Y98.247 E.37435
G1 X108.22 Y98.601 E.01662
G1 X107.109 Y99.712 E.05214
G1 X94.886 Y87.49 E.57338
G1 X95.998 Y86.379 E.05214
G1 X96.352 Y86.733 E.01662
G1 X88.372 Y94.713 E.37435
G1 X88.018 Y94.358 E.01662
G1 X89.129 Y93.247 E.05214
G1 X101.352 Y105.469 E.57338
G1 X104.23 Y102.591 E.13504
G1 X103.818 Y102.179 E.01931
; WIPE_START
G1 X104.23 Y102.591 E-.22126
G1 X103.228 Y103.593 E-.53874
; WIPE_END
G1 E-.04 F1800
G1 X96.262 Y100.472 Z2.4 F30000
G1 X92.402 Y98.742 Z2.4
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X91.25 Y97.591 E.05401
G1 X93.183 Y95.658 E.09066
G2 X96.747 Y95.108 I1.386 J-2.838 E.12732
G1 X99.49 Y97.851 E.12868
G2 X98.94 Y101.415 I2.247 J2.172 E.12753
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X99.23 Y89.611 E.13504
G1 X97.298 Y91.544 E.09066
G2 X96.211 Y90.359 I-3.26 J1.899 E.05373
; WIPE_START
G1 X96.747 Y90.78 E-.25895
G1 X97.298 Y91.544 E-.35772
G1 X97.564 Y91.277 E-.14333
; WIPE_END
G1 E-.04 F1800
G1 X90.856 Y91.52 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.05401
G1 X92.419 Y90.78 E.01931
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X92.008 Y90.368 E-.22126
G1 X91.005 Y91.371 E-.53874
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 11/30
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M106 S239.7
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z2.4 I-1.213 J.092 P1  F30000
G1 X94.964 Y143.538 Z2.4
M73 P74 R6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z2.6 F30000
G1 X81.345 Y142.345 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z2.6 F30000
G1 X95.153 Y143.945 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 11 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer11 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z2.6 F30000
G1 X92.366 Y109.965 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
M73 P75 R6
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z2.6 F30000
G1 X95.613 Y133.039 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z2.6 F30000
G1 X96.888 Y114.504 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X95.596 Y113.211 E.03888
G1 X96.467 Y114.083 E.04087
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X95.873 Y112.934 E.02397
G1 X96.467 Y113.528 E.02581
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231724
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231709
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z2.6 F30000
G1 X145.197 Y77.807 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z2.6 F30000
G1 X112.992 Y88.732 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.424 Y89.541 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.576 Y90.692 E.05401
G1 X122.011 Y85.257 E.25498
G1 X124.89 Y88.135 E.13504
G1 X119.454 Y93.571 E.25498
G1 X122.333 Y96.449 E.13504
G1 X127.768 Y91.014 E.25498
G1 X129.729 Y92.974 E.09197
G1 X127.011 Y95.692 E.12749
G1 X117.333 Y86.014 E.45401
G1 X118.484 Y84.862 E.05401
G1 X130.104 Y93.147 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.413136
G1 F9724.059
G1 X124.49 Y98.763 E.23955
; LINE_WIDTH: 0.435795
G1 F9163.22
G1 X124.391 Y98.812 E.00353
; LINE_WIDTH: 0.466015
G1 F8508.73
G1 X124.293 Y98.862 E.0038
G1 X124.097 Y98.763 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X114.262 Y88.928 E.41958
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X114.212 Y88.83 E.00353
; LINE_WIDTH: 0.466027
G1 F8508.487
G1 X114.163 Y88.732 E.0038
G1 X114.262 Y88.535 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X119.854 Y82.943 E.23858
; LINE_WIDTH: 0.435798
G1 F9163.162
G1 X119.952 Y82.893 E.00353
; LINE_WIDTH: 0.466021
G1 F8508.614
G1 X120.051 Y82.843 E.0038
G1 X120.247 Y82.943 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X130.082 Y92.778 E.41958
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X130.132 Y92.876 E.00353
; LINE_WIDTH: 0.469656
G1 F8436.134
G1 X130.181 Y92.974 E.00383
G1 X130.128 Y93.092 E.0045
G1 X113.606 Y88.732 F30000
; LINE_WIDTH: 0.48114
G1 F8215.051
G1 X113.803 Y88.961 E.01079
; LINE_WIDTH: 0.413612
G1 F9711.563
G1 X114 Y89.19 E.00913
G1 X123.835 Y99.024 E.42013
; LINE_WIDTH: 0.435795
G1 F9163.22
G1 X124.064 Y99.222 E.00967
; LINE_WIDTH: 0.466015
G1 F8508.725
G1 X124.293 Y99.419 E.01042
G1 X124.752 Y99.024 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X130.344 Y93.432 E.23858
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X130.541 Y93.203 E.00968
; LINE_WIDTH: 0.466027
G1 F8508.494
G1 X130.738 Y92.974 E.01042
G1 X130.344 Y92.516 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X120.509 Y82.681 E.41958
; LINE_WIDTH: 0.435798
G1 F9163.162
G1 X120.28 Y82.484 E.00967
; LINE_WIDTH: 0.466021
G1 F8508.608
G1 X120.051 Y82.287 E.01042
G1 X119.592 Y82.681 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X114 Y88.273 E.23858
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X113.823 Y88.48 E.00871
; LINE_WIDTH: 0.48114
G1 F8215.051
G1 X113.645 Y88.686 E.00972
; OBJECT_ID: 258
; WIPE_START
G1 X113.823 Y88.48 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X108.511 Y93.961 Z2.6 F30000
G1 X100.345 Y102.386 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.3 Y102.361 E.00173
G3 X99.007 Y99.458 I1.357 J-2.344 E.11268
G3 X101.508 Y97.314 I2.648 J.558 E.11748
G3 X100.617 Y102.519 I.149 J2.704 E.32253
G1 X100.399 Y102.413 E.00805
G1 X100.481 Y101.996 F30000
G1 F8843.478
G1 X100.255 Y101.838 E.00914
G3 X101.534 Y97.72 I1.407 J-1.821 E.18535
G3 X102.806 Y98.02 I.115 J2.353 E.04393
G3 X100.535 Y102.023 I-1.144 J1.997 E.23921
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.56 Y98.111 I.961 J-1.648 E.15008
G3 X102.385 Y98.25 I.112 J1.853 E.02595
G3 X100.754 Y101.694 I-.722 J1.766 E.19054
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.11759
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.779 Y100.357 E-.05901
G1 X99.75 Y100.073 E-.10858
; WIPE_END
G1 E-.04 F1800
G1 X97.208 Y93.618 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.207 Y93.647 E.00096
G3 X94.437 Y90.242 I-2.616 J-.701 E.3947
G3 X96.234 Y90.793 I.162 J2.679 E.0637
G3 X97.253 Y93.444 I-1.643 J2.153 E.09918
G1 X97.223 Y93.56 E.00398
G1 X96.808 Y93.539 F30000
G1 F8843.478
G1 X96.804 Y93.539 E.00016
G3 X94.463 Y90.649 I-2.22 J-.595 E.33536
G3 X96.832 Y92.466 I.132 J2.279 E.10793
G3 X96.862 Y93.244 I-2.248 J.478 E.02596
G1 X96.819 Y93.48 E.00794
M204 S250
G1 X96.435 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.489 Y91.04 I-1.843 J-.495 E.25775
G3 X95.314 Y91.179 I.112 J1.853 E.02594
G3 X96.449 Y93.382 I-.722 J1.766 E.08288
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11779
G1 X96.238 Y93.899 E-.09496
G1 X96.099 Y94.107 E-.09496
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09494
G1 X95.539 Y94.599 E-.09495
G1 X95.314 Y94.709 E-.09498
G1 X95.134 Y94.77 E-.07243
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z2.6 F30000
G1 X108.713 Y98.601 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X104.476 Y94.365 E.39776
G1 X108.67 Y98.559 E.19674
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X104.764 Y94.077 E.41126
G1 X109.246 Y98.559 E.21024
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X105.041 Y93.8 E.393
G1 X109.8 Y98.559 E.20679
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.818 Y102.179 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.23 Y102.591 E.01932
G1 X101.352 Y105.469 E.13504
G1 X89.129 Y93.247 E.57338
G1 X88.018 Y94.358 E.05214
G1 X88.372 Y94.713 E.01662
G1 X96.352 Y86.733 E.37435
G1 X95.998 Y86.379 E.01662
G1 X94.886 Y87.49 E.05214
G1 X107.109 Y99.712 E.57338
G1 X108.22 Y98.601 E.05214
G1 X107.866 Y98.247 E.01662
G1 X99.886 Y106.227 E.37435
G1 X98.734 Y105.075 E.05401
G1 X92.402 Y98.742 F30000
G1 F8843.478
G1 X91.25 Y97.591 E.05401
G1 X93.183 Y95.659 E.09066
G3 X91.998 Y94.572 I1.415 J-2.732 E.05394
; WIPE_START
G1 X92.419 Y95.108 E-.25894
G1 X93.183 Y95.659 E-.35773
G1 X92.916 Y95.925 E-.14333
; WIPE_END
G1 E-.04 F1800
G1 X92.419 Y90.78 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F8843.478
G1 X92.008 Y90.368 E.01931
G1 X90.856 Y91.52 E.05401
; WIPE_START
G1 X92.008 Y90.368 E-.61876
G1 X92.27 Y90.631 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X99.902 Y90.755 Z2.6 F30000
G1 X100.382 Y90.763 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F8843.478
G1 X99.23 Y89.611 E.05401
G1 X97.298 Y91.544 E.09066
G3 X96.747 Y95.108 I-2.785 J1.395 E.12759
G1 X99.49 Y97.851 E.12869
G2 X98.94 Y101.415 I2.25 J2.172 E.12751
M73 P76 R6
G1 X97.007 Y103.348 E.09066
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X104.987 Y95.368 E.13504
G1 X103.055 Y97.301 E.09066
G3 X104.239 Y98.387 I-1.415 J2.732 E.05394
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X103.818 Y97.851 E-.25891
G1 X103.055 Y97.301 E-.35776
G1 X103.321 Y97.034 E-.14333
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 12/30
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
M106 S237.15
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z2.6 I-1.198 J-.215 P1  F30000
G1 X94.964 Y143.538 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z2.8 F30000
G1 X81.345 Y142.345 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z2.8 F30000
G1 X95.153 Y143.945 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 12 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer12 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z2.8 F30000
G1 X92.366 Y109.965 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z2.8 F30000
G1 X95.613 Y133.039 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z2.8 F30000
G1 X96.888 Y114.504 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z2.8 F30000
G1 X145.197 Y77.807 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z2.8 F30000
G1 X112.992 Y88.732 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.484 Y84.862 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X117.333 Y86.014 E.05401
G1 X127.011 Y95.692 E.45401
G1 X129.729 Y92.974 E.12749
G1 X127.768 Y91.014 E.09197
G1 X122.333 Y96.449 E.25498
G1 X119.454 Y93.571 E.13504
G1 X124.89 Y88.135 E.25498
G1 X122.011 Y85.257 E.13504
G1 X116.576 Y90.692 E.25498
G1 X115.424 Y89.541 E.05401
G1 X130.104 Y93.147 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.413136
G1 F9724.059
M73 P77 R6
G1 X124.49 Y98.763 E.23955
; LINE_WIDTH: 0.435795
G1 F9163.22
G1 X124.391 Y98.812 E.00353
; LINE_WIDTH: 0.466015
G1 F8508.73
G1 X124.293 Y98.862 E.0038
G1 X124.097 Y98.763 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X114.262 Y88.928 E.41958
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X114.212 Y88.83 E.00353
; LINE_WIDTH: 0.466027
G1 F8508.487
G1 X114.163 Y88.732 E.0038
G1 X114.262 Y88.535 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X119.854 Y82.943 E.23858
; LINE_WIDTH: 0.435798
G1 F9163.162
G1 X119.952 Y82.893 E.00353
; LINE_WIDTH: 0.466021
G1 F8508.614
G1 X120.051 Y82.843 E.0038
G1 X120.247 Y82.943 E.00759
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X130.082 Y92.778 E.41958
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X130.132 Y92.876 E.00353
; LINE_WIDTH: 0.469656
G1 F8436.134
G1 X130.181 Y92.974 E.00383
G1 X130.128 Y93.092 E.0045
G1 X113.606 Y88.732 F30000
; LINE_WIDTH: 0.48114
G1 F8215.051
G1 X113.803 Y88.961 E.01079
; LINE_WIDTH: 0.413612
G1 F9711.563
G1 X114 Y89.19 E.00913
G1 X123.835 Y99.024 E.42013
; LINE_WIDTH: 0.435795
G1 F9163.22
G1 X124.064 Y99.222 E.00967
; LINE_WIDTH: 0.466015
G1 F8508.725
G1 X124.293 Y99.419 E.01042
G1 X124.752 Y99.024 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X130.344 Y93.432 E.23858
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X130.541 Y93.203 E.00968
; LINE_WIDTH: 0.466027
G1 F8508.494
G1 X130.738 Y92.974 E.01042
G1 X130.344 Y92.516 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X120.509 Y82.681 E.41958
; LINE_WIDTH: 0.435798
G1 F9163.162
G1 X120.28 Y82.484 E.00967
; LINE_WIDTH: 0.466021
G1 F8508.608
G1 X120.051 Y82.287 E.01042
G1 X119.592 Y82.681 E.02084
; LINE_WIDTH: 0.41313
G1 F9724.212
G1 X114 Y88.273 E.23858
; LINE_WIDTH: 0.4358
G1 F9163.103
G1 X113.823 Y88.48 E.00871
; LINE_WIDTH: 0.48114
G1 F8215.051
G1 X113.645 Y88.686 E.00972
; OBJECT_ID: 258
; WIPE_START
G1 X113.823 Y88.48 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X108.511 Y93.961 Z2.8 F30000
G1 X100.346 Y102.386 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.301 Y102.359 E.00173
G3 X101.521 Y97.313 I1.361 J-2.342 E.23026
G3 X103.305 Y97.864 I.149 J2.68 E.06326
G3 X100.618 Y102.516 I-1.643 J2.153 E.25922
G1 X100.4 Y102.412 E.00803
G1 X100.526 Y102.021 F30000
G1 F8843.478
G1 X100.506 Y102.004 E.00087
G3 X101.548 Y97.719 I1.156 J-1.988 E.19566
G3 X102.806 Y98.02 I.1 J2.357 E.04348
G3 X100.775 Y102.137 I-1.144 J1.995 E.23016
G1 X100.58 Y102.047 E.00714
M204 S250
G1 X100.702 Y101.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X101.573 Y98.11 I.961 J-1.649 E.15053
G3 X102.385 Y98.25 I.098 J1.855 E.02553
G3 X100.754 Y101.694 I-.723 J1.766 E.19053
; WIPE_START
M204 S10000
G1 X100.491 Y101.531 E-.1176
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.776 Y100.344 E-.06413
G1 X99.75 Y100.073 E-.10346
; WIPE_END
G1 E-.04 F1800
G1 X97.207 Y93.624 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.207 Y93.647 E.00078
G3 X94.45 Y90.242 I-2.616 J-.701 E.39516
G3 X96.234 Y90.793 I.148 J2.68 E.06325
G3 X97.255 Y93.431 I-1.643 J2.153 E.09872
G1 X97.221 Y93.565 E.00461
G1 X96.804 Y93.539 F30000
G1 F8843.478
G3 X94.477 Y90.648 I-2.223 J-.593 E.33625
G3 X96.846 Y93.35 I.116 J2.288 E.13702
G3 X96.819 Y93.481 I-2.265 J-.404 E.00445
M204 S250
G1 X96.435 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.502 Y91.039 I-1.843 J-.495 E.25819
G3 X95.314 Y91.179 I.098 J1.855 E.02553
G3 X96.449 Y93.382 I-.723 J1.766 E.08287
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.1178
G1 X96.238 Y93.899 E-.09496
G1 X96.099 Y94.107 E-.09497
G1 X95.934 Y94.295 E-.09497
G1 X95.746 Y94.46 E-.09497
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09498
G1 X95.132 Y94.765 E-.07242
; WIPE_END
G1 E-.04 F1800
G1 X102.477 Y96.84 Z2.8 F30000
G1 X108.713 Y98.601 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X104.005 Y93.893 E.37564
G1 X108.67 Y98.559 E.21885
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X104.293 Y93.606 E.38915
G1 X109.246 Y98.559 E.23236
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X104.57 Y93.328 E.37252
G1 X109.8 Y98.559 E.22728
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.818 Y102.179 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X104.23 Y102.591 E.01931
G1 X103.079 Y103.742 E.05401
G1 X102.673 Y104.128 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.397067
G1 F3000;_EXTRUDE_SET_SPEED
G1 X100.353 Y106.448 E.09469
G1 X100.24 Y106.522 E.00389
G1 X100.128 Y106.448 E.00389
G1 X88.151 Y94.471 E.4888
G1 X88.077 Y94.358 E.00389
G1 X88.151 Y94.246 E.00389
G1 X90.428 Y91.968 E.09296
; Slow Down End
G1 X90.856 Y91.52 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X92.008 Y90.368 E.05401
G1 X92.419 Y90.78 E.01931
G1 X93.559 Y88.837 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.397065
G1 F3000;_EXTRUDE_SET_SPEED
G1 X95.885 Y86.512 E.09491
G1 X95.998 Y86.438 E.00389
G1 X96.11 Y86.512 E.00389
G1 X108.087 Y98.488 E.48879
G1 X108.161 Y98.601 E.00389
G1 X108.087 Y98.714 E.00389
G1 X105.804 Y100.997 E.09318
; Slow Down End
; WIPE_START
G1 X107.218 Y99.583 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.826 Y102.973 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.38336
G1 F3000;_EXTRUDE_SET_SPEED
G1 X100.136 Y102.687 E.02072
G1 X99.674 Y102.377 E.01542
G1 X99.312 Y102.019 E.01412
G3 X98.809 Y101.174 I3.99 J-2.95 E.02734
G1 X98.64 Y100.583 E.01705
G1 X98.583 Y100.057 E.01468
G1 X98.618 Y99.62 E.01217
G1 X98.812 Y98.881 E.0212
G1 X99.004 Y98.461 E.0128
G1 X99.455 Y97.871 E.0206
G1 X100.1 Y97.364 E.02276
G1 X100.839 Y97.052 E.02226
G1 X101.496 Y96.956 E.01844
G3 X102.47 Y97.052 I.12 J3.755 E.02721
G1 X103.173 Y97.343 E.02111
G1 X103.616 Y97.64 E.01478
G1 X104.085 Y98.133 E.01889
G1 X104.486 Y98.82 E.02205
G1 X104.601 Y99.181 E.0105
; Slow Down End
G1 X102.993 Y93.908 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X101.842 Y92.756 E.05401
G1 X94.396 Y100.203 E.34933
G1 X97.274 Y103.081 E.13504
G1 X98.658 Y101.697 E.06494
G3 X99.223 Y97.584 I3.021 J-1.681 E.14773
G1 X97.014 Y95.375 E.10361
G3 X92.901 Y95.94 I-2.433 J-2.459 E.1477
G1 X91.517 Y97.324 E.06494
G1 X88.639 Y94.446 E.13504
G1 X96.085 Y86.999 E.34933
G1 X98.964 Y89.878 E.13504
G1 X97.579 Y91.262 E.06494
G3 X98.013 Y92.816 I-3.514 J1.819 E.05389
; WIPE_START
G1 X97.93 Y92.183 E-.2428
G1 X97.579 Y91.262 E-.37426
G1 X97.845 Y90.996 E-.14294
; WIPE_END
G1 E-.04 F1800
G1 X94.592 Y89.87 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F3000;_EXTRUDE_SET_SPEED
G1 X95.359 Y89.97 E.02142
G1 X96.102 Y90.272 E.02223
G1 X96.544 Y90.569 E.01476
G1 X97.014 Y91.062 E.01888
G1 X97.413 Y91.75 E.02202
G1 X97.58 Y92.288 E.01561
G1 X97.656 Y92.926 E.0178
G1 X97.603 Y93.485 E.01556
G1 X97.429 Y94.103 E.01779
G1 X97.034 Y94.798 E.02215
G1 X96.467 Y95.366 E.02224
G1 X95.778 Y95.775 E.02219
G1 X95.262 Y95.936 E.01498
G1 X94.602 Y96.017 E.01843
G1 X93.808 Y95.918 E.02216
G1 X93.065 Y95.616 E.02223
G1 X92.603 Y95.307 E.0154
G1 X92.159 Y94.817 E.0183
G1 X91.752 Y94.139 E.02191
G1 X91.539 Y93.366 E.02222
G1 X91.526 Y93.026 E.00943
; Slow Down End
G1 X89.396 Y93.514 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X101.085 Y105.203 E.54836
G1 X99.001 Y104.808 F30000
G1 F8843.478
G1 X100.153 Y105.96 E.05401
G1 X107.599 Y98.513 E.34933
G1 X104.721 Y95.635 E.13504
G1 X103.336 Y97.019 E.06494
G3 X104.514 Y98.12 I-1.76 J3.065 E.05394
G1 X95.153 Y87.757 F30000
G1 F8843.478
G1 X106.842 Y99.446 E.54836
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X105.428 Y98.032 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 13/30
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
M106 S229.5
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z2.8 I-1.186 J-.273 P1  F30000
G1 X94.964 Y143.538 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z3 F30000
G1 X81.345 Y142.345 Z3
G1 Z2.6
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z3 F30000
G1 X95.153 Y143.945 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 13 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer13 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X95.581 Y134.106 Z3 F30000
G1 X95.613 Y133.039 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X86.142 Y114.22 E.23227
G1 X91.093 Y109.268 E.23227
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X86.419 Y114.497 E.20311
G1 X91.093 Y109.823 E.20311
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X93.391 Y123.698 Z3 F30000
G1 X92.366 Y109.965 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X91.546 Y108.323 E.02126
G1 X92.777 Y109.554 E.05775
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X96.471 Y114.105 Z3 F30000
G1 X96.888 Y114.504 Z3
G1 Z2.6
G1 E.8 F1800
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X91.834 Y108.035 E.03476
G1 X93.353 Y109.554 E.07125
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X92.111 Y107.758 E.04425
G1 X93.907 Y109.554 E.07805
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
M73 P78 R6
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.2177
G1 F15000
G1 X91.34 Y108.529 E.0219
G2 X91.093 Y108.303 I-.67 J.484 E.00481
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z3 F30000
G1 X145.197 Y77.807 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z3 F30000
G1 Z2.6
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
M73 P78 R5
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z3 F30000
G1 X112.992 Y88.732 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.877 Y83.459 Z3 F30000
G1 X120.798 Y82.913 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y82.166 E.03505
G1 X119.646 Y82.57 E.01897
G1 X130.455 Y93.379 E.50704
G1 X127.576 Y96.257 E.13504
G1 X116.768 Y85.449 E.50704
G1 X113.889 Y88.327 E.13504
G1 X124.698 Y99.135 E.50704
G1 X124.293 Y99.54 E.01897
G1 X121.768 Y97.014 E.11848
G1 X128.333 Y90.449 E.30801
G1 X125.455 Y87.57 E.13504
G1 X118.889 Y94.136 E.30801
G1 X116.011 Y91.257 E.13504
G1 X122.576 Y84.692 E.30801
G1 X123.728 Y85.843 E.05401
; OBJECT_ID: 258
; WIPE_START
G1 X122.576 Y84.692 E-.61876
G1 X122.313 Y84.954 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X116.318 Y89.678 Z3 F30000
G1 X100.255 Y102.334 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.007 Y102.162 E.01001
G3 X98.99 Y100.487 I1.647 J-2.147 E.06653
G3 X101.534 Y97.312 I2.666 J-.471 E.15272
G3 X100.308 Y102.362 I.12 J2.703 E.3327
G1 X100.481 Y101.996 F30000
G1 F8843.478
G1 X100.255 Y101.839 E.00912
G3 X99.389 Y100.407 I1.399 J-1.824 E.05681
G3 X101.561 Y97.718 I2.267 J-.391 E.12976
G3 X100.534 Y102.023 I.093 J2.297 E.28144
M204 S250
G1 X100.699 Y101.67 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.702 Y101.664 E.0002
G3 X101.587 Y98.109 I.96 J-1.649 E.15094
G3 X102.385 Y98.25 I.084 J1.859 E.02512
G3 X100.925 Y101.775 I-.723 J1.765 E.1846
G1 X100.754 Y101.695 E.00582
; WIPE_START
M204 S10000
G1 X100.702 Y101.664 E-.02279
G1 X100.491 Y101.531 E-.09481
G1 X100.303 Y101.366 E-.09497
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09494
G1 X99.889 Y100.746 E-.09497
G1 X99.809 Y100.51 E-.09495
G1 X99.773 Y100.331 E-.06925
G1 X99.749 Y100.073 E-.09833
; WIPE_END
G1 E-.04 F1800
G1 X97.206 Y93.629 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.197 Y93.645 E.00059
G3 X95.167 Y95.586 I-2.614 J-.7 E.09797
G3 X94.464 Y90.241 I-.584 J-2.642 E.29753
G3 X97.266 Y93.297 I.12 J2.703 E.15672
G1 X97.216 Y93.57 E.0092
G1 X96.803 Y93.539 F30000
G1 F8843.478
G3 X92.64 Y94.173 I-2.221 J-.595 E.17657
G3 X94.49 Y90.647 I1.935 J-1.233 E.15993
G3 X96.818 Y93.481 I.093 J2.297 E.14084
M204 S250
G1 X96.433 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.516 Y91.038 I-1.842 J-.496 E.25843
G3 X95.314 Y91.179 I.083 J1.859 E.02512
G3 X96.447 Y93.382 I-.723 J1.765 E.08283
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11776
G1 X96.238 Y93.899 E-.09498
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.69 Y94.497 E-.1205
G1 X95.539 Y94.599 E-.06923
G1 X95.314 Y94.709 E-.09499
G1 X95.133 Y94.771 E-.07263
; WIPE_END
G1 E-.04 F1800
G1 X102.479 Y96.843 Z3 F30000
G1 X108.713 Y98.601 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X103.534 Y93.422 E.35353
G1 X108.67 Y98.559 E.24097
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X103.821 Y93.134 E.36703
G1 X109.246 Y98.559 E.25447
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X104.099 Y92.857 E.35203
G1 X109.8 Y98.559 E.24776
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.004 Y100.058 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41769
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X105.868 Y100.922 E.06822
G1 X106.199 Y100.591 E.02611
G1 X104.531 Y98.924 E.13167
G1 X104.09 Y98.002 E.05704
G1 X103.668 Y97.579 E.03339
G2 X102.746 Y97.138 I-5.658 J10.639 E.05707
G1 X97.457 Y91.85 E.41755
G3 X97.649 Y92.703 I-3.823 J1.308 E.04893
G1 X101.9 Y96.954 E.33561
G2 X101.246 Y96.961 I-.28 J4.249 E.03656
G1 X97.637 Y93.353 E.28489
G3 X97.511 Y93.887 I-3.87 J-.635 E.0307
G1 X100.711 Y97.088 E.25269
G2 X100.384 Y97.213 I.579 J2.005 E.01959
G1 X100.244 Y97.282 E.00871
G1 X97.317 Y94.355 E.23112
G3 X97.065 Y94.765 I-1.936 J-.904 E.02691
G1 X99.834 Y97.533 E.21858
G2 X99.75 Y97.595 I.195 J.351 E.00587
G1 X99.475 Y97.836 E.02037
G1 X96.762 Y95.123 E.21418
G1 X96.4 Y95.422 E.02623
G1 X99.176 Y98.199 E.21923
G2 X98.921 Y98.605 I1.977 J1.526 E.02682
G1 X95.994 Y95.677 E.23112
G3 X95.521 Y95.866 I-.805 J-1.335 E.02856
G1 X98.733 Y99.078 E.2536
G2 X98.6 Y99.607 I2.627 J.94 E.03049
G1 X94.992 Y95.998 E.28489
G3 X94.342 Y96.01 I-.403 J-4.28 E.0363
G1 X98.596 Y100.264 E.33585
G2 X98.777 Y101.106 I2.772 J-.155 E.04831
G1 X93.073 Y95.402 E.45035
M106 S229.5
G1 X90.226 Y91.894 F30000
M106 S255
G1 F3000
G1 X91.517 Y93.185 E.10194
G2 X91.706 Y94.035 I3.165 J-.257 E.04878
G1 X90.039 Y92.368 E.13166
G1 X89.708 Y92.699 E.02611
G1 X101.9 Y104.891 E.96261
G1 X101.569 Y105.221 E.02611
G1 X89.377 Y93.029 E.96261
G1 X89.046 Y93.36 E.02611
G1 X101.239 Y105.552 E.96261
G1 X100.908 Y105.883 E.02611
G1 X88.716 Y93.691 E.96261
G1 X88.385 Y94.021 E.02611
G1 X100.577 Y106.213 E.96261
G1 X100.246 Y106.544 E.02611
G1 X87.911 Y94.209 E.97392
M106 S229.5
G1 X92.419 Y90.78 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F8843.478
G1 X92.008 Y90.368 E.01931
G1 X93.293 Y89.083 E.06029
G1 X93.647 Y89.438 E.01662
G1 X91.071 Y92.013 E.12083
G1 X90.717 Y91.659 E.01662
G1 X91.514 Y90.862 E.03739
G1 X93.533 Y88.587 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.41769
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X94.829 Y89.883 E.1023
G1 X94.98 Y89.887 E.00842
G3 X95.675 Y90.067 I-.349 J2.786 E.04019
G1 X94.007 Y88.399 E.13167
G1 X94.338 Y88.069 E.02611
G1 X106.53 Y100.261 E.96261
G1 X106.861 Y99.93 E.02611
G1 X94.668 Y87.738 E.96261
G1 X94.999 Y87.407 E.02611
G1 X107.191 Y99.599 E.96261
G1 X107.522 Y99.269 E.02611
G1 X95.33 Y87.077 E.96261
G1 X95.661 Y86.746 E.02611
G1 X107.853 Y98.938 E.96261
G1 X108.183 Y98.607 E.02611
G1 X95.848 Y86.272 E.97392
M106 S229.5
; WIPE_START
G1 X97.262 Y87.686 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.722 Y95.178 Z3 F30000
G1 X100.144 Y102.474 Z3
G1 Z2.6
G1 E.8 F1800
M106 S255
G1 F3000
G1 X102.231 Y104.56 E.16473
G1 X102.561 Y104.229 E.02611
G1 X101.722 Y103.39 E.06625
M106 S229.5
G1 X102.04 Y103.05 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F8843.478
G1 X101.657 Y103.075 E.01272
G1 X101.973 Y103.285 E.01258
G1 X102.158 Y103.1 E.00869
G1 X102.585 Y103.527 E.02003
G1 X105.161 Y100.952 E.12083
G1 X105.515 Y101.306 E.01662
G1 X104.23 Y102.591 E.06029
G1 X103.818 Y102.179 E.01932
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X104.23 Y102.591 E-.22126
M73 P79 R5
G1 X105.233 Y101.588 E-.53874
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 14/30
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
M106 S234.6
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z3 I-1.182 J-.289 P1  F30000
G1 X94.964 Y143.538 Z3
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z3.2 F30000
G1 X81.345 Y142.345 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z3.2 F30000
G1 X95.153 Y143.945 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 14 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer14 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z3.2 F30000
G1 X92.366 Y109.965 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68438
G1 X90.952 Y108.833 E-.07562
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z3.2 F30000
G1 X95.613 Y133.039 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z3.2 F30000
G1 X96.888 Y114.504 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X93.347 Y110.963 E.03291
G1 X94.346 Y111.961 E.04684
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X95.469 Y113.084 E.03291
G1 X96.467 Y114.083 E.04684
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X93.624 Y110.685 E.01844
G1 X94.346 Y111.407 E.03134
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X95.746 Y112.807 E.01844
G1 X96.467 Y113.528 E.03134
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231724
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231715
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z3.2 F30000
G1 X145.197 Y77.807 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z3.2 F30000
G1 X112.992 Y88.732 Z3.2
G1 Z2.8
M73 P80 R5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.865 Y86.258 Z3.2 F30000
G1 X123.728 Y85.843 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X122.576 Y84.692 E.05401
G1 X116.011 Y91.257 E.30801
G1 X118.889 Y94.136 E.13504
G1 X125.455 Y87.57 E.30801
G1 X128.333 Y90.449 E.13504
G1 X121.768 Y97.014 E.30801
G1 X124.293 Y99.54 E.11848
G1 X124.698 Y99.135 E.01897
G1 X113.889 Y88.327 E.50704
G1 X116.768 Y85.449 E.13504
G1 X127.576 Y96.257 E.50704
G1 X130.455 Y93.379 E.13504
G1 X119.646 Y82.57 E.50704
G1 X120.051 Y82.166 E.01897
G1 X120.798 Y82.913 E.03505
; OBJECT_ID: 258
; WIPE_START
G1 X120.051 Y82.166 E-.40148
G1 X119.646 Y82.57 E-.21728
G1 X119.909 Y82.833 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X114.511 Y88.229 Z3.2 F30000
G1 X100.346 Y102.387 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X100.301 Y102.358 E.00175
G3 X101.548 Y97.311 I1.362 J-2.341 E.23111
G3 X103.01 Y97.667 I.096 J2.784 E.05055
G3 X100.619 Y102.516 I-1.347 J2.35 E.27106
G1 X100.4 Y102.412 E.00802
G1 X100.526 Y102.022 F30000
G1 F8843.478
G1 X100.506 Y102.005 E.00088
G3 X101.574 Y97.717 I1.158 J-1.988 E.19659
G3 X102.536 Y97.887 I.099 J2.242 E.03265
G3 X100.775 Y102.139 I-.872 J2.129 E.24038
G1 X100.58 Y102.047 E.00713
M204 S250
G1 X100.699 Y101.669 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.496 Y101.525 E.00765
G3 X101.6 Y98.108 I1.168 J-1.509 E.14366
G3 X102.149 Y98.17 I.033 J2.179 E.01701
G3 X100.749 Y101.691 I-.485 J1.846 E.1985
; WIPE_START
M204 S10000
G1 X100.496 Y101.525 E-.11501
G1 X100.303 Y101.366 E-.09485
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09496
G1 X99.747 Y100.067 E-.07535
; WIPE_END
G1 E-.04 F1800
G1 X97.204 Y93.635 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.208 Y93.647 E.00044
G3 X94.477 Y90.24 I-2.616 J-.702 E.39604
G3 X95.939 Y90.596 I.096 J2.784 E.05054
G3 X97.277 Y93.299 I-1.347 J2.35 E.1061
G1 X97.217 Y93.576 E.00941
G1 X96.815 Y93.542 F30000
G1 F8843.478
G3 X94.504 Y90.646 I-2.222 J-.597 E.33673
G3 X95.465 Y90.816 I.099 J2.241 E.03264
G3 X96.829 Y93.484 I-.872 J2.129 E.10825
M204 S250
G1 X96.436 Y93.441 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.529 Y91.037 I-1.843 J-.496 E.259
G3 X95.078 Y91.099 I.033 J2.182 E.017
G3 X96.451 Y93.382 I-.485 J1.846 E.09063
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11785
G1 X96.238 Y93.899 E-.09495
G1 X96.099 Y94.107 E-.09496
G1 X95.934 Y94.295 E-.09497
G1 X95.746 Y94.46 E-.09497
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.134 Y94.77 E-.07238
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z3.2 F30000
G1 X108.713 Y98.601 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X103.062 Y92.951 E.33141
G1 X108.67 Y98.559 E.26308
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X103.35 Y92.663 E.34492
G1 X109.246 Y98.559 E.27658
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X103.627 Y92.386 E.33155
G1 X109.8 Y98.559 E.26825
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.589 Y94.047 Z3.2 F30000
G1 X103.26 Y93.641 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X102.109 Y92.49 E.05401
G1 X100.235 Y94.363 E.08789
G1 X102.304 Y94.908 E.07098
G1 X99.568 Y92.172 E.12839
G1 X99.146 Y90.599 E.05401
; WIPE_START
G1 X99.568 Y92.172 E-.61876
G1 X99.83 Y92.434 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X93.484 Y96.674 Z3.2 F30000
G1 X92.238 Y97.507 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8843.478
G1 X93.811 Y97.928 E.05401
G1 X96.548 Y100.665 E.12839
G1 X96.085 Y98.939 E.05929
G1 X95.815 Y98.886 E.00914
G1 X95.772 Y98.826 E.00243
G1 X94.129 Y100.47 E.0771
G1 X95.28 Y101.621 E.05401
G1 X100.24 Y106.519 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
G1 X97.194 Y103.473 E.13235
G2 X97.605 Y103.095 I.017 J-.393 E.01905
G1 X96.445 Y98.766 E.1377
G1 X96.334 Y98.624 E.00554
G1 X96.052 Y98.533 E.0091
G1 X96.058 Y98.355 E.00548
G1 X95.961 Y98.149 E.007
G1 X95.852 Y98.07 E.00413
G1 X91.447 Y96.889 E.14015
G1 X91.283 Y96.922 E.00512
G1 X90.993 Y97.272 E.01397
G1 X88.08 Y94.358 E.12659
G1 X90.604 Y91.834 E.1097
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.438444
;_EXTRUDE_SET_SPEED
G1 X90.68 Y91.758 E.00344
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.47535
;_EXTRUDE_SET_SPEED
G1 X90.755 Y91.683 E.00376
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.457009
;_EXTRUDE_SET_SPEED
G1 X91.499 Y91.017 E.0337
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.51261
;_EXTRUDE_SET_SPEED
G1 X92.1 Y90.381 E.03351
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.465613
;_EXTRUDE_SET_SPEED
G1 X92.418 Y90.068 E.01534
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.449118
;_EXTRUDE_SET_SPEED
G2 X93.247 Y89.191 I-7.331 J-7.761 E.03997
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.41999
;_EXTRUDE_SET_SPEED
G1 X93.468 Y88.97 E.00959
; Slow Down End
; Slow Down Start
;_EXTRUDE_SET_SPEED
G1 X95.998 Y86.44 E.10993
G1 X98.911 Y89.354 E.12659
G1 X98.656 Y89.52 E.00936
G2 X98.528 Y89.808 I.228 J.273 E.01001
G3 X99.777 Y94.483 I-362.337 J99.287 E.14868
G1 X100 Y94.721 E.01003
G1 X100.225 Y94.757 E.00702
G1 X104.231 Y95.83 E.12742
G1 X104.81 Y95.97 E.01829
G1 X105.021 Y95.838 E.00766
G2 X105.095 Y95.579 I-.225 J-.204 E.00856
G1 X105.124 Y95.567 E.00097
G1 X108.158 Y98.601 E.13183
G1 X105.628 Y101.131 E.10993
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.4387
;_EXTRUDE_SET_SPEED
G1 X105.359 Y101.4 E.01228
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.458655
;_EXTRUDE_SET_SPEED
G3 X104.497 Y102.209 I-9.094 J-8.825 E.04007
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.49474
;_EXTRUDE_SET_SPEED
G1 X104.135 Y102.581 E.01911
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.465553
;_EXTRUDE_SET_SPEED
G1 X103.819 Y102.892 E.01528
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.449172
;_EXTRUDE_SET_SPEED
G2 X102.991 Y103.768 I7.283 J7.714 E.03991
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.41999
;_EXTRUDE_SET_SPEED
G1 X102.765 Y103.994 E.00983
; Slow Down End
G1 F9547.299
G1 X100.283 Y106.476 E.10785
G1 X100.875 Y103.018 F30000
G1 F9547.299
G1 X100.125 Y102.714 E.02488
G3 X99.441 Y102.189 I6.274 J-8.868 E.02648
G1 X98.98 Y101.588 E.02329
G1 X98.664 Y100.842 E.02488
G1 X98.552 Y100.04 E.02488
G1 X98.652 Y99.236 E.02489
G1 X98.956 Y98.485 E.02488
G1 X99.443 Y97.839 E.02488
G1 X100.082 Y97.341 E.02489
G1 X100.828 Y97.025 E.02488
G1 X101.518 Y96.921 E.02146
G3 X102.864 Y97.159 I.111 J3.296 E.04231
G1 X103.523 Y97.539 E.02338
G1 X104.101 Y98.107 E.02489
G1 X104.511 Y98.805 E.02489
G1 X104.727 Y99.586 E.02488
G1 X104.728 Y99.681 E.00293
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X104.733 Y100.396 E.02196
G1 X104.53 Y101.18 E.02488
G1 X104.16 Y101.901 E.02492
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.502326
;_EXTRUDE_SET_SPEED
G1 X103.847 Y102.253 E.01762
G1 X103.26 Y102.734 E.02839
G1 X102.481 Y103.005 E.0309
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.41999
;_EXTRUDE_SET_SPEED
G1 X101.679 Y103.117 E.02489
G1 X101.279 Y103.068 E.01239
; Slow Down End
G1 F9547.299
G1 X100.935 Y103.025 E.01065
; WIPE_START
G1 X101.279 Y103.068 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.775 Y96.287 Z3.2 F30000
G1 X94.447 Y89.849 Z3.2
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.313
G1 X94.967 Y89.865 E.01598
G1 X95.422 Y89.959 E.01425
G1 X96.113 Y90.245 E.023
G1 X96.759 Y90.733 E.02488
G1 X97.258 Y91.372 E.02488
G3 X97.686 Y92.928 I-3.099 J1.691 E.05003
G1 X97.586 Y93.723 E.02464
G3 X97.258 Y94.516 I-12.495 J-4.711 E.02639
G1 X96.794 Y95.12 E.02339
G3 X96.124 Y95.638 I-11.339 J-13.985 E.02602
G3 X94.606 Y96.047 I-1.666 J-3.166 E.04871
G1 X93.804 Y95.947 E.02483
G1 X93.053 Y95.643 E.02489
G1 X92.407 Y95.155 E.02488
G1 X91.909 Y94.517 E.02488
G1 X91.598 Y93.783 E.0245
G1 X91.481 Y92.969 E.02526
G1 X91.509 Y92.739 E.00711
; Slow Down Start
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
G1 X91.58 Y92.165 E.01778
G1 X91.847 Y91.399 E.02492
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.504401
;_EXTRUDE_SET_SPEED
G1 X92.348 Y90.749 E.03085
G1 X92.977 Y90.226 E.03077
G1 X93.757 Y89.954 E.03105
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.41999
;_EXTRUDE_SET_SPEED
G1 X94.36 Y89.863 E.01875
; Slow Down End
G1 F9547.299
G1 X94.388 Y89.858 E.00088
; WIPE_START
G1 X94.36 Y89.863 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X91.107 Y93.018 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.301
G1 X91.25 Y93.927 E.02827
G1 X91.61 Y94.746 E.0275
G1 X92.178 Y95.454 E.02788
G1 X92.909 Y95.991 E.02789
G1 X93.755 Y96.321 E.02789
G1 X94.651 Y96.421 E.02771
G1 X95.298 Y96.343 E.02002
G1 X95.862 Y96.18 E.01803
G2 X96.608 Y95.746 I-.791 J-2.223 E.02668
G1 X97.093 Y95.35 E.01925
G1 X97.557 Y94.746 E.02339
G2 X97.96 Y93.773 I-6.361 J-3.205 E.03241
G1 X98.06 Y92.876 E.0277
G1 X97.967 Y92.151 E.02248
G1 X97.819 Y91.666 E.01558
G1 X97.557 Y91.142 E.01799
G1 X97.093 Y90.538 E.02338
G2 X96.257 Y89.897 I-4.772 J5.354 E.03241
G1 X95.554 Y89.606 E.02339
G1 X94.981 Y89.488 E.01799
G1 X94.394 Y89.476 E.01803
G1 X93.749 Y89.568 E.02003
G1 X93.191 Y89.78 E.01833
G1 X95.998 Y86.974 E.12195
G1 X98.338 Y89.315 E.10172
G1 X98.153 Y89.664 E.01216
G1 X98.164 Y89.905 E.00741
G3 X99.387 Y94.474 I-1348.39 J363.347 E.14533
G1 X99.501 Y94.753 E.00924
G1 X99.849 Y95.069 E.01445
G1 X100.17 Y95.133 E.01007
G1 X104.424 Y96.272 E.1353
G1 X104.864 Y96.343 E.01371
G1 X105.2 Y96.176 E.01152
G1 X107.625 Y98.601 E.10537
G1 X104.856 Y101.37 E.12034
G1 X104.894 Y101.277 E.0031
G1 X105.097 Y100.449 E.02619
G2 X105.107 Y100.254 I-.359 J-.116 E.00607
G1 X105.091 Y99.488 E.02354
G1 X104.838 Y98.617 E.02788
G1 X104.367 Y97.841 E.02789
G1 X103.712 Y97.213 E.02789
G1 X103.053 Y96.832 E.02338
G2 X101.465 Y96.547 I-1.422 J3.359 E.04999
G1 X100.683 Y96.677 E.02434
G1 X99.98 Y96.968 E.02338
G2 X99.144 Y97.61 I3.96 J6.026 E.03241
G1 X98.607 Y98.341 E.02788
G1 X98.278 Y99.187 E.02789
G1 X98.178 Y100.089 E.02789
G1 X98.316 Y100.986 E.02789
G1 X98.681 Y101.817 E.02789
G1 X99.142 Y102.418 E.02329
G2 X99.98 Y103.062 I4.188 J-4.582 E.03251
G1 X100.826 Y103.392 E.02789
G1 X101.728 Y103.491 E.02789
G1 X102.483 Y103.392 E.02339
G1 X103.047 Y103.179 E.01852
G1 X100.24 Y105.986 E.12195
G1 X97.815 Y103.561 E.10537
G1 X97.982 Y103.224 E.01155
G1 X97.969 Y102.999 E.00693
G1 X96.809 Y98.669 E.13773
G1 X96.649 Y98.402 E.00957
G1 X96.41 Y98.246 E.00876
G1 X96.378 Y98.105 E.00444
G1 X96.182 Y97.832 E.01033
G1 X95.95 Y97.705 E.00812
G1 X91.637 Y96.55 E.13719
G1 X91.303 Y96.514 E.01032
G1 X90.954 Y96.699 E.01216
G1 X88.613 Y94.358 E.10172
G1 X91.419 Y91.552 E.12195
G1 X91.207 Y92.116 E.01851
G1 X91.114 Y92.958 E.02605
; WIPE_START
G1 X91.207 Y92.116 E-.32215
G1 X91.419 Y91.552 E-.22897
G1 X91.031 Y91.941 E-.20889
; WIPE_END
G1 E-.04 F1800
G1 X98.272 Y94.351 Z3.2 F30000
G1 X105.121 Y96.631 Z3.2
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.919 Y96.716 E.00675
G1 X104.539 Y96.694 E.01169
G1 X104.036 Y96.559 E.016
; LINE_WIDTH: 0.439572
G1 F9075.983
G1 X103.847 Y96.529 E.00618
; LINE_WIDTH: 0.478734
G1 F8260.41
G1 X103.658 Y96.498 E.00679
; LINE_WIDTH: 0.517897
G1 F7579.327
G1 X103.469 Y96.468 E.0074
; LINE_WIDTH: 0.557059
G1 F7002.001
G1 X103.281 Y96.438 E.00801
G1 X103.436 Y96.55 E.00801
; LINE_WIDTH: 0.517897
G1 F7579.327
G1 X103.59 Y96.662 E.0074
; LINE_WIDTH: 0.478734
G1 F8260.41
G1 X103.745 Y96.774 E.00679
; LINE_WIDTH: 0.420405
G1 F9536.811
G1 X103.9 Y96.886 E.00588
G1 X104.634 Y97.574 E.03093
G1 X104.784 Y97.769 E.00757
G1 X105.164 Y98.428 E.02341
G1 X105.455 Y99.391 E.03092
G1 X105.487 Y100.205 E.02507
G1 X107.092 Y98.601 E.06978
G1 X105.163 Y96.673 E.08387
G1 X105.032 Y97.033 F30000
; LINE_WIDTH: 0.363411
G1 F11232.767
G1 X104.969 Y97.06 E.00181
G1 X104.588 Y97.037 E.00995
G1 X105.028 Y97.497 E.01661
; LINE_WIDTH: 0.412871
G1 F9731.019
G1 X105.491 Y98.24 E.0264
G3 X105.825 Y99.334 I-7.413 J2.862 E.03453
G1 X106.558 Y98.601 E.03127
G3 X105.364 Y97.383 I27.533 J-28.2 E.05143
; LINE_WIDTH: 0.37362
G1 F10886
G1 X105.073 Y97.076 E.01139
G1 X106.048 Y98.56 F30000
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X105.977 Y98.601 E.00251
G1 X106.037 Y98.635 E.00212
G1 X102.121 Y96.117 F30000
; LINE_WIDTH: 0.53713
G1 F7284.353
G1 X102.665 Y96.242 E.02249
; LINE_WIDTH: 0.531865
G1 F7362.792
G1 X102.944 Y96.331 E.01167
; LINE_WIDTH: 0.561715
G1 F6939.157
G1 X103.223 Y96.419 E.01238
G1 X102.121 Y96.117 F30000
; LINE_WIDTH: 0.534432
G1 F7324.342
G1 X101.953 Y96.048 E.00728
; LINE_WIDTH: 0.488655
G1 F8076.548
G1 X101.784 Y95.979 E.0066
; LINE_WIDTH: 0.421096
G1 F9519.398
G1 X101.616 Y95.911 E.0056
G1 X100.115 Y95.508 E.04788
G1 X99.8 Y95.457 E.00986
G1 X99.579 Y95.347 E.00758
G1 X99.2 Y94.98 E.01627
G1 X99.078 Y94.766 E.00758
G1 X98.898 Y94.101 E.02126
; LINE_WIDTH: 0.433595
G1 F9214.821
G1 X98.745 Y93.581 E.01723
; LINE_WIDTH: 0.460805
G1 F8614.81
G1 X98.592 Y93.062 E.01843
; LINE_WIDTH: 0.491993
G1 F8016.524
G1 X98.546 Y92.959 E.00413
; LINE_WIDTH: 0.527158
G1 F7434.369
G1 X98.5 Y92.856 E.00446
; LINE_WIDTH: 0.523949
G1 F7483.967
G1 X98.444 Y93.178 E.01281
; LINE_WIDTH: 0.482365
G1 F8192.151
G1 X98.389 Y93.5 E.0117
; LINE_WIDTH: 0.42143
G1 F9510.976
G1 X98.334 Y93.822 E.01008
G3 X97.856 Y94.976 I-5.784 J-1.72 E.03859
G1 X97.393 Y95.579 E.02348
G3 X96.458 Y96.314 I-4.87 J-5.233 E.03671
G1 X95.972 Y96.54 E.01653
G1 X95.343 Y96.717 E.02015
; LINE_WIDTH: 0.434503
G1 F9193.466
G1 X95.021 Y96.771 E.01041
; LINE_WIDTH: 0.463528
G1 F8559.048
G1 X94.7 Y96.824 E.01118
; LINE_WIDTH: 0.49473
G1 F7967.951
G1 X94.597 Y96.842 E.00383
; LINE_WIDTH: 0.52811
G1 F7419.774
G1 X94.495 Y96.861 E.00411
; LINE_WIDTH: 0.523999
G1 F7483.189
G1 X94.768 Y96.955 E.01131
; LINE_WIDTH: 0.482395
G1 F8191.592
G1 X95.04 Y97.05 E.01033
; LINE_WIDTH: 0.421958
G1 F9497.731
G2 X96.048 Y97.341 I2.521 J-6.826 E.03242
G1 X96.358 Y97.489 E.01061
G3 X96.772 Y98.007 I-1.24 J1.417 E.02058
G1 X97.055 Y98.305 E.0127
G1 X97.248 Y98.853 E.01794
; LINE_WIDTH: 0.435368
G1 F9173.201
G1 X97.405 Y99.377 E.01751
; LINE_WIDTH: 0.466123
G1 F8506.566
G1 X97.561 Y99.902 E.01888
; LINE_WIDTH: 0.505447
G1 F7783.335
G1 X97.609 Y99.985 E.0036
; LINE_WIDTH: 0.55334
G1 F7053.016
G1 X97.656 Y100.068 E.00398
; LINE_WIDTH: 0.601234
G1 F6447.992
G1 X97.703 Y100.152 E.00435
; LINE_WIDTH: 0.604661
G1 F6408.647
G1 X97.743 Y99.949 E.00947
; LINE_WIDTH: 0.563623
G1 F6913.73
G1 X97.783 Y99.746 E.00877
; LINE_WIDTH: 0.522585
G1 F7505.238
G1 X97.823 Y99.543 E.00808
; LINE_WIDTH: 0.481547
G1 F8207.429
G1 X97.864 Y99.34 E.00739
; LINE_WIDTH: 0.420819
G1 F9526.36
G1 X97.904 Y99.138 E.00637
G3 X98.315 Y98.083 I7.296 J2.238 E.03488
G1 X98.845 Y97.38 E.02712
G3 X99.718 Y96.679 I5.557 J6.02 E.03451
G3 X100.766 Y96.266 I3.532 J7.44 E.03473
G1 X101.411 Y96.174 E.02006
; LINE_WIDTH: 0.439792
G1 F9070.942
G1 X101.628 Y96.157 E.00703
; LINE_WIDTH: 0.479395
G1 F8247.895
G1 X101.845 Y96.14 E.00773
; LINE_WIDTH: 0.518999
G1 F7561.781
G1 X102.061 Y96.123 E.00843
G1 X100.393 Y95.977 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X99.677 Y95.814 E.02257
G1 X99.369 Y95.66 E.01059
G1 X98.899 Y95.208 E.02004
G1 X98.729 Y94.908 E.01058
G1 X98.568 Y94.326 E.01856
G1 X98.327 Y94.907 E.01932
G1 X98.155 Y95.205 E.01058
G1 X97.692 Y95.809 E.02339
G1 X97.448 Y96.053 E.01059
G1 X96.844 Y96.516 E.02338
G1 X96.28 Y96.822 E.01973
G1 X95.979 Y96.932 E.00984
G1 X96.288 Y97.024 E.00991
G1 X96.687 Y97.272 E.01443
G2 X97.372 Y98.101 I9.279 J-6.965 E.03306
G1 X97.616 Y98.754 E.02143
G1 X97.91 Y98.052 E.02338
G3 X98.79 Y96.907 I4.91 J2.857 E.0445
G1 X99.393 Y96.444 E.02338
G1 X99.692 Y96.271 E.01059
G1 X100.338 Y96 E.02154
G1 X99.297 Y96.055 F30000
G1 F9547.299
G1 X98.869 Y95.729 E.01651
G1 X98.527 Y95.327 E.01623
G3 X97.844 Y96.205 I-11.23 J-8.02 E.03417
G3 X96.879 Y96.942 I-7.011 J-8.195 E.03734
G3 X97.616 Y97.799 I-9.854 J9.231 E.03475
G3 X98.247 Y96.921 I7.265 J4.552 E.03323
G1 X98.56 Y96.608 E.01362
G3 X99.247 Y96.088 I4.603 J5.374 E.02648
G1 X97.582 Y97.016 F30000
; LINE_WIDTH: 0.579614
G1 F6707.741
G1 X97.718 Y96.88 E.0084
; LINE_WIDTH: 0.5308
G1 F7378.864
G1 X97.854 Y96.744 E.00763
; LINE_WIDTH: 0.481987
G1 F8199.21
G1 X97.99 Y96.609 E.00687
; LINE_WIDTH: 0.475587
G1 F8320.493
G1 X98.163 Y96.436 E.00863
; LINE_WIDTH: 0.5116
G1 F7681.147
G1 X98.336 Y96.263 E.00934
; LINE_WIDTH: 0.547614
G1 F7133.045
G1 X98.509 Y96.09 E.01006
G1 X94.495 Y96.861 F30000
; LINE_WIDTH: 0.527074
G1 F7435.661
G1 X94.231 Y96.808 E.0106
; LINE_WIDTH: 0.49162
G1 F8023.178
G1 X93.968 Y96.756 E.00982
; LINE_WIDTH: 0.456167
G1 F8711.504
G1 X93.705 Y96.704 E.00904
; LINE_WIDTH: 0.46339
G1 F8561.848
G1 X93.252 Y96.558 E.01629
; LINE_WIDTH: 0.51329
G1 F7653.55
G1 X92.799 Y96.413 E.01822
G1 X90.741 Y92.763 F30000
; LINE_WIDTH: 0.422595
G1 F9481.814
G1 X89.146 Y94.358 E.06978
G1 X91.024 Y96.236 E.08217
G1 X91.24 Y96.142 E.0073
G1 X91.642 Y96.161 E.01244
G1 X92.475 Y96.364 E.02653
; LINE_WIDTH: 0.478743
G1 F8260.244
G1 X92.609 Y96.379 E.00478
; LINE_WIDTH: 0.518408
G1 F7571.177
G1 X92.742 Y96.394 E.00521
; LINE_WIDTH: 0.518532
G1 F7569.2
G1 X92.477 Y96.181 E.01318
; LINE_WIDTH: 0.479115
G1 F8253.189
G1 X92.213 Y95.967 E.01209
; LINE_WIDTH: 0.421852
G1 F9500.39
G1 X91.948 Y95.753 E.0105
G3 X91.188 Y94.763 I4.4 J-4.163 E.03863
G1 X90.896 Y94.059 E.0235
G1 X90.733 Y93.067 E.03105
G1 X90.74 Y92.823 E.00753
G1 X90.425 Y93.613 F30000
; LINE_WIDTH: 0.409088
G1 F9831.551
G1 X89.679 Y94.358 E.03146
G3 X91.112 Y95.822 I-51.399 J51.743 E.06111
G1 X91.479 Y95.779 E.01103
G1 X91.018 Y95.2 E.02207
G1 X90.839 Y94.907 E.01025
G1 X90.548 Y94.204 E.02271
G1 X90.437 Y93.672 E.01622
G1 X90.231 Y94.318 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X90.161 Y94.358 E.00242
G1 X90.219 Y94.392 E.002
; WIPE_START
G1 X90.161 Y94.358 E-.34436
G1 X90.231 Y94.318 E-.41564
; WIPE_END
G1 E-.04 F1800
G1 X97.393 Y91.68 Z3.2 F30000
G1 X98.147 Y91.403 Z3.2
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.45568
G1 F8721.775
G1 X98.331 Y92.019 E.02162
; LINE_WIDTH: 0.455017
G1 F8735.814
G1 X98.383 Y92.278 E.00889
; LINE_WIDTH: 0.48889
G1 F8072.292
G1 X98.436 Y92.537 E.00962
; LINE_WIDTH: 0.522764
G1 F7502.449
G1 X98.488 Y92.797 E.01035
G1 X98.147 Y91.403 F30000
; LINE_WIDTH: 0.459958
G1 F8632.317
G1 X98.085 Y91.117 E.00995
; LINE_WIDTH: 0.420351
G1 F9538.167
G2 X97.8 Y90.003 I-12.368 J2.568 E.03537
G1 X97.781 Y89.601 E.01237
G1 X97.875 Y89.385 E.00726
G1 X95.998 Y87.507 E.08168
G1 X94.405 Y89.099 E.06926
G3 X95.522 Y89.204 I.222 J3.657 E.03463
G1 X96.402 Y89.549 E.02907
G3 X97.344 Y90.251 I-3.987 J6.335 E.03619
G1 X97.856 Y90.913 E.02573
; LINE_WIDTH: 0.433313
G1 F9221.489
G1 X97.986 Y91.132 E.00811
; LINE_WIDTH: 0.459958
G1 F8632.317
G1 X98.117 Y91.351 E.00867
G1 X97.418 Y89.84 F30000
; LINE_WIDTH: 0.40873
G1 F9841.195
G1 X97.461 Y89.473 E.01102
G3 X95.998 Y88.04 I59.42 J-62.168 E.06105
G1 X95.269 Y88.769 E.03072
G1 X95.843 Y88.909 E.01761
G1 X96.546 Y89.201 E.02269
G1 X96.839 Y89.379 E.01024
G1 X97.371 Y89.803 E.02026
G1 X96.021 Y88.529 F30000
; LINE_WIDTH: 0.41304
G1 F9726.576
G1 X95.951 Y88.569 E.00242
G1 X96.009 Y88.602 E.002
; WIPE_START
G1 X95.951 Y88.569 E-.34436
G1 X96.021 Y88.529 E-.41564
; WIPE_END
G1 E-.04 F1800
G1 X97.235 Y96.064 Z3.2 F30000
G1 X98.179 Y101.915 Z3.2
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.61429
G1 F6300.646
G1 X98.092 Y101.66 E.01253
; LINE_WIDTH: 0.57875
G1 F6718.549
G1 X98.005 Y101.406 E.01175
; LINE_WIDTH: 0.54321
G1 F7195.827
G1 X97.919 Y101.151 E.01097
; LINE_WIDTH: 0.550375
G1 F7094.225
G1 X97.817 Y100.68 E.01989
; LINE_WIDTH: 0.600245
G1 F6459.427
G1 X97.715 Y100.21 E.02185
G1 X98.179 Y101.915 F30000
; LINE_WIDTH: 0.611274
G1 F6334.089
G1 X98.179 Y101.996 E.00372
; LINE_WIDTH: 0.5697
G1 F6833.972
G1 X98.179 Y102.076 E.00345
; LINE_WIDTH: 0.528127
G1 F7419.519
G1 X98.179 Y102.156 E.00318
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.256 Y102.528 E.01369
; LINE_WIDTH: 0.420877
G1 F9524.897
G3 X98.355 Y103.277 I-2.523 J.717 E.02337
G1 X98.269 Y103.482 E.00682
G1 X100.24 Y105.452 E.08584
G1 X101.835 Y103.857 E.06947
G1 X101.531 Y103.865 E.00936
G1 X100.777 Y103.766 E.02344
G1 X99.836 Y103.411 E.03097
G1 X99.174 Y102.944 E.02494
G1 X98.843 Y102.648 E.01368
; LINE_WIDTH: 0.441828
G1 F9024.649
G1 X98.595 Y102.361 E.01234
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.347 Y102.073 E.01369
; LINE_WIDTH: 0.528127
G1 F7419.519
G1 X98.306 Y102.034 E.00225
; LINE_WIDTH: 0.5697
G1 F6833.972
G1 X98.264 Y101.995 E.00245
; LINE_WIDTH: 0.611274
G1 F6334.089
G1 X98.223 Y101.956 E.00264
G1 X98.695 Y102.992 F30000
; LINE_WIDTH: 0.378275
G1 F10734.898
G1 X98.702 Y103.327 E.00916
G1 X98.675 Y103.392 E.00191
G1 X99.161 Y103.851 E.01827
; LINE_WIDTH: 0.41694
G1 F9625.167
G3 X100.24 Y104.919 I-74.889 J76.772 E.04628
G1 X100.986 Y104.174 E.03214
G1 X100.395 Y104.05 E.0184
G1 X99.692 Y103.758 E.02319
G1 X99.398 Y103.58 E.01047
; LINE_WIDTH: 0.378969
G1 F10712.75
G3 X98.741 Y103.031 I10.513 J-13.255 E.02346
G1 X100.263 Y104.351 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X100.194 Y104.391 E.00242
G1 X100.251 Y104.424 E.002
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9726.05
G1 X100.194 Y104.391 E-.34432
G1 X100.263 Y104.351 E-.41568
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 15/30
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
M106 S237.15
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z3.2 I-1.206 J-.163 P1  F30000
G1 X94.964 Y143.538 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z3.4 F30000
G1 X81.345 Y142.345 Z3.4
G1 Z3
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z3.4 F30000
G1 X95.153 Y143.945 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 15 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer15 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z3.4 F30000
M73 P81 R5
G1 X92.366 Y109.965 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32509
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z3.4 F30000
G1 X95.613 Y133.039 Z3.4
G1 Z3
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z3.4 F30000
G1 X96.888 Y114.504 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231709
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231718
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.2177
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21685
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21685
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13958
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z3.4 F30000
G1 X145.197 Y77.807 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z3.4 F30000
G1 Z3
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z3.4 F30000
G1 X112.992 Y88.732 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X126.903 Y87.395 E.29775
G1 X132.482 Y92.974 E.24244
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.126 Y89.839 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.277 Y90.99 E.05401
G1 X122.31 Y84.958 E.28298
G1 X125.188 Y87.837 E.13504
G1 X119.156 Y93.869 E.28298
G1 X122.034 Y96.747 E.13504
G1 X128.067 Y90.715 E.28298
G1 X130.325 Y92.974 E.10597
G1 X127.309 Y95.99 E.14149
G1 X117.035 Y85.715 E.48201
G1 X118.186 Y84.564 E.05401
G1 X124.406 Y99.407 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38323
G1 F3000;_EXTRUDE_SET_SPEED
G1 X124.293 Y99.481 E.00373
G1 X124.181 Y99.407 E.00373
G1 X113.618 Y88.844 E.41424
G1 X113.544 Y88.732 E.00373
G1 X113.618 Y88.619 E.00373
G1 X119.938 Y82.299 E.24786
G1 X120.051 Y82.225 E.00373
G1 X120.163 Y82.299 E.00373
G1 X130.726 Y92.862 E.41424
G1 X130.8 Y92.974 E.00373
G3 X130.726 Y93.087 I-.311 J-.124 E.00376
G1 X124.448 Y99.364 E.24619
; Slow Down End
; OBJECT_ID: 258
; WIPE_START
G1 X125.862 Y97.95 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X118.343 Y99.258 Z3.4 F30000
G1 X100.346 Y102.387 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.302 Y102.357 E.00176
G3 X101.561 Y97.31 I1.36 J-2.341 E.23153
G3 X103.01 Y97.667 I.08 J2.791 E.0501
G3 X100.619 Y102.514 I-1.347 J2.349 E.27091
G1 X100.401 Y102.412 E.00801
G1 X100.526 Y102.022 F30000
G1 F8843.478
G1 X100.505 Y102.005 E.00088
G3 X101.588 Y97.716 I1.157 J-1.989 E.19713
G3 X102.536 Y97.887 I.084 J2.247 E.0322
G3 X100.775 Y102.139 I-.873 J2.129 E.24034
G1 X100.58 Y102.047 E.00713
M204 S250
G1 X100.7 Y101.67 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.702 Y101.665 E.00016
G3 X101.614 Y98.107 I.961 J-1.65 E.15184
G3 X102.149 Y98.17 I.008 J2.26 E.0166
G3 X100.925 Y101.776 I-.487 J1.846 E.19242
G1 X100.754 Y101.696 E.00581
; WIPE_START
M204 S10000
G1 X100.702 Y101.665 E-.02297
G1 X100.491 Y101.531 E-.09483
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09497
G1 X100 Y100.97 E-.09494
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09495
G1 X99.748 Y100.074 E-.07243
; WIPE_END
G1 E-.04 F1800
G1 X97.203 Y93.64 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.198 Y93.645 E.00024
G3 X94.491 Y90.239 I-2.615 J-.701 E.39656
G3 X97.22 Y92.334 I.089 J2.71 E.12365
G3 X97.267 Y93.297 I-2.637 J.611 E.03218
G1 X97.214 Y93.581 E.00957
G1 X96.804 Y93.539 F30000
G1 F8843.478
G3 X95.114 Y95.182 I-2.222 J-.595 E.08207
G3 X94.517 Y90.645 I-.531 J-2.238 E.25527
G3 X96.818 Y93.481 I.065 J2.299 E.13996
M204 S250
G1 X96.434 Y93.44 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.543 Y91.036 I-1.843 J-.496 E.25943
G3 X95.078 Y91.099 I.007 J2.262 E.01659
G3 X96.449 Y93.382 I-.486 J1.845 E.09057
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11778
G1 X96.238 Y93.899 E-.09497
G1 X96.099 Y94.107 E-.09495
G1 X95.934 Y94.295 E-.09497
G1 X95.746 Y94.46 E-.09496
G1 X95.539 Y94.599 E-.09497
G1 X95.314 Y94.709 E-.09496
G1 X95.134 Y94.77 E-.07245
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y96.843 Z3.4 F30000
G1 X108.713 Y98.601 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X102.591 Y92.479 E.3093
M73 P81 R4
G1 X108.67 Y98.559 E.2852
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X102.879 Y92.191 E.3228
G1 X109.246 Y98.559 E.2987
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X103.156 Y91.914 E.31106
G1 X109.8 Y98.559 E.28873
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.124 Y95.567 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X105.095 Y95.579 E.00097
G3 X105.021 Y95.838 I-.299 J.054 E.00856
G1 X104.81 Y95.97 E.00766
G1 X104.231 Y95.83 E.01829
G1 X100.225 Y94.757 E.12742
G1 X100 Y94.722 E.00702
G1 X99.77 Y94.461 E.01069
G2 X98.528 Y89.808 I-447.278 J116.833 E.14797
G3 X98.656 Y89.52 I.355 J-.014 E.01001
G1 X98.911 Y89.354 E.00936
G1 X95.998 Y86.44 E.12659
G1 X92.927 Y89.511 E.13342
; LINE_WIDTH: 0.439783
G1 F9071.152
G1 X92.673 Y89.793 E.01228
; LINE_WIDTH: 0.490491
G1 F8043.427
G3 X91.795 Y90.694 I-8.396 J-7.307 E.04591
; LINE_WIDTH: 0.47357
G1 F8359.457
G1 X91.471 Y90.992 E.01544
; LINE_WIDTH: 0.420267
G1 F9540.3
G1 X91.148 Y91.29 E.01353
G1 X88.08 Y94.358 E.13342
G1 X90.993 Y97.272 E.12668
G1 X91.283 Y96.922 E.01398
G1 X91.447 Y96.889 E.00513
G1 X95.852 Y98.07 E.14025
G1 X95.961 Y98.149 E.00413
G1 X96.058 Y98.355 E.007
G1 X96.052 Y98.533 E.00549
G1 X96.334 Y98.624 E.00911
M73 P82 R4
G1 X96.445 Y98.766 E.00554
G1 X97.605 Y103.095 E.1378
G3 X97.194 Y103.473 I-.393 J-.015 E.01906
G1 X100.24 Y106.519 E.13245
G1 X102.991 Y103.768 E.11962
; LINE_WIDTH: 0.438658
G1 F9096.939
G1 X103.247 Y103.486 E.01228
; LINE_WIDTH: 0.485234
G1 F8139.015
G3 X104.497 Y102.209 I43.912 J41.75 E.06441
; LINE_WIDTH: 0.47612
G1 F8310.249
G1 X104.793 Y101.939 E.01415
; LINE_WIDTH: 0.420827
G1 F9526.171
G1 X105.09 Y101.669 E.01235
G1 X108.158 Y98.601 E.13362
G1 X105.167 Y95.61 E.13028
; WIPE_START
G1 X106.581 Y97.024 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.688 Y100.301 Z3.4 F30000
G1 X98.651 Y100.794 Z3.4
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X98.552 Y100.04 E.02338
G1 X98.652 Y99.236 E.0249
G1 X98.956 Y98.485 E.02488
G3 X99.562 Y97.74 I3.755 J2.436 E.02959
G1 X100.082 Y97.341 E.02014
G1 X100.828 Y97.025 E.02489
G1 X101.532 Y96.92 E.02189
G3 X102.864 Y97.159 I.095 J3.304 E.04188
G1 X103.523 Y97.539 E.02338
G1 X104.1 Y98.107 E.02488
G1 X104.511 Y98.805 E.02489
G1 X104.727 Y99.586 E.02488
G1 X104.733 Y100.396 E.02488
G1 X104.53 Y101.18 E.02488
; LINE_WIDTH: 0.436818
G1 F9139.433
G1 X104.345 Y101.54 E.01301
; LINE_WIDTH: 0.477752
G1 F8279.073
G1 X104.16 Y101.901 E.01437
G1 X103.847 Y102.253 E.01667
; LINE_WIDTH: 0.50575
G1 F7778.234
G1 X103.26 Y102.734 E.02862
; LINE_WIDTH: 0.51229
G1 F7669.855
G1 X103 Y102.824 E.01052
; LINE_WIDTH: 0.47537
G1 F8324.662
G1 X102.741 Y102.915 E.00969
; LINE_WIDTH: 0.42098
G1 F9522.309
G1 X102.481 Y103.005 E.00847
G1 X101.679 Y103.117 E.02495
G1 X100.875 Y103.018 E.02495
G1 X100.125 Y102.714 E.02495
G3 X99.441 Y102.189 I6.265 J-8.856 E.02655
G1 X98.98 Y101.588 E.02335
G1 X98.668 Y100.852 E.02462
G1 X95.793 Y95.801 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X95.012 Y96.017 E.02489
G1 X94.203 Y96.023 E.02488
G1 X93.422 Y95.821 E.0248
G3 X92.675 Y95.39 I1.111 J-2.787 E.02656
G1 X92.137 Y94.852 E.02339
G1 X91.727 Y94.154 E.02489
G1 X91.511 Y93.373 E.02488
G1 X91.504 Y92.564 E.02489
G1 X91.708 Y91.78 E.02488
; LINE_WIDTH: 0.436815
G1 F9139.491
G1 X91.893 Y91.419 E.01301
; LINE_WIDTH: 0.4831
G1 F8178.476
G1 X92.078 Y91.058 E.01454
G1 X92.65 Y90.473 E.02937
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X93.01 Y90.281 E.01433
; LINE_WIDTH: 0.420714
G1 F9529.01
G3 X93.802 Y89.942 I1.434 J2.255 E.02664
G1 X94.462 Y89.848 E.0205
G3 X95.422 Y89.959 I.162 J2.818 E.0299
G1 X96.113 Y90.245 E.02304
G1 X96.759 Y90.733 E.02493
G1 X97.258 Y91.372 E.02494
G3 X97.605 Y92.261 I-2.465 J1.476 E.02952
G1 X97.687 Y92.93 E.02077
G1 X97.643 Y93.436 E.01562
G1 X97.458 Y94.11 E.02152
G1 X97.059 Y94.813 E.02488
G3 X96.452 Y95.42 I-6.284 J-5.677 E.02645
G1 X95.845 Y95.771 E.02158
G1 X105.2 Y96.176 F30000
; LINE_WIDTH: 0.41999
G1 F9547.301
G1 X104.864 Y96.343 E.01152
G1 X104.424 Y96.272 E.01371
G1 X100.17 Y95.133 E.1353
G1 X99.849 Y95.069 E.01007
G1 X99.528 Y94.786 E.01314
G1 X99.376 Y94.428 E.01197
G1 X98.164 Y89.905 E.14386
G1 X98.153 Y89.664 E.00741
G1 X98.338 Y89.315 E.01216
G1 X95.998 Y86.974 E.10172
G1 X93.232 Y89.739 E.12018
G1 X93.75 Y89.568 E.01676
G1 X94.409 Y89.475 E.02046
G1 X94.983 Y89.488 E.01764
G1 X95.554 Y89.606 E.01793
G1 X96.257 Y89.897 E.02338
G3 X97.093 Y90.538 I-3.933 J5.992 E.03241
G1 X97.557 Y91.142 E.02339
G1 X97.818 Y91.664 E.01793
G1 X97.979 Y92.215 E.01765
G1 X98.06 Y92.879 E.02054
G1 X98.018 Y93.471 E.01824
G1 X97.822 Y94.211 E.02353
G1 X97.386 Y95.002 E.02773
G3 X96.641 Y95.747 I-5.459 J-4.713 E.03241
G1 X95.982 Y96.127 E.02339
G1 X95.11 Y96.381 E.02789
G1 X94.203 Y96.4 E.02788
G1 X93.324 Y96.185 E.02779
G1 X92.811 Y95.939 E.01748
G1 X92.409 Y95.657 E.01511
G1 X91.871 Y95.119 E.02339
G1 X91.4 Y94.342 E.02789
G1 X91.147 Y93.471 E.02788
G1 X91.127 Y92.564 E.02789
G1 X91.344 Y91.682 E.02788
G1 X91.382 Y91.589 E.0031
G1 X88.613 Y94.358 E.12034
G1 X90.954 Y96.699 E.10172
G1 X91.301 Y96.514 E.01209
G1 X91.544 Y96.525 E.00749
G1 X95.95 Y97.705 E.14015
G1 X96.243 Y97.896 E.01073
G1 X96.378 Y98.105 E.00766
G1 X96.41 Y98.246 E.00444
G1 X96.649 Y98.402 E.00876
G1 X96.809 Y98.669 E.00957
G1 X97.969 Y102.999 E.13773
G1 X97.982 Y103.224 E.00693
G1 X97.815 Y103.561 E.01155
G1 X100.24 Y105.986 E.10537
G1 X103.047 Y103.179 E.12195
G1 X102.483 Y103.392 E.01852
G1 X101.728 Y103.491 E.02339
G1 X100.826 Y103.392 E.02789
G1 X99.98 Y103.062 E.02789
G3 X99.142 Y102.418 I3.351 J-5.228 E.03251
G1 X98.681 Y101.817 E.02329
G1 X98.316 Y100.986 E.02789
G1 X98.178 Y100.089 E.02788
G1 X98.278 Y99.187 E.0279
G1 X98.607 Y98.341 E.02788
G3 X99.249 Y97.505 I5.327 J3.423 E.03242
G1 X99.852 Y97.042 E.02338
G3 X100.821 Y96.639 I3.303 J6.578 E.03225
G1 X101.479 Y96.546 E.02044
G1 X102.054 Y96.559 E.01766
G3 X103.053 Y96.832 I-.342 J3.218 E.03195
G1 X103.712 Y97.213 E.02338
G1 X104.367 Y97.841 E.02789
G1 X104.838 Y98.617 E.0279
G1 X105.091 Y99.488 E.02788
G1 X105.11 Y100.396 E.02789
G1 X104.894 Y101.277 E.02789
G1 X104.856 Y101.37 E.0031
G1 X107.625 Y98.601 E.12034
G1 X105.242 Y96.218 E.10353
G1 X105.121 Y96.631 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.918 Y96.716 E.00676
G1 X104.539 Y96.694 E.01169
G1 X104.036 Y96.559 E.016
; LINE_WIDTH: 0.439572
G1 F9075.983
G1 X103.847 Y96.529 E.00618
; LINE_WIDTH: 0.478734
G1 F8260.41
G1 X103.658 Y96.498 E.00679
; LINE_WIDTH: 0.517897
G1 F7579.327
G1 X103.469 Y96.468 E.0074
; LINE_WIDTH: 0.557059
G1 F7002.001
G1 X103.28 Y96.438 E.00801
G1 X103.435 Y96.55 E.00801
; LINE_WIDTH: 0.517897
G1 F7579.327
G1 X103.59 Y96.662 E.0074
; LINE_WIDTH: 0.478734
G1 F8260.41
G1 X103.745 Y96.774 E.00679
; LINE_WIDTH: 0.420405
G1 F9536.811
G1 X103.9 Y96.886 E.00588
G1 X104.634 Y97.574 E.03093
G1 X104.784 Y97.769 E.00757
G1 X105.164 Y98.428 E.02342
G1 X105.455 Y99.391 E.03093
G1 X105.487 Y100.205 E.02507
G1 X107.092 Y98.601 E.06978
G1 X105.163 Y96.673 E.08387
G1 X105.032 Y97.033 F30000
; LINE_WIDTH: 0.363404
G1 F11233.015
G1 X104.968 Y97.06 E.00181
G1 X104.588 Y97.037 E.00995
G1 X105.028 Y97.497 E.01661
; LINE_WIDTH: 0.412871
G1 F9731.027
G1 X105.491 Y98.24 E.0264
G3 X105.825 Y99.334 I-7.412 J2.861 E.03453
G1 X106.558 Y98.601 E.03127
G3 X105.364 Y97.383 I27.535 J-28.203 E.05143
; LINE_WIDTH: 0.373615
G1 F10886.163
G1 X105.073 Y97.076 E.01139
G1 X106.048 Y98.56 F30000
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X105.977 Y98.601 E.00251
G1 X106.037 Y98.635 E.00212
G1 X102.121 Y96.117 F30000
; LINE_WIDTH: 0.53709
G1 F7284.942
G1 X102.665 Y96.242 E.02248
; LINE_WIDTH: 0.53185
G1 F7363.018
G1 X102.944 Y96.331 E.01166
; LINE_WIDTH: 0.56171
G1 F6939.224
G1 X103.223 Y96.419 E.01238
G1 X102.121 Y96.117 F30000
; LINE_WIDTH: 0.534382
G1 F7325.088
G1 X101.958 Y96.05 E.00706
; LINE_WIDTH: 0.488625
G1 F8077.092
G1 X101.795 Y95.982 E.00641
; LINE_WIDTH: 0.420948
G1 F9523.115
G1 X101.632 Y95.915 E.00543
G1 X100.115 Y95.508 E.04838
G1 X99.8 Y95.457 E.00986
G1 X99.579 Y95.347 E.00758
G1 X99.245 Y95.036 E.01406
G1 X99.018 Y94.551 E.01651
G1 X98.783 Y93.673 E.02799
; LINE_WIDTH: 0.436803
G1 F9139.781
G1 X98.68 Y93.351 E.01087
; LINE_WIDTH: 0.470428
G1 F8420.905
G1 X98.576 Y93.028 E.01179
; LINE_WIDTH: 0.501755
G1 F7845.958
G1 X98.538 Y92.943 E.00348
; LINE_WIDTH: 0.530785
G1 F7379.09
G1 X98.5 Y92.858 E.0037
; LINE_WIDTH: 0.524415
G1 F7476.713
G1 X98.465 Y93.074 E.00858
; LINE_WIDTH: 0.482645
G1 F8186.936
G1 X98.429 Y93.29 E.00783
; LINE_WIDTH: 0.424827
G1 F9426.392
G1 X98.394 Y93.506 E.0068
G1 X98.185 Y94.312 E.02592
G1 X97.713 Y95.19 E.03103
G3 X96.893 Y96.033 I-5.695 J-4.716 E.03663
G1 X96.17 Y96.454 E.02603
G1 X95.943 Y96.548 E.00766
G1 X95.208 Y96.745 E.02369
G3 X94.118 Y96.798 I-1.375 J-16.946 E.03397
G3 X96.208 Y97.4 I-91.719 J322.419 E.0677
G1 X96.592 Y97.735 E.01586
G2 X97.055 Y98.305 I1.837 J-1.019 E.02296
G1 X97.248 Y98.853 E.01807
; LINE_WIDTH: 0.435355
G1 F9173.494
G1 X97.405 Y99.377 E.01751
; LINE_WIDTH: 0.466085
G1 F8507.32
G1 X97.561 Y99.902 E.01888
; LINE_WIDTH: 0.505402
G1 F7784.092
G1 X97.609 Y99.985 E.0036
; LINE_WIDTH: 0.553305
G1 F7053.499
G1 X97.656 Y100.069 E.00398
; LINE_WIDTH: 0.601209
G1 F6448.281
G1 X97.703 Y100.152 E.00435
; LINE_WIDTH: 0.604643
G1 F6408.853
G1 X97.743 Y99.949 E.00947
; LINE_WIDTH: 0.563609
G1 F6913.917
G1 X97.783 Y99.746 E.00878
; LINE_WIDTH: 0.522575
G1 F7505.394
G1 X97.823 Y99.543 E.00808
; LINE_WIDTH: 0.481541
G1 F8207.541
G1 X97.864 Y99.34 E.00739
; LINE_WIDTH: 0.420817
G1 F9526.412
G1 X97.904 Y99.137 E.00637
G3 X98.315 Y98.083 I7.29 J2.236 E.03487
G3 X99.019 Y97.206 I5.561 J3.742 E.03468
G1 X99.623 Y96.743 E.02344
G3 X100.768 Y96.266 I2.942 J5.453 E.03826
G1 X101.427 Y96.173 E.02048
; LINE_WIDTH: 0.439962
G1 F9067.059
G1 X101.638 Y96.156 E.00687
; LINE_WIDTH: 0.479905
G1 F8238.269
G1 X101.85 Y96.14 E.00756
; LINE_WIDTH: 0.519849
G1 F7548.305
G1 X102.062 Y96.123 E.00825
G1 X100.394 Y95.977 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X99.677 Y95.814 E.02257
G1 X99.369 Y95.66 E.01059
G1 X98.963 Y95.286 E.01697
G1 X98.677 Y94.753 E.01857
G1 X98.57 Y94.334 E.01329
G1 X98.42 Y94.719 E.01271
G1 X98.039 Y95.379 E.02339
G3 X97.018 Y96.4 I-3.999 J-2.978 E.04453
G1 X96.359 Y96.78 E.02339
G1 X95.972 Y96.931 E.01275
G1 X96.37 Y97.06 E.01286
G1 X96.829 Y97.421 E.01794
G2 X97.372 Y98.101 I6.679 J-4.779 E.02675
G1 X97.616 Y98.754 E.02142
G1 X97.91 Y98.052 E.02338
G3 X98.546 Y97.15 I5.972 J3.533 E.03394
G3 X99.692 Y96.271 I3.577 J3.475 E.04453
G1 X100.338 Y96 E.02154
G1 X99.297 Y96.055 F30000
G1 F9547.299
G1 X98.878 Y95.738 E.01613
G3 X98.538 Y95.27 I.64 J-.824 E.01803
G1 X98.224 Y95.775 E.01828
G3 X97.321 Y96.654 I-7.804 J-7.115 E.03874
G1 X96.823 Y96.948 E.01778
G1 X97.122 Y97.183 E.0117
G2 X97.616 Y97.799 I4.805 J-3.355 E.02427
G3 X98.247 Y96.921 I7.267 J4.555 E.03323
G3 X99.247 Y96.088 I5.663 J5.785 E.04003
G1 X97.582 Y97.032 F30000
; LINE_WIDTH: 0.565204
G1 F6892.811
G1 X97.758 Y96.845 E.01093
; LINE_WIDTH: 0.52577
G1 F7455.732
G1 X97.934 Y96.658 E.01011
; LINE_WIDTH: 0.499324
G1 F7887.749
G3 X98.524 Y96.089 I4.315 J3.882 E.0305
G1 X94.118 Y96.798 F30000
; LINE_WIDTH: 0.462484
G1 F8580.347
G3 X93.099 Y96.526 I1.861 J-9.021 E.03608
G1 X90.75 Y92.754 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X89.146 Y94.358 E.06971
G1 X91.024 Y96.236 E.08159
G1 X91.327 Y96.131 E.00987
G1 X91.642 Y96.161 E.00971
G1 X92.535 Y96.4 E.02841
; LINE_WIDTH: 0.433323
G1 F9221.253
G1 X92.788 Y96.454 E.00824
; LINE_WIDTH: 0.451154
G1 F8818.489
G1 X93.041 Y96.508 E.00861
G1 X92.602 Y96.253 E.01691
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X92.142 Y95.924 E.01737
G1 X91.604 Y95.385 E.02339
G1 X91.454 Y95.19 E.00756
G1 X91.074 Y94.531 E.02339
G1 X90.782 Y93.569 E.03089
G1 X90.753 Y92.814 E.0232
G1 X90.413 Y93.625 F30000
G1 F9547.299
G1 X89.679 Y94.358 E.03187
G1 X91.116 Y95.795 E.06244
G3 X91.455 Y95.77 I.209 J.517 E.01061
G1 X91.128 Y95.379 E.01568
G1 X90.747 Y94.72 E.02339
G3 X90.423 Y93.684 I5.445 J-2.272 E.03339
G1 X90.237 Y94.317 F30000
; LINE_WIDTH: 0.42048
G1 F9534.908
G1 X90.166 Y94.358 E.00251
G1 X90.226 Y94.393 E.00212
; WIPE_START
G1 X90.166 Y94.358 E-.34773
G1 X90.237 Y94.317 E-.41227
; WIPE_END
G1 E-.04 F1800
G1 X97.398 Y91.678 Z3.4 F30000
G1 X98.147 Y91.402 Z3.4
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.45529
G1 F8730.024
G1 X98.327 Y92.002 E.02105
; LINE_WIDTH: 0.454397
G1 F8748.977
G1 X98.381 Y92.268 E.00909
; LINE_WIDTH: 0.48867
G1 F8076.276
G1 X98.435 Y92.534 E.00985
; LINE_WIDTH: 0.522944
G1 F7499.636
G1 X98.489 Y92.8 E.01061
G1 X98.147 Y91.402 F30000
; LINE_WIDTH: 0.459988
G1 F8631.696
G1 X98.085 Y91.117 E.00994
; LINE_WIDTH: 0.420352
G1 F9538.147
G2 X97.8 Y90.003 I-12.348 J2.563 E.03536
G1 X97.781 Y89.601 E.01237
G1 X97.875 Y89.385 E.00726
G1 X95.998 Y87.507 E.08168
G1 X94.405 Y89.099 E.06925
G1 X94.997 Y89.111 E.01821
G1 X95.522 Y89.204 E.01638
G1 X96.402 Y89.548 E.02907
G3 X97.344 Y90.251 I-3.983 J6.329 E.03619
G1 X97.856 Y90.913 E.02573
; LINE_WIDTH: 0.433323
G1 F9221.253
G1 X97.986 Y91.132 E.00811
; LINE_WIDTH: 0.459988
G1 F8631.696
G1 X98.117 Y91.351 E.00866
G1 X97.418 Y89.84 F30000
; LINE_WIDTH: 0.408734
G1 F9841.083
G1 X97.461 Y89.473 E.01102
G3 X95.998 Y88.04 I59.359 J-62.105 E.06105
G1 X95.269 Y88.769 E.03072
G1 X95.843 Y88.909 E.01761
G1 X96.546 Y89.201 E.02269
G1 X96.839 Y89.379 E.01024
G1 X97.371 Y89.803 E.02027
G1 X96.021 Y88.529 F30000
; LINE_WIDTH: 0.41304
G1 F9726.576
G1 X95.951 Y88.569 E.00242
G1 X96.009 Y88.602 E.002
; WIPE_START
G1 X95.951 Y88.569 E-.34436
G1 X96.021 Y88.529 E-.41564
; WIPE_END
G1 E-.04 F1800
G1 X97.235 Y96.064 Z3.4 F30000
G1 X98.179 Y101.915 Z3.4
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.614307
G1 F6300.462
G1 X98.092 Y101.66 E.01254
; LINE_WIDTH: 0.57876
G1 F6718.424
G1 X98.005 Y101.405 E.01176
; LINE_WIDTH: 0.543214
G1 F7195.779
G1 X97.919 Y101.151 E.01098
; LINE_WIDTH: 0.55037
G1 F7094.295
G1 X97.817 Y100.68 E.01989
; LINE_WIDTH: 0.60023
G1 F6459.601
G1 X97.715 Y100.21 E.02184
G1 X98.179 Y101.915 F30000
; LINE_WIDTH: 0.61129
G1 F6333.903
G1 X98.179 Y101.996 E.00372
; LINE_WIDTH: 0.56971
G1 F6833.843
G1 X98.179 Y102.076 E.00345
; LINE_WIDTH: 0.52813
G1 F7419.468
G1 X98.179 Y102.156 E.00318
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.256 Y102.528 E.01369
; LINE_WIDTH: 0.420876
G1 F9524.922
G3 X98.355 Y103.277 I-2.525 J.717 E.02337
G1 X98.269 Y103.482 E.00682
G1 X100.24 Y105.452 E.08584
G1 X101.835 Y103.857 E.06947
G1 X101.531 Y103.865 E.00936
G1 X100.777 Y103.766 E.02344
G1 X99.836 Y103.411 E.03097
G1 X99.174 Y102.944 E.02494
G1 X98.843 Y102.648 E.01368
; LINE_WIDTH: 0.441828
G1 F9024.649
G1 X98.595 Y102.361 E.01234
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.347 Y102.073 E.01369
; LINE_WIDTH: 0.52813
G1 F7419.468
G1 X98.306 Y102.034 E.00225
; LINE_WIDTH: 0.56971
G1 F6833.843
G1 X98.264 Y101.995 E.00245
; LINE_WIDTH: 0.61129
G1 F6333.903
G1 X98.223 Y101.956 E.00264
G1 X98.695 Y102.992 F30000
; LINE_WIDTH: 0.378275
G1 F10734.904
G1 X98.702 Y103.327 E.00916
G1 X98.675 Y103.392 E.00191
G1 X99.161 Y103.851 E.01827
; LINE_WIDTH: 0.416938
G1 F9625.204
G3 X100.24 Y104.919 I-74.897 J76.78 E.04628
G1 X100.986 Y104.174 E.03213
G1 X100.395 Y104.05 E.0184
G1 X99.692 Y103.758 E.02319
G1 X99.398 Y103.58 E.01047
; LINE_WIDTH: 0.378968
G1 F10712.761
G3 X98.741 Y103.031 I10.546 J-13.294 E.02346
G1 X100.263 Y104.351 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X100.194 Y104.391 E.00242
G1 X100.251 Y104.424 E.002
G1 X95.28 Y101.621 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.129 Y100.47 E.05401
G1 X95.772 Y98.826 E.0771
G1 X95.815 Y98.886 E.00243
G1 X96.085 Y98.939 E.00914
G1 X96.548 Y100.665 E.05929
G1 X93.811 Y97.928 E.12839
G1 X92.238 Y97.507 E.05401
; WIPE_START
G1 X93.811 Y97.928 E-.61876
G1 X94.074 Y98.191 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X98.314 Y91.845 Z3.4 F30000
G1 X99.146 Y90.599 Z3.4
G1 Z3
G1 E.8 F1800
G1 F8843.478
G1 X99.568 Y92.172 E.05401
G1 X102.304 Y94.908 E.12839
G1 X100.235 Y94.363 E.07098
G1 X102.109 Y92.49 E.08789
G1 X103.26 Y93.641 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X102.109 Y92.49 E-.61876
G1 X101.846 Y92.753 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 16/30
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
M106 S226.95
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z3.4 I-1.206 J-.163 P1  F30000
G1 X94.964 Y143.538 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z3.6 F30000
G1 X81.345 Y142.345 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z3.6 F30000
G1 X95.153 Y143.945 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 16 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer16 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z3.6 F30000
G1 X92.366 Y109.965 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z3.6 F30000
G1 X95.613 Y133.039 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z3.6 F30000
G1 X96.888 Y114.504 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X91.367 Y107.569 E.01287
G1 X93.353 Y109.554 E.09314
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X91.645 Y107.291 E.02397
G1 X93.907 Y109.554 E.09833
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.217699
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13957
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z3.6 F30000
G1 X145.197 Y77.807 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
M73 P83 R4
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z3.6 F30000
G1 X112.992 Y88.732 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X125.63 Y86.122 E.24244
G1 X132.482 Y92.974 E.29775
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.376 Y88.879 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41153
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X120.055 Y82.201 E.51185
G1 X120.381 Y82.527 E.02501
G1 X113.846 Y89.062 E.50088
G1 X114.172 Y89.388 E.02501
G1 X120.708 Y82.853 E.50088
G1 X121.034 Y83.18 E.02501
G1 X114.499 Y89.715 E.50088
G1 X114.825 Y90.041 E.02501
G1 X121.36 Y83.506 E.50088
G1 X121.687 Y83.832 E.02501
G1 X115.151 Y90.368 E.50088
G1 X115.478 Y90.694 E.02501
G1 X122.013 Y84.159 E.50088
G1 X122.339 Y84.485 E.02501
G1 X115.804 Y91.02 E.50088
G1 X116.13 Y91.347 E.02501
G1 X122.666 Y84.811 E.50088
G1 X122.992 Y85.138 E.02501
G1 X116.457 Y91.673 E.50088
G1 X116.783 Y91.999 E.02501
G1 X123.318 Y85.464 E.50088
G1 X123.645 Y85.79 E.02501
G1 X117.109 Y92.326 E.50088
G1 X117.436 Y92.652 E.02501
G1 X123.971 Y86.117 E.50088
G1 X124.297 Y86.443 E.02501
G1 X117.762 Y92.978 E.50088
G1 X118.088 Y93.305 E.02501
G1 X124.624 Y86.769 E.50088
G1 X124.95 Y87.096 E.02501
G1 X118.415 Y93.631 E.50088
G1 X118.741 Y93.957 E.02501
G1 X125.276 Y87.422 E.50088
G1 X125.603 Y87.748 E.02501
G1 X119.068 Y94.284 E.50088
G1 X119.394 Y94.61 E.02501
G1 X125.929 Y88.075 E.50088
G1 X126.256 Y88.401 E.02501
G1 X119.72 Y94.936 E.50088
G1 X120.047 Y95.263 E.02501
G1 X126.582 Y88.728 E.50088
G1 X126.908 Y89.054 E.02501
G1 X120.373 Y95.589 E.50088
G1 X120.699 Y95.915 E.02501
G1 X127.235 Y89.38 E.50088
G1 X127.561 Y89.707 E.02501
G1 X121.026 Y96.242 E.50088
G1 X121.352 Y96.568 E.02501
G1 X127.887 Y90.033 E.50088
G1 X128.214 Y90.359 E.02501
G1 X121.678 Y96.895 E.50088
G1 X122.005 Y97.221 E.02501
G1 X128.54 Y90.686 E.50088
G1 X128.866 Y91.012 E.02501
G1 X122.331 Y97.547 E.50088
G1 X122.657 Y97.874 E.02501
G1 X129.193 Y91.338 E.50088
G1 X129.519 Y91.665 E.02501
G1 X122.984 Y98.2 E.50088
G1 X123.31 Y98.526 E.02501
G1 X129.845 Y91.991 E.50088
G1 X130.172 Y92.317 E.02501
G1 X123.636 Y98.853 E.50088
G1 X123.963 Y99.179 E.02501
G1 X130.498 Y92.644 E.50088
G1 X130.824 Y92.97 E.02501
G1 X124.146 Y99.649 E.51185
M106 S226.95
; OBJECT_ID: 258
; WIPE_START
G1 X125.56 Y98.234 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X118.029 Y99.475 Z3.6 F30000
G1 X100.346 Y102.387 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.2
G1 F8843.478
G1 X100.301 Y102.36 E.00176
G3 X101.3 Y97.327 I1.355 J-2.346 E.22349
G3 X102.005 Y97.326 I.355 J2.835 E.02342
G3 X100.618 Y102.516 I-.349 J2.687 E.30603
G1 X100.401 Y102.413 E.00801
G1 X100.481 Y101.995 F30000
G1 F8843.478
G1 X100.252 Y101.843 E.00911
G3 X101.354 Y97.732 I1.395 J-1.83 E.18031
G1 X101.639 Y97.713 E.00948
G3 X100.532 Y102.026 I.008 J2.301 E.27861
M204 S250
G1 X100.698 Y101.669 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.491 Y101.532 E.00765
G3 X101.405 Y98.121 I1.156 J-1.518 E.13856
G1 X101.64 Y98.106 E.00724
G3 X100.751 Y101.698 I.007 J1.908 E.21309
; WIPE_START
M204 S10000
G1 X100.491 Y101.532 E-.11736
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09494
G1 X99.889 Y100.746 E-.09497
G1 X99.809 Y100.51 E-.09495
G1 X99.763 Y100.279 E-.08954
G1 X99.748 Y100.073 E-.07827
; WIPE_END
G1 E-.04 F1800
G1 X97.202 Y93.646 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X97.201 Y93.646 E.00005
G3 X94.229 Y90.256 I-2.617 J-.703 E.38814
G3 X94.933 Y90.255 I.355 J2.839 E.02342
G3 X97.268 Y93.315 I-.349 J2.687 E.14197
G1 X97.214 Y93.587 E.00919
G1 X96.798 Y93.537 F30000
G1 F8843.478
G3 X94.283 Y90.66 I-2.222 J-.595 E.32994
G1 X94.568 Y90.642 E.00948
G3 X96.812 Y93.479 I.008 J2.301 E.1381
M204 S250
G1 X96.419 Y93.436 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.334 Y91.05 I-1.843 J-.493 E.25351
G1 X94.569 Y91.035 E.00724
G3 X96.434 Y93.378 I.007 J1.908 E.1058
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11758
G1 X96.238 Y93.899 E-.09496
G1 X96.099 Y94.107 E-.09494
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09496
G1 X95.539 Y94.599 E-.09494
G1 X95.314 Y94.709 E-.09499
G1 X95.133 Y94.771 E-.07265
; WIPE_END
G1 E-.04 F1800
G1 X102.479 Y96.843 Z3.6 F30000
G1 X108.713 Y98.601 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.073 E.39746
G1 X87.525 Y94.358 E.59649
G1 X95.998 Y85.886 E.39746
G1 X102.119 Y92.008 E.28719
G1 X108.67 Y98.559 E.30731
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X102.407 Y91.72 E.30069
G1 X109.246 Y98.559 E.32081
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X102.684 Y91.443 E.29058
G1 X109.8 Y98.559 E.30922
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.124 Y95.567 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X105.095 Y95.579 E.00097
G3 X105.021 Y95.838 I-.299 J.054 E.00856
G1 X104.81 Y95.97 E.00767
G1 X104.002 Y95.769 E.02557
G1 X100.225 Y94.757 E.12013
G1 X100 Y94.722 E.00702
G1 X99.77 Y94.461 E.01069
G2 X98.528 Y89.808 I-486.505 J127.299 E.14797
G3 X98.656 Y89.52 I.355 J-.014 E.01001
G1 X98.911 Y89.354 E.00936
G1 X95.998 Y86.44 E.12659
G1 X92.926 Y89.512 E.13348
; LINE_WIDTH: 0.439775
G1 F9071.324
G1 X92.672 Y89.794 E.01225
; LINE_WIDTH: 0.490476
G1 F8043.695
G3 X91.795 Y90.694 I-8.374 J-7.287 E.04587
; LINE_WIDTH: 0.473563
G1 F8359.603
G1 X91.471 Y90.992 E.01544
; LINE_WIDTH: 0.420267
G1 F9540.298
G1 X91.148 Y91.29 E.01353
G1 X88.08 Y94.358 E.13342
G1 X90.993 Y97.272 E.12668
G1 X91.283 Y96.922 E.01398
G1 X91.447 Y96.889 E.00513
G1 X95.852 Y98.07 E.14025
G1 X95.961 Y98.149 E.00413
G1 X96.058 Y98.355 E.007
G1 X96.052 Y98.533 E.00549
G1 X96.334 Y98.624 E.00911
G1 X96.445 Y98.766 E.00554
G1 X97.605 Y103.095 E.1378
G3 X97.194 Y103.473 I-.393 J-.015 E.01906
G1 X100.24 Y106.519 E.13245
G1 X102.991 Y103.768 E.11962
; LINE_WIDTH: 0.438628
G1 F9097.629
G1 X103.247 Y103.486 E.01228
; LINE_WIDTH: 0.484148
G1 F8159.046
G3 X104.137 Y102.579 I8.447 J7.402 E.04572
; LINE_WIDTH: 0.505755
G1 F7778.15
G1 X104.738 Y101.942 E.03303
; LINE_WIDTH: 0.512249
G1 F7670.536
G1 X104.961 Y101.745 E.01138
; LINE_WIDTH: 0.475345
G1 F8325.143
G1 X105.184 Y101.549 E.01048
; LINE_WIDTH: 0.420642
G1 F9530.819
G1 X105.407 Y101.352 E.00916
G1 X108.158 Y98.601 E.11973
G1 X105.167 Y95.61 E.13021
; WIPE_START
G1 X106.581 Y97.024 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.399 Y101.5 Z3.6 F30000
G1 X99.443 Y102.191 Z3.6
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X98.98 Y101.587 E.02339
G1 X98.664 Y100.842 E.02488
G1 X98.552 Y100.045 E.02474
G1 X98.582 Y99.586 E.01412
G1 X98.777 Y98.855 E.02325
G1 X99.011 Y98.403 E.01565
G1 X99.443 Y97.839 E.02184
M73 P84 R4
G1 X100.082 Y97.341 E.02488
G1 X100.828 Y97.025 E.02489
G1 X101.612 Y96.914 E.02432
G3 X102.481 Y97.025 I.069 J2.923 E.02703
G1 X103.184 Y97.316 E.02338
G1 X103.828 Y97.802 E.02479
G1 X104.329 Y98.443 E.02498
G1 X104.64 Y99.177 E.0245
G1 X104.757 Y99.991 E.02526
G1 X104.657 Y100.794 E.02488
; LINE_WIDTH: 0.440363
G1 F9057.914
G1 X104.524 Y101.177 E.01314
; LINE_WIDTH: 0.487828
G1 F8091.567
G1 X104.391 Y101.561 E.01471
G1 X103.889 Y102.21 E.02974
; LINE_WIDTH: 0.505765
G1 F7777.982
G1 X103.26 Y102.733 E.03086
; LINE_WIDTH: 0.512257
G1 F7670.4
G1 X103.001 Y102.824 E.01052
; LINE_WIDTH: 0.47535
G1 F8325.046
G1 X102.741 Y102.915 E.0097
; LINE_WIDTH: 0.421437
G1 F9510.8
G1 X102.481 Y103.005 E.00849
G1 X101.679 Y103.117 E.02498
G1 X100.875 Y103.018 E.02498
G1 X100.125 Y102.714 E.02498
G3 X99.49 Y102.229 I6.282 J-8.878 E.02463
G1 X95.748 Y95.82 F30000
; LINE_WIDTH: 0.419989
G1 F9547.328
G1 X95.013 Y96.017 E.02338
G1 X94.203 Y96.023 E.02489
G1 X93.423 Y95.822 E.02474
G3 X92.675 Y95.39 I1.112 J-2.793 E.02662
G1 X92.137 Y94.852 E.02339
G1 X91.728 Y94.159 E.02474
G3 X91.504 Y93.325 I2.762 J-1.188 E.02662
G1 X91.504 Y92.564 E.02339
G1 X91.708 Y91.78 E.02488
; LINE_WIDTH: 0.436815
G1 F9139.491
G1 X91.893 Y91.419 E.01302
; LINE_WIDTH: 0.483101
G1 F8178.457
G1 X92.078 Y91.058 E.01455
G1 X92.65 Y90.473 E.02936
; LINE_WIDTH: 0.47357
G1 F8359.457
G1 X93.01 Y90.281 E.0143
; LINE_WIDTH: 0.420709
G1 F9529.136
G3 X93.804 Y89.941 I1.43 J2.246 E.02671
G1 X94.54 Y89.843 E.02288
G1 X94.996 Y89.868 E.01405
G3 X95.793 Y90.088 I-.595 J3.717 E.0255
G1 X96.452 Y90.468 E.02343
G1 X97.029 Y91.036 E.02493
G1 X97.44 Y91.734 E.02494
G1 X97.656 Y92.515 E.02493
G3 X97.652 Y93.392 I-2.895 J.427 E.0271
G1 X97.459 Y94.109 E.02287
G1 X97.059 Y94.813 E.02492
G3 X96.452 Y95.42 I-6.282 J-5.675 E.02644
G1 X95.802 Y95.795 E.0231
G1 X105.2 Y96.176 F30000
; LINE_WIDTH: 0.41999
G1 F9547.305
G1 X104.863 Y96.343 E.01155
G1 X104.636 Y96.329 E.00698
G1 X100.17 Y95.133 E.14207
G1 X99.849 Y95.069 E.01007
G1 X99.528 Y94.786 E.01314
G1 X99.376 Y94.428 E.01197
G1 X98.164 Y89.905 E.14386
G1 X98.153 Y89.662 E.00749
G1 X98.338 Y89.315 E.01209
G1 X95.998 Y86.974 E.10172
G1 X93.232 Y89.739 E.12016
G1 X93.754 Y89.568 E.01688
G1 X94.491 Y89.469 E.02284
G3 X95.982 Y89.761 I.035 J3.779 E.047
G1 X96.641 Y90.141 E.02338
G3 X97.386 Y90.887 I-4.659 J5.404 E.03241
G1 X97.767 Y91.546 E.02339
G1 X98.02 Y92.417 E.02788
G1 X98.063 Y92.99 E.01765
G1 X98.016 Y93.49 E.01542
G1 X97.823 Y94.207 E.02282
G1 X97.386 Y95.002 E.02786
G3 X96.641 Y95.747 I-5.46 J-4.715 E.03241
G1 X95.982 Y96.127 E.02339
G1 X95.11 Y96.381 E.02788
G1 X94.203 Y96.4 E.02789
G1 X93.326 Y96.186 E.02773
G1 X92.811 Y95.939 E.01754
G1 X92.409 Y95.657 E.01511
G1 X91.87 Y95.119 E.02339
G1 X91.402 Y94.347 E.02773
G1 X91.213 Y93.809 E.01753
G1 X91.127 Y93.325 E.01511
G1 X91.127 Y92.564 E.02339
G1 X91.344 Y91.682 E.02788
G1 X91.382 Y91.589 E.0031
G1 X88.613 Y94.358 E.12033
G1 X90.954 Y96.699 E.10172
G1 X91.301 Y96.514 E.01209
G1 X91.544 Y96.525 E.00749
G1 X95.95 Y97.705 E.14015
G1 X96.243 Y97.896 E.01073
G1 X96.378 Y98.105 E.00766
G1 X96.41 Y98.246 E.00444
G1 X96.649 Y98.402 E.00876
G1 X96.785 Y98.599 E.00736
G3 X97.969 Y102.999 I-419.04 J115.118 E.14
G1 X97.982 Y103.224 E.00693
G1 X97.815 Y103.561 E.01155
G1 X100.24 Y105.986 E.10537
G1 X103.047 Y103.179 E.12195
G1 X102.483 Y103.392 E.01851
G1 X101.728 Y103.491 E.02339
G1 X100.826 Y103.392 E.02789
G1 X99.98 Y103.062 E.02789
G3 X99.142 Y102.418 I3.348 J-5.224 E.03251
G1 X98.681 Y101.817 E.02329
G1 X98.316 Y100.986 E.02788
G1 X98.178 Y100.094 E.02773
G1 X98.218 Y99.489 E.01864
G1 X98.412 Y98.758 E.02325
G1 X98.649 Y98.259 E.01696
G3 X99.249 Y97.505 I6.504 J4.554 E.02963
G1 X99.852 Y97.042 E.02338
G3 X100.825 Y96.639 I3.23 J6.418 E.03239
G1 X101.562 Y96.54 E.02283
G3 X102.555 Y96.653 I.126 J3.335 E.03084
G1 X103.328 Y96.968 E.02565
G1 X104.058 Y97.503 E.02779
G1 X104.628 Y98.213 E.02798
G1 X104.988 Y99.033 E.0275
G1 X105.13 Y99.941 E.02826
G1 X105.031 Y100.844 E.02789
G1 X104.818 Y101.407 E.01852
G1 X107.625 Y98.601 E.12195
G1 X105.242 Y96.218 E.10353
G1 X105.121 Y96.63 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X104.917 Y96.716 E.00681
G1 X104.539 Y96.694 E.01163
; LINE_WIDTH: 0.435373
G1 F9173.085
G1 X104.169 Y96.61 E.01213
; LINE_WIDTH: 0.466138
G1 F8506.265
G1 X103.799 Y96.527 E.01308
; LINE_WIDTH: 0.505467
G1 F7782.998
G1 X103.703 Y96.526 E.0036
; LINE_WIDTH: 0.55336
G1 F7052.739
G1 X103.608 Y96.526 E.00398
; LINE_WIDTH: 0.601254
G1 F6447.762
G1 X103.512 Y96.525 E.00435
; LINE_WIDTH: 0.604679
G1 F6408.442
G1 X103.667 Y96.661 E.00944
; LINE_WIDTH: 0.563637
G1 F6913.545
G1 X103.822 Y96.796 E.00875
; LINE_WIDTH: 0.522595
G1 F7505.082
G1 X103.977 Y96.932 E.00806
; LINE_WIDTH: 0.481553
G1 F8207.317
G1 X104.132 Y97.068 E.00737
; LINE_WIDTH: 0.420487
G1 F9534.75
G1 X104.287 Y97.204 E.00634
G1 X104.927 Y97.984 E.03103
G1 X105.05 Y98.197 E.00757
G1 X105.341 Y98.9 E.02341
G1 X105.504 Y99.892 E.03094
G1 X105.497 Y100.196 E.00935
G1 X107.092 Y98.601 E.0694
G1 X105.163 Y96.673 E.0839
G1 X105.031 Y97.036 F30000
; LINE_WIDTH: 0.379593
G1 F10692.887
G3 X104.631 Y97.056 I-.234 J-.656 E.01113
G1 X105.22 Y97.759 E.02514
; LINE_WIDTH: 0.418752
G1 F9578.747
G1 X105.397 Y98.053 E.01052
G1 X105.69 Y98.756 E.02331
G1 X105.813 Y99.347 E.01849
G1 X106.558 Y98.601 E.03229
G1 X105.765 Y97.807 E.03437
; LINE_WIDTH: 0.405313
G1 F9933.981
G1 X105.435 Y97.458 E.0142
; LINE_WIDTH: 0.378538
G1 F10726.477
G2 X105.073 Y97.078 I-7.28 J6.569 E.01433
G1 X106.053 Y98.561 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X105.984 Y98.601 E.00242
G1 X106.041 Y98.634 E.002
G1 X102.119 Y96.117 F30000
; LINE_WIDTH: 0.53717
G1 F7283.764
G1 X102.665 Y96.242 E.02256
; LINE_WIDTH: 0.534984
G1 F7316.131
G1 X102.929 Y96.33 E.01113
; LINE_WIDTH: 0.57107
G1 F6816.246
G1 X103.192 Y96.418 E.01194
; LINE_WIDTH: 0.607157
G1 F6380.302
G1 X103.455 Y96.506 E.01276
G1 X102.119 Y96.117 F30000
; LINE_WIDTH: 0.534499
G1 F7323.35
G1 X101.923 Y96.04 E.00844
; LINE_WIDTH: 0.488695
G1 F8075.823
G1 X101.727 Y95.964 E.00766
; LINE_WIDTH: 0.424121
G1 F9443.838
G1 X101.53 Y95.888 E.00655
G1 X100.115 Y95.508 E.0455
G1 X99.799 Y95.457 E.00994
G1 X99.579 Y95.347 E.00764
G1 X99.245 Y95.036 E.01417
G1 X99.018 Y94.551 E.01665
G2 X98.441 Y92.5 I-28.788 J6.988 E.06619
G3 X98.093 Y94.531 I-4.702 J.239 E.06453
G1 X97.713 Y95.19 E.02364
G3 X96.893 Y96.033 I-5.695 J-4.717 E.03655
G1 X96.17 Y96.454 E.02599
G1 X95.943 Y96.548 E.00764
G1 X95.208 Y96.745 E.02363
G3 X94.118 Y96.798 I-1.372 J-16.878 E.03392
G3 X96.208 Y97.4 I-91.581 J321.97 E.06758
G1 X96.592 Y97.735 E.01583
G2 X97.02 Y98.254 I1.476 J-.781 E.02103
G1 X97.173 Y98.571 E.01094
G1 X97.451 Y99.61 E.03339
; LINE_WIDTH: 0.440341
G1 F9058.404
G1 X97.502 Y99.719 E.00391
; LINE_WIDTH: 0.481043
G1 F8216.871
G1 X97.552 Y99.829 E.00431
; LINE_WIDTH: 0.521745
G1 F7518.405
G1 X97.603 Y99.938 E.00471
; LINE_WIDTH: 0.562447
G1 F6929.381
G1 X97.653 Y100.048 E.00511
; LINE_WIDTH: 0.603149
G1 F6425.944
G1 X97.703 Y100.157 E.00551
G1 X97.727 Y100.041 E.00545
; LINE_WIDTH: 0.562447
G1 F6929.381
G1 X97.751 Y99.924 E.00505
; LINE_WIDTH: 0.521745
G1 F7518.405
G1 X97.775 Y99.807 E.00466
; LINE_WIDTH: 0.481043
G1 F8216.871
G1 X97.799 Y99.69 E.00426
; LINE_WIDTH: 0.420426
G1 F9536.279
G3 X98.048 Y98.661 I13.254 J2.659 E.03257
G1 X98.284 Y98.141 E.01757
G3 X99.019 Y97.206 I5.166 J3.305 E.03663
G1 X99.623 Y96.743 E.02341
G3 X100.775 Y96.265 I2.89 J5.343 E.03845
G1 X101.512 Y96.167 E.02286
; LINE_WIDTH: 0.441135
G1 F9040.343
G1 X101.695 Y96.152 E.00594
; LINE_WIDTH: 0.483425
G1 F8172.438
G1 X101.877 Y96.137 E.00658
; LINE_WIDTH: 0.525715
G1 F7456.581
G1 X102.06 Y96.122 E.00721
G1 X100.393 Y95.977 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X99.677 Y95.814 E.02257
G1 X99.369 Y95.66 E.01058
G1 X98.963 Y95.286 E.01697
G1 X98.677 Y94.753 E.01857
G1 X98.57 Y94.333 E.01333
G1 X98.42 Y94.72 E.01274
G1 X98.039 Y95.379 E.02339
G3 X97.018 Y96.4 I-3.998 J-2.977 E.04453
G1 X96.359 Y96.78 E.02339
G1 X95.972 Y96.931 E.01274
G1 X96.37 Y97.06 E.01285
G1 X96.829 Y97.421 E.01795
G2 X97.323 Y98.03 I3.808 J-2.585 E.02413
G1 X97.537 Y98.474 E.01514
G1 X97.623 Y98.793 E.01015
G3 X98.008 Y97.862 I3.114 J.744 E.03109
G3 X98.79 Y96.907 I5.522 J3.721 E.03797
G1 X99.393 Y96.443 E.02338
G1 X99.692 Y96.271 E.01058
G1 X100.338 Y96 E.02154
G1 X99.297 Y96.055 F30000
G1 F9547.299
G1 X98.878 Y95.738 E.01613
G3 X98.538 Y95.269 I.641 J-.824 E.01803
G1 X98.224 Y95.775 E.01828
G3 X97.321 Y96.654 I-7.805 J-7.115 E.03874
G1 X96.823 Y96.948 E.01778
G1 X97.122 Y97.183 E.01169
G2 X97.616 Y97.793 I4.092 J-2.811 E.02413
G3 X98.247 Y96.921 I8.066 J5.173 E.03309
G3 X99.247 Y96.088 I5.663 J5.786 E.04003
G1 X97.582 Y97.032 F30000
; LINE_WIDTH: 0.56522
G1 F6892.59
G1 X97.758 Y96.845 E.01093
; LINE_WIDTH: 0.52578
G1 F7455.577
G1 X97.934 Y96.658 E.01011
; LINE_WIDTH: 0.499325
G1 F7887.745
G3 X98.524 Y96.089 I4.313 J3.88 E.0305
G1 X94.118 Y96.798 F30000
; LINE_WIDTH: 0.462286
G1 F8584.393
G3 X93.1 Y96.527 I1.855 J-9 E.036
G1 X90.75 Y92.754 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X89.146 Y94.358 E.06971
G1 X91.024 Y96.236 E.08159
G1 X91.327 Y96.131 E.00987
G1 X91.642 Y96.161 E.00971
G1 X92.535 Y96.4 E.02841
; LINE_WIDTH: 0.433238
G1 F9223.261
G1 X92.789 Y96.454 E.00826
; LINE_WIDTH: 0.450955
G1 F8822.786
G1 X93.043 Y96.509 E.00864
G1 X92.602 Y96.253 E.01696
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X92.142 Y95.924 E.01738
G1 X91.604 Y95.385 E.02339
G1 X91.455 Y95.191 E.00753
G1 X91.076 Y94.536 E.02324
G3 X90.752 Y92.814 I3.352 J-1.522 E.05437
G1 X90.408 Y93.63 F30000
G1 F9547.299
G1 X89.679 Y94.358 E.03166
G1 X91.116 Y95.795 E.06244
G3 X91.455 Y95.77 I.209 J.517 E.01061
G1 X91.128 Y95.38 E.01563
G1 X90.749 Y94.725 E.02324
G3 X90.422 Y93.688 I3.613 J-1.709 E.03352
G1 X90.228 Y94.319 F30000
; LINE_WIDTH: 0.40926
G1 F9826.937
G1 X90.159 Y94.358 E.00237
G1 X90.216 Y94.391 E.00194
; WIPE_START
G1 X90.159 Y94.358 E-.34265
G1 X90.228 Y94.319 E-.41735
; WIPE_END
G1 E-.04 F1800
G1 X97.369 Y91.624 Z3.6 F30000
G1 X98.123 Y91.34 Z3.6
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.470993
G1 F8409.781
G1 X98.424 Y92.42 E.0391
G1 X98.123 Y91.34 F30000
; LINE_WIDTH: 0.471388
G1 F8402.037
G1 X98.041 Y90.968 E.0133
; LINE_WIDTH: 0.42062
G1 F9531.387
G2 X97.8 Y90.003 I-10.85 J2.195 E.03063
G1 X97.782 Y89.597 E.0125
G1 X97.875 Y89.385 E.00715
G1 X95.998 Y87.507 E.08172
G1 X94.404 Y89.101 E.06936
G1 X95.014 Y89.112 E.01878
G3 X96.002 Y89.358 I-.431 J3.835 E.03143
G1 X96.829 Y89.815 E.02909
G3 X97.713 Y90.698 I-3.806 J4.69 E.03851
; LINE_WIDTH: 0.437123
G1 F9132.362
G1 X97.901 Y90.994 E.01127
; LINE_WIDTH: 0.471388
G1 F8402.037
G1 X98.09 Y91.29 E.01225
G1 X97.444 Y89.891 F30000
; LINE_WIDTH: 0.36364
G1 F11224.744
G1 X97.438 Y89.537 E.00924
G1 X97.467 Y89.47 E.00191
; LINE_WIDTH: 0.377728
G1 F10752.448
G1 X97.066 Y89.089 E.01509
; LINE_WIDTH: 0.415405
G1 F9664.84
G3 X95.998 Y88.04 I20.057 J-21.507 E.04546
G1 X95.269 Y88.769 E.03128
G1 X95.762 Y88.879 E.01534
G1 X96.359 Y89.108 E.0194
G1 X97.01 Y89.503 E.0231
; LINE_WIDTH: 0.37534
G1 F10829.674
G1 X97.399 Y89.851 E.01415
G1 X96.02 Y88.526 F30000
; LINE_WIDTH: 0.40924
G1 F9827.473
G1 X95.952 Y88.566 E.00237
G1 X96.008 Y88.598 E.00194
; WIPE_START
G1 X95.952 Y88.566 E-.34265
G1 X96.02 Y88.526 E-.41735
; WIPE_END
G1 E-.04 F1800
G1 X97.235 Y96.061 Z3.6 F30000
G1 X98.179 Y101.915 Z3.6
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.614257
G1 F6301.013
G1 X98.092 Y101.66 E.01253
; LINE_WIDTH: 0.57873
G1 F6718.8
G1 X98.005 Y101.405 E.01175
; LINE_WIDTH: 0.543204
G1 F7195.923
G1 X97.919 Y101.151 E.01097
; LINE_WIDTH: 0.549955
G1 F7100.102
G1 X97.817 Y100.683 E.01976
; LINE_WIDTH: 0.598985
G1 F6474.064
G1 X97.716 Y100.216 E.02167
G1 X98.179 Y101.915 F30000
; LINE_WIDTH: 0.61124
G1 F6334.46
G1 X98.179 Y101.995 E.00372
; LINE_WIDTH: 0.56968
G1 F6834.232
G1 X98.179 Y102.076 E.00345
; LINE_WIDTH: 0.52812
G1 F7419.621
G1 X98.179 Y102.156 E.00318
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.256 Y102.528 E.01369
; LINE_WIDTH: 0.420876
G1 F9524.917
G3 X98.355 Y103.277 I-2.523 J.717 E.02337
G1 X98.269 Y103.482 E.00682
G1 X100.24 Y105.452 E.08584
G1 X101.835 Y103.858 E.06947
G1 X101.531 Y103.865 E.00936
G1 X100.777 Y103.766 E.02344
G1 X99.836 Y103.411 E.03097
G1 X99.174 Y102.944 E.02494
G1 X98.843 Y102.648 E.01368
; LINE_WIDTH: 0.441828
G1 F9024.649
G1 X98.595 Y102.361 E.01234
; LINE_WIDTH: 0.485503
G1 F8134.077
G1 X98.347 Y102.073 E.01369
; LINE_WIDTH: 0.52812
G1 F7419.621
G1 X98.306 Y102.034 E.00225
; LINE_WIDTH: 0.56968
G1 F6834.232
G1 X98.264 Y101.995 E.00245
; LINE_WIDTH: 0.61124
G1 F6334.46
G1 X98.222 Y101.956 E.00264
G1 X98.695 Y102.992 F30000
; LINE_WIDTH: 0.378272
G1 F10734.991
G1 X98.702 Y103.327 E.00916
G1 X98.675 Y103.392 E.00191
G1 X99.161 Y103.851 E.01827
; LINE_WIDTH: 0.416938
G1 F9625.211
G3 X100.24 Y104.919 I-74.889 J76.772 E.04628
G1 X100.986 Y104.174 E.03213
G1 X100.395 Y104.05 E.0184
G1 X99.692 Y103.758 E.02319
G1 X99.398 Y103.58 E.01046
; LINE_WIDTH: 0.378965
G1 F10712.856
G3 X98.741 Y103.031 I10.503 J-13.243 E.02346
G1 X100.263 Y104.351 F30000
; LINE_WIDTH: 0.41306
G1 F9726.05
G1 X100.194 Y104.391 E.00242
G1 X100.251 Y104.424 E.002
G1 X92.238 Y97.507 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X93.811 Y97.928 E.05401
G1 X96.548 Y100.665 E.12839
G1 X96.085 Y98.939 E.05929
G1 X95.815 Y98.886 E.00914
G1 X95.772 Y98.826 E.00243
G1 X94.129 Y100.47 E.0771
G1 X95.28 Y101.621 E.05401
G1 X103.26 Y93.641 F30000
G1 F8843.478
G1 X102.109 Y92.49 E.05401
G1 X100.235 Y94.363 E.08789
G1 X102.304 Y94.908 E.07098
G1 X99.568 Y92.172 E.12839
G1 X99.146 Y90.599 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X99.568 Y92.172 E-.61876
G1 X99.83 Y92.434 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 17/30
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
M106 S232.05
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z3.6 I-1.211 J-.115 P1  F30000
G1 X94.964 Y143.538 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z3.8 F30000
G1 X81.345 Y142.345 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z3.8 F30000
G1 X95.153 Y143.945 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 17 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer17 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z3.8 F30000
G1 X92.366 Y109.965 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32509
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68438
G1 X90.952 Y108.833 E-.07562
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z3.8 F30000
G1 X95.613 Y133.039 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z3.8 F30000
G1 X96.888 Y114.504 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X93.22 Y110.835 E.02694
G1 X94.346 Y111.961 E.05281
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X93.497 Y110.558 E.01291
G1 X94.346 Y111.407 E.03687
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231709
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231718
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.2177
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13958
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z3.8 F30000
G1 X145.197 Y77.807 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
M73 P85 R4
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z3.8 F30000
G1 X112.992 Y88.732 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.348 Y88.608 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43061
G1 F9285.769
G1 X124.297 Y99.557 E.4892
G1 X124.571 Y99.283 E.01225
G1 X113.742 Y88.454 E.48384
G1 X114.016 Y88.18 E.01225
G1 X124.845 Y99.009 E.48384
G1 X125.119 Y98.735 E.01225
G1 X114.29 Y87.905 E.48384
G1 X114.564 Y87.631 E.01225
G1 X125.394 Y98.461 E.48384
G1 X125.668 Y98.187 E.01225
G1 X114.838 Y87.357 E.48384
G1 X115.112 Y87.083 E.01225
G1 X125.942 Y97.912 E.48384
G1 X126.216 Y97.638 E.01225
G1 X115.386 Y86.809 E.48384
G1 X115.661 Y86.535 E.01225
G1 X126.49 Y97.364 E.48384
G1 X126.764 Y97.09 E.01225
G1 X115.935 Y86.261 E.48384
G1 X116.209 Y85.986 E.01225
G1 X127.038 Y96.816 E.48384
G1 X127.313 Y96.542 E.01225
G1 X116.483 Y85.712 E.48384
G1 X116.757 Y85.438 E.01225
G1 X127.587 Y96.268 E.48384
G1 X127.861 Y95.994 E.01225
G1 X117.031 Y85.164 E.48384
G1 X117.305 Y84.89 E.01225
G1 X128.135 Y95.719 E.48384
G1 X128.409 Y95.445 E.01225
G1 X117.58 Y84.616 E.48384
G1 X117.854 Y84.342 E.01225
G1 X128.683 Y95.171 E.48384
G1 X128.957 Y94.897 E.01225
G1 X118.128 Y84.067 E.48384
G1 X118.402 Y83.793 E.01225
G1 X129.231 Y94.623 E.48384
G1 X129.506 Y94.349 E.01225
G1 X118.676 Y83.519 E.48384
G1 X118.95 Y83.245 E.01225
G1 X129.78 Y94.075 E.48384
G1 X130.054 Y93.8 E.01225
G1 X119.224 Y82.971 E.48384
G1 X119.499 Y82.697 E.01225
G1 X130.328 Y93.526 E.48384
G1 X130.602 Y93.252 E.01225
G1 X119.773 Y82.423 E.48384
G1 X120.047 Y82.149 E.01225
G1 X130.996 Y93.098 E.4892
; OBJECT_ID: 258
; WIPE_START
G1 X129.582 Y91.684 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X122.369 Y94.178 Z3.8 F30000
G1 X100.7 Y101.67 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.701 Y101.666 E.00012
G3 X101.405 Y98.121 I.953 J-1.653 E.14586
G1 X101.654 Y98.105 E.00767
G3 X100.925 Y101.777 I0 J1.908 E.20723
G1 X100.754 Y101.696 E.0058
; WIPE_START
M204 S10000
G1 X100.701 Y101.666 E-.02312
G1 X100.491 Y101.531 E-.09484
G1 X100.303 Y101.366 E-.09498
G1 X100.139 Y101.178 E-.09498
G1 X100 Y100.97 E-.09493
G1 X99.889 Y100.746 E-.09498
G1 X99.809 Y100.51 E-.09495
G1 X99.76 Y100.265 E-.09496
G1 X99.748 Y100.075 E-.07227
; WIPE_END
G1 E-.04 F1800
G1 X107.279 Y98.837 Z3.8 F30000
G1 X108.713 Y98.601 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X106.663 Y100.65 E.09615
G1 X105.47 Y96.199 E.15286
G1 X100.258 Y94.803 E.17901
G1 X96.442 Y98.618 E.17901
G1 X97.838 Y103.831 E.17901
G1 X102.29 Y105.024 E.15286
G1 X100.24 Y107.073 E.09615
G1 X87.525 Y94.358 E.59649
G1 X89.645 Y92.238 E.09946
G1 X90.838 Y96.689 E.15286
G1 X95.954 Y98.06 E.1757
G1 X99.699 Y94.315 E.1757
G1 X98.329 Y89.199 E.1757
G1 X93.877 Y88.006 E.15286
G1 X95.998 Y85.886 E.09946
G1 X101.648 Y91.536 E.26507
G1 X108.67 Y98.559 E.32942
G1 X109.288 Y98.601 F30000
G1 F8843.478
G1 X106.452 Y101.437 E.13304
G1 X105.138 Y96.532 E.16846
G1 X100.379 Y95.257 E.16342
G1 X96.896 Y98.74 E.16342
G1 X98.171 Y103.499 E.16342
G1 X103.076 Y104.813 E.16846
G1 X100.24 Y107.649 E.13304
G1 X86.949 Y94.358 E.62349
G1 X89.856 Y91.452 E.13636
G1 X91.17 Y96.357 E.16846
G1 X95.832 Y97.606 E.16011
G1 X99.245 Y94.193 E.1601
G1 X97.996 Y89.531 E.1601
G1 X93.091 Y88.217 E.16846
G1 X95.998 Y85.31 E.13635
G1 X101.936 Y91.249 E.27857
G1 X109.246 Y98.559 E.34293
; WIPE_START
G1 X107.853 Y99.994 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.233 Y96.196 Z3.8 F30000
G1 X96.426 Y93.438 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G3 X94.334 Y91.05 I-1.843 J-.496 E.25324
G1 X94.583 Y91.034 E.00768
G3 X96.441 Y93.38 I0 J1.908 E.10567
; WIPE_START
M204 S10000
G1 X96.348 Y93.675 E-.11765
G1 X96.238 Y93.899 E-.09499
G1 X96.099 Y94.107 E-.09493
G1 X95.934 Y94.295 E-.09498
G1 X95.746 Y94.46 E-.09498
G1 X95.539 Y94.599 E-.09493
G1 X95.314 Y94.709 E-.09499
G1 X95.134 Y94.771 E-.07257
; WIPE_END
G1 E-.04 F1800
G1 X102.52 Y96.694 Z3.8 F30000
G1 X109.843 Y98.601 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
M73 P85 R3
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X102.213 Y90.971 E.27009
G1 X109.8 Y98.559 E.3297
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.079 Y96.957 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X106.866 Y99.893 E.09338
G1 X108.158 Y98.601 E.05615
G1 X106.367 Y96.81 E.07785
G1 X106.214 Y96.962 E.00663
G1 X106.139 Y96.959 E.00229
G1 X106.748 Y97.797 F30000
; LINE_WIDTH: 0.52323
G1 F7495.159
G1 X107.088 Y99.065 E.05136
G1 X107.552 Y98.601 E.02568
G1 X106.791 Y97.84 E.04213
G1 X106.164 Y96.458 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.209844
G1 F15000
G1 X105.212 Y95.506 E.01831
; WIPE_START
G1 X106.164 Y96.458 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.129 Y97.357 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X104.312 Y96.541 E.03548
G1 X103.584 Y96.346
G1 X105.324 Y98.086 E.07562
G1 X105.519 Y98.814
G1 X102.855 Y96.15 E.11575
G1 X102.127 Y95.955
G1 X105.714 Y99.543 E.15589
G1 X105.91 Y100.271
G1 X101.399 Y95.76 E.19603
G1 X100.67 Y95.565
G1 X106.105 Y101 E.23616
G1 X105.98 Y101.408
G1 X103.41 Y98.838 E.1117
G1 X103.749 Y99.71
G1 X105.714 Y101.675 E.08538
G1 X105.447 Y101.942
G1 X103.757 Y100.252 E.07343
G1 X103.659 Y100.686
G1 X105.18 Y102.208 E.06613
G1 X104.914 Y102.475
G1 X103.497 Y101.058 E.06157
G1 X103.277 Y101.371
G1 X104.647 Y102.741 E.05955
G1 X104.381 Y103.008
G1 X103.01 Y101.638 E.05955
G1 X102.697 Y101.858
G1 X104.114 Y103.275 E.06157
G1 X103.847 Y103.541
G1 X102.326 Y102.02 E.06613
G1 X101.891 Y102.118
G1 X103.581 Y103.808 E.07344
G1 X103.314 Y104.075
G1 X101.349 Y102.11 E.08539
G1 X100.477 Y101.77
G1 X103.047 Y104.341 E.11171
; WIPE_START
M204 S10000
G1 X101.633 Y102.927 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.832 Y98.26 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X100.261 Y95.689 E.1117
G1 X99.995 Y95.956
G1 X101.959 Y97.921 E.08538
G1 X101.418 Y97.912
G1 X99.728 Y96.223 E.07344
G1 X99.461 Y96.489
G1 X100.983 Y98.011 E.06613
G1 X100.612 Y98.173
G1 X99.195 Y96.756 E.06157
G1 X98.928 Y97.022
G1 X100.299 Y98.393 E.05955
G1 X100.032 Y98.659
G1 X98.661 Y97.289 E.05955
G1 X98.395 Y97.556
G1 X99.812 Y98.973 E.06157
G1 X99.65 Y99.344
G1 X98.128 Y97.822 E.06613
G1 X97.862 Y98.089
G1 X99.552 Y99.779 E.07344
G1 X99.56 Y100.321
G1 X97.595 Y98.356 E.08539
G1 X97.328 Y98.622
G1 X99.899 Y101.193 E.11171
; WIPE_START
M204 S10000
G1 X98.485 Y99.779 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.204 Y99.031 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X102.638 Y104.466 E.23615
G1 X101.91 Y104.27
G1 X97.399 Y99.76 E.19602
G1 X97.594 Y100.488
G1 X101.182 Y104.075 E.15588
G1 X100.453 Y103.88
G1 X97.79 Y101.216 E.11574
G1 X97.985 Y101.945
G1 X99.725 Y103.685 E.07561
G1 X98.996 Y103.49
G1 X98.18 Y102.673 E.03547
; WIPE_START
M204 S10000
G1 X98.996 Y103.49 E-.43866
G1 X99.725 Y103.685 E-.28658
G1 X99.66 Y103.62 E-.03476
; WIPE_END
G1 E-.04 F1800
G1 X100.416 Y101.831 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.218893
G1 F15000
G1 X100.326 Y101.757 E.00168
G3 X99.839 Y101.253 I3.152 J-3.538 E.01005
; WIPE_START
G1 X100.109 Y101.553 E-.37496
G1 X100.326 Y101.757 E-.27634
G1 X100.416 Y101.831 E-.1087
; WIPE_END
G1 E-.04 F1800
G1 X103.47 Y98.777 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.218822
G1 F15000
G1 X103.396 Y98.687 E.00168
G2 X102.892 Y98.199 I-3.535 J3.149 E.01006
G1 X102.277 Y97.993 F30000
; LINE_WIDTH: 0.114858
G1 F15000
G1 X102.03 Y97.851 E.00168
; WIPE_START
G1 X102.277 Y97.993 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.88 Y94.657 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.375317
G1 F10830.451
G1 X96.296 Y98.241 E.13729
; LINE_WIDTH: 0.362059
G1 F11280.373
G1 X96.268 Y98.387 E.00387
; LINE_WIDTH: 0.335542
G1 F12302.577
G1 X96.239 Y98.533 E.00355
G1 X95.28 Y101.621 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.129 Y100.47 E.05401
G1 X95.797 Y98.802 E.07825
G1 X96.149 Y98.871 E.0119
G1 X96.66 Y100.777 E.06548
G1 X93.699 Y97.816 E.13891
G1 X91.59 Y97.251 E.07241
G1 X91.25 Y97.591 E.01594
G1 X92.402 Y98.743 E.05401
G1 X90.931 Y97.283 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.317031
G1 F13133.382
G1 X90.245 Y96.596 E.0217
G1 X90.264 Y96.063 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X89.442 Y92.996 E.09757
G1 X88.08 Y94.358 E.05922
G1 X90.004 Y96.282 E.08361
G1 X90.21 Y96.076 E.00896
G1 X89.577 Y95.223 F30000
; LINE_WIDTH: 0.55982
G1 F6964.596
G1 X89.211 Y93.859 E.05948
G1 X88.712 Y94.358 E.02974
G1 X89.534 Y95.181 E.04899
; WIPE_START
G1 X88.712 Y94.358 E-.44195
G1 X89.211 Y93.859 E-.26832
G1 X89.245 Y93.985 E-.04973
; WIPE_END
G1 E-.04 F1800
G1 X90.049 Y91.413 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.653034
G1 F5900.539
G1 X93.052 Y88.41 E.21118
; WIPE_START
G1 X91.638 Y89.824 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.702 Y88.625 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9547.299
G3 X97.922 Y88.365 I.623 J.302 E.01058
G1 X95.998 Y86.44 E.08361
G1 X94.635 Y87.803 E.05922
G1 X97.644 Y88.61 E.09572
G1 X96.862 Y87.937 F30000
; LINE_WIDTH: 0.55982
G1 F6964.596
G1 X95.998 Y87.073 E.05151
G1 X95.498 Y87.572 E.02974
G1 X96.804 Y87.922 E.05696
G1 X98.235 Y88.605 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.317064
G1 F13131.78
G1 X98.922 Y89.292 E.0217
; WIPE_START
G1 X98.235 Y88.605 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.935 Y90.164 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X97.364 Y89.592 E.02484
G1 X96.635 Y89.397
G1 X98.13 Y90.892 E.06497
G1 X98.326 Y91.621
G1 X95.907 Y89.202 E.10511
G1 X95.178 Y89.007
G1 X98.521 Y92.349 E.14525
G1 X98.716 Y93.078
G1 X94.45 Y88.811 E.18538
G1 X93.721 Y88.616
G1 X98.911 Y93.806 E.22552
G1 X98.848 Y94.276
G1 X96.339 Y91.767 E.10904
G1 X96.678 Y92.639
G1 X98.581 Y94.543 E.08272
G1 X98.315 Y94.809
G1 X96.686 Y93.181 E.07077
G1 X96.588 Y93.615
G1 X98.048 Y95.076 E.06347
G1 X97.782 Y95.343
G1 X96.426 Y93.987 E.05891
G1 X96.206 Y94.3
G1 X97.515 Y95.609 E.05689
G1 X97.248 Y95.876
G1 X95.939 Y94.567 E.05689
G1 X95.626 Y94.787
G1 X96.982 Y96.142 E.05891
G1 X96.715 Y96.409
G1 X95.254 Y94.949 E.06347
G1 X94.82 Y95.047
M73 P86 R3
G1 X96.448 Y96.676 E.07078
G1 X96.182 Y96.942
G1 X94.278 Y95.039 E.08273
G1 X93.406 Y94.699
G1 X95.915 Y97.209 E.10905
; WIPE_START
M204 S10000
G1 X94.501 Y95.795 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.761 Y91.189 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X93.251 Y88.679 E.10904
G1 X92.985 Y88.946
G1 X94.888 Y90.85 E.08272
G1 X94.347 Y90.841
G1 X92.718 Y89.213 E.07077
G1 X92.452 Y89.479
G1 X93.912 Y90.94 E.06347
G1 X93.541 Y91.102
G1 X92.185 Y89.746 E.05891
G1 X91.918 Y90.013
G1 X93.227 Y91.322 E.05689
G1 X92.961 Y91.588
G1 X91.652 Y90.279 E.05689
G1 X91.385 Y90.546
G1 X92.741 Y91.901 E.05891
G1 X92.579 Y92.273
G1 X91.118 Y90.812 E.06347
G1 X90.852 Y91.079
G1 X92.48 Y92.708 E.07078
G1 X92.489 Y93.249
G1 X90.585 Y91.346 E.08273
G1 X90.319 Y91.612
G1 X92.828 Y94.122 E.10905
; WIPE_START
M204 S10000
G1 X91.414 Y92.708 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.255 Y92.083 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X95.445 Y97.272 E.22551
G1 X94.717 Y97.077
G1 X90.451 Y92.811 E.18537
G1 X90.646 Y93.539
G1 X93.988 Y96.882 E.14524
G1 X93.26 Y96.686
G1 X90.841 Y94.268 E.1051
G1 X91.036 Y94.996
G1 X92.531 Y96.491 E.06496
G1 X91.803 Y96.296
G1 X91.231 Y95.725 E.02483
; WIPE_START
M204 S10000
G1 X91.803 Y96.296 E-.30702
G1 X92.531 Y96.491 E-.28658
G1 X92.222 Y96.182 E-.1664
; WIPE_END
G1 E-.04 F1800
G1 X92.561 Y93.567 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114993
G1 F15000
G1 X92.418 Y93.32 E.00168
; WIPE_START
G1 X92.561 Y93.567 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X93.345 Y94.76 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.218892
G1 F15000
G1 X93.255 Y94.686 E.00168
G3 X92.768 Y94.182 I3.15 J-3.536 E.01005
; WIPE_START
G1 X93.037 Y94.482 E-.37494
G1 X93.255 Y94.686 E-.27634
G1 X93.345 Y94.76 E-.10873
; WIPE_END
G1 E-.04 F1800
G1 X96.399 Y91.706 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.218824
G1 F15000
G1 X96.325 Y91.615 E.00168
G2 X95.821 Y91.128 I-3.532 J3.146 E.01005
G1 X95.206 Y90.922 F30000
; LINE_WIDTH: 0.114891
G1 F15000
G1 X94.959 Y90.779 E.00168
; WIPE_START
G1 X95.206 Y90.922 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.027 Y90.498 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.196192
G1 F15000
G1 X97.871 Y90.228 E.0039
; WIPE_START
G1 X98.027 Y90.498 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.382 Y90.763 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X99.23 Y89.611 E.05401
G1 X98.891 Y89.951 E.01594
G1 X99.456 Y92.059 E.07241
G1 X102.417 Y95.02 E.13891
G1 X100.178 Y94.421 E.07688
G1 X102.109 Y92.49 E.09058
G1 X103.26 Y93.641 E.05401
; WIPE_START
G1 X102.109 Y92.49 E-.61876
G1 X101.846 Y92.753 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X105.285 Y99.566 Z3.8 F30000
G1 X106.272 Y101.524 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.566434
G1 F6876.613
G1 X103.163 Y104.633 E.1876
; WIPE_START
G1 X104.577 Y103.219 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.597 Y104.44 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X98.593 Y104.584 E.00441
G1 X98.449 Y104.727 E.00625
G1 X100.24 Y106.519 E.07785
G1 X101.532 Y105.227 E.05615
G1 X98.655 Y104.456 E.09154
G1 X99.437 Y105.109 F30000
; LINE_WIDTH: 0.52323
G1 F7495.159
G1 X100.24 Y105.913 E.04448
G1 X100.704 Y105.449 E.02568
G1 X99.495 Y105.125 E.04901
G1 X98.097 Y104.524 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.20987
G1 F15000
G1 X97.145 Y103.572 E.01832
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X98.097 Y104.524 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 18/30
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S234.6
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z3.8 I-1.213 J-.097 P1  F30000
G1 X94.964 Y143.538 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z4 F30000
G1 X81.345 Y142.345 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z4 F30000
G1 X95.153 Y143.945 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 18 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer18 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X95.581 Y134.106 Z4 F30000
G1 X95.613 Y133.039 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X89.159 Y111.203 E.3738
G1 X91.093 Y109.268 E.09074
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X89.436 Y111.48 E.33421
G1 X91.093 Y109.823 E.072
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X93.391 Y123.698 Z4 F30000
G1 X92.366 Y109.965 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32509
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68439
G1 X90.952 Y108.833 E-.07561
; WIPE_END
G1 E-.04 F1800
G1 X96.471 Y114.105 Z4 F30000
G1 X96.888 Y114.504 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231709
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231718
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.2177
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21685
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21685
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13958
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z4 F30000
G1 X145.197 Y77.807 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z4 F30000
G1 Z3.6
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
M73 P87 R3
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z4 F30000
G1 X112.992 Y88.732 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.341 Y82.673 Z4 F30000
G1 X120.173 Y82.027 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42565
G1 F9406.108
G1 X113.466 Y88.734 E.29581
G1 X113.737 Y89.004 E.01194
G1 X120.323 Y82.418 E.29052
G1 X120.594 Y82.688 E.01194
G1 X114.007 Y89.275 E.29052
G1 X114.278 Y89.546 E.01194
G1 X120.865 Y82.959 E.29052
G1 X121.135 Y83.229 E.01194
G1 X114.549 Y89.816 E.29052
G1 X114.819 Y90.087 E.01194
G1 X121.406 Y83.5 E.29052
G1 X121.677 Y83.771 E.01194
G1 X115.09 Y90.358 E.29052
G1 X115.36 Y90.628 E.01194
G1 X121.947 Y84.041 E.29052
G1 X122.218 Y84.312 E.01194
G1 X115.631 Y90.899 E.29052
G1 X115.902 Y91.169 E.01194
G1 X122.489 Y84.583 E.29052
G1 X122.759 Y84.853 E.01194
G1 X116.172 Y91.44 E.29052
G1 X116.443 Y91.711 E.01194
G1 X123.03 Y85.124 E.29052
G1 X123.3 Y85.394 E.01194
G1 X116.714 Y91.981 E.29052
G1 X116.984 Y92.252 E.01194
G1 X123.571 Y85.665 E.29052
G1 X123.842 Y85.936 E.01194
G1 X117.255 Y92.523 E.29052
G1 X117.525 Y92.793 E.01194
G1 X124.112 Y86.206 E.29052
G1 X124.383 Y86.477 E.01194
G1 X117.796 Y93.064 E.29052
G1 X118.067 Y93.334 E.01194
G1 X124.654 Y86.748 E.29052
G1 X124.924 Y87.018 E.01194
G1 X118.337 Y93.605 E.29052
G1 X118.608 Y93.876 E.01194
G1 X125.195 Y87.289 E.29052
G1 X125.465 Y87.56 E.01194
G1 X118.879 Y94.146 E.29052
G1 X119.149 Y94.417 E.01194
G1 X125.736 Y87.83 E.29052
G1 X126.007 Y88.101 E.01194
G1 X119.42 Y94.688 E.29052
G1 X119.691 Y94.958 E.01194
G1 X126.277 Y88.371 E.29052
G1 X126.548 Y88.642 E.01194
G1 X119.961 Y95.229 E.29052
G1 X120.232 Y95.5 E.01194
G1 X126.819 Y88.913 E.29052
G1 X127.089 Y89.183 E.01194
G1 X120.502 Y95.77 E.29052
G1 X120.773 Y96.041 E.01194
G1 X127.36 Y89.454 E.29052
G1 X127.631 Y89.725 E.01194
G1 X121.044 Y96.311 E.29052
G1 X121.314 Y96.582 E.01194
G1 X127.901 Y89.995 E.29052
G1 X128.172 Y90.266 E.01194
G1 X121.585 Y96.853 E.29052
G1 X121.856 Y97.123 E.01194
G1 X128.442 Y90.536 E.29052
G1 X128.713 Y90.807 E.01194
G1 X122.126 Y97.394 E.29052
G1 X122.397 Y97.665 E.01194
G1 X128.984 Y91.078 E.29052
G1 X129.254 Y91.348 E.01194
G1 X122.667 Y97.935 E.29052
G1 X122.938 Y98.206 E.01194
G1 X129.525 Y91.619 E.29052
G1 X129.796 Y91.89 E.01194
G1 X123.209 Y98.476 E.29052
G1 X123.479 Y98.747 E.01194
G1 X130.066 Y92.16 E.29052
G1 X130.337 Y92.431 E.01194
G1 X123.75 Y99.018 E.29052
G1 X124.021 Y99.288 E.01194
G1 X130.607 Y92.702 E.29052
G1 X130.878 Y92.972 E.01194
G1 X124.171 Y99.679 E.29581
; OBJECT_ID: 258
; WIPE_START
G1 X125.585 Y98.265 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X118.035 Y99.379 Z4 F30000
G1 X105.45 Y101.235 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13584
G1 X98.123 Y98.531 E.01989
G1 X100.594 Y96.06 E.11596
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X98.4 Y98.809 E.01146
G1 X100.712 Y96.497 E.10046
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X101.176 Y91.065 E.24296
G1 X108.67 Y98.559 E.35154
; WIPE_START
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z4 F30000
G1 X98.384 Y93.76 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8843.478
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X91.143 Y91.491 E.01964
G1 X93.549 Y89.085 E.11289
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X91.42 Y91.769 E.01124
G1 X93.666 Y89.522 E.09761
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z4 F30000
G1 X109.288 Y98.601 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X101.464 Y90.777 E.25646
G1 X109.246 Y98.559 E.36504
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X101.742 Y90.5 E.24961
G1 X109.8 Y98.559 E.35019
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F8102.312
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.564 Y103.367 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.519009
G1 F7561.609
G1 X97.578 Y103.339 E.0012
; LINE_WIDTH: 0.476654
G1 F8300.028
G1 X97.591 Y103.312 E.00109
; LINE_WIDTH: 0.454775
G1 F8740.946
G1 X97.605 Y103.284 E.00104
G1 X97.601 Y103.096 E.00631
; LINE_WIDTH: 0.417663
G1 F9606.583
G3 X96.443 Y98.767 I251.684 J-69.679 E.13684
G1 X96.325 Y98.616 E.00585
G1 X96.052 Y98.533 E.00871
G1 X96.054 Y98.311 E.00678
G1 X95.936 Y98.117 E.00693
G1 X95.656 Y98.021 E.00903
G1 X91.446 Y96.893 E.1331
G1 X91.291 Y96.916 E.00477
G1 X90.993 Y97.272 E.01417
G1 X88.08 Y94.358 E.12581
G1 X90.03 Y92.408 E.08424
G1 X91.078 Y96.317 E.12357
G1 X91.126 Y96.401 E.00298
G1 X91.542 Y96.535 E.01333
G1 X95.752 Y97.663 E.1331
G1 X95.783 Y97.67 E.00098
G1 X95.933 Y97.618 E.00485
G1 X99.254 Y94.297 E.1434
G1 X99.302 Y94.113 E.00582
G1 X98.063 Y89.515 E.14541
G1 X97.956 Y89.438 E.00402
G1 X94.047 Y88.391 E.12357
G1 X95.998 Y86.44 E.08424
G1 X98.911 Y89.354 E.12581
G1 X98.656 Y89.52 E.0093
G2 X98.532 Y89.807 I.217 J.264 E.0099
G1 X99.766 Y94.446 E.1466
G1 X99.972 Y94.698 E.00993
G1 X100.556 Y94.842 E.01837
; LINE_WIDTH: 0.435643
G1 F9166.778
G1 X102.645 Y95.402 E.06923
; LINE_WIDTH: 0.480648
G1 F8224.295
G1 X104.735 Y95.962 E.07716
; LINE_WIDTH: 0.437047
G1 F9134.119
G1 X104.798 Y95.963 E.00201
; LINE_WIDTH: 0.4849
G1 F8145.165
G1 X104.86 Y95.964 E.00226
; LINE_WIDTH: 0.528947
G1 F7407.008
G2 X105.012 Y95.927 I.035 J-.183 E.0064
; LINE_WIDTH: 0.561498
G1 F6942.064
G1 X105.16 Y95.706 E.0112
; LINE_WIDTH: 0.54643
G1 F7149.809
G1 X105.274 Y95.821 E.00665
; LINE_WIDTH: 0.50593
G1 F7775.21
G1 X105.389 Y95.935 E.00611
; LINE_WIDTH: 0.542232
G1 F7209.925
G1 X105.518 Y96.046 E.00692
; LINE_WIDTH: 0.493335
G1 F7992.629
G1 X105.648 Y96.156 E.00625
; LINE_WIDTH: 0.452271
G1 F8794.417
G1 X107.47 Y97.913 E.08443
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X108.158 Y98.601 E.0299
G1 X106.278 Y100.481 E.08169
; LINE_WIDTH: 0.436413
G1 F9148.84
G1 X106.06 Y99.667 E.02702
; LINE_WIDTH: 0.469258
G1 F8444.015
G1 X105.842 Y98.853 E.02928
; LINE_WIDTH: 0.44002
G1 F9065.726
G1 X105.649 Y98.09 E.02547
; LINE_WIDTH: 0.48008
G1 F8234.971
G1 X105.456 Y97.327 E.02804
; LINE_WIDTH: 0.52014
G1 F7543.69
G1 X105.263 Y96.564 E.03061
; LINE_WIDTH: 0.50593
G1 F7775.21
G1 X105.257 Y96.521 E.00162
; LINE_WIDTH: 0.54643
G1 F7149.809
G1 X105.252 Y96.478 E.00177
; LINE_WIDTH: 0.518995
G1 F7561.834
G1 X105.21 Y96.442 E.00214
; LINE_WIDTH: 0.476645
G1 F8300.19
G1 X105.168 Y96.407 E.00195
; LINE_WIDTH: 0.484274
G1 F8156.721
G1 X105.126 Y96.371 E.00199
G1 X104.639 Y96.32 E.01761
; LINE_WIDTH: 0.417809
G1 F9602.855
G1 X100.46 Y95.2 E.13217
G1 X100.316 Y95.217 E.00443
G1 X99.972 Y95.552 E.01468
G2 X96.874 Y98.65 I970.655 J973.486 E.13383
G1 X96.839 Y98.821 E.00532
; LINE_WIDTH: 0.437062
G1 F9133.772
G1 X97.212 Y100.214 E.04632
; LINE_WIDTH: 0.484905
G1 F8145.072
G1 X97.585 Y101.607 E.05194
; LINE_WIDTH: 0.518295
G1 F7572.972
G1 X97.959 Y103 E.05587
G1 X98.012 Y103.476 E.01856
; LINE_WIDTH: 0.538925
G1 F7257.991
G1 X98.049 Y103.53 E.00264
; LINE_WIDTH: 0.503435
G1 F7817.335
G1 X98.086 Y103.584 E.00245
; LINE_WIDTH: 0.51704
G1 F7593.014
G1 X98.125 Y103.597 E.00159
; LINE_WIDTH: 0.47822
G1 F8270.159
G1 X98.164 Y103.61 E.00146
; LINE_WIDTH: 0.45261
G1 F8787.143
G1 X100.492 Y104.203 E.08021
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X102.12 Y104.639 E.05179
G1 X100.24 Y106.519 E.08169
; LINE_WIDTH: 0.436415
G1 F9148.782
G1 X99.896 Y106.175 E.0156
; LINE_WIDTH: 0.469265
G1 F8443.866
G1 X99.552 Y105.831 E.0169
; LINE_WIDTH: 0.4394
G1 F9079.903
G1 X99.003 Y105.267 E.02543
; LINE_WIDTH: 0.47822
G1 F8270.159
G1 X98.454 Y104.702 E.02792
; LINE_WIDTH: 0.51704
G1 F7593.014
G1 X97.906 Y104.138 E.03041
; LINE_WIDTH: 0.50594
G1 F7775.042
G1 X97.821 Y104.035 E.00501
; LINE_WIDTH: 0.552162
G1 F7069.334
G2 X97.345 Y103.52 I-3.96 J3.181 E.02912
G1 X97.413 Y103.487 E.00313
; LINE_WIDTH: 0.550805
G1 F7088.219
G1 X97.474 Y103.457 E.00281
; LINE_WIDTH: 0.522018
G1 F7514.123
G1 X97.538 Y103.421 E.00286
; WIPE_START
G1 X97.474 Y103.457 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.532 Y100.552 Z4 F30000
G1 X106.473 Y99.752 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X107.625 Y98.601 E.05004
G1 X105.63 Y96.607 E.08666
G1 X106.458 Y99.695 E.09823
G1 X106.676 Y98.995 F30000
; LINE_WIDTH: 0.45042
G1 F8834.356
G1 X107.07 Y98.601 E.01849
G1 X106.388 Y97.919 E.03202
G1 X106.661 Y98.937 E.03498
; WIPE_START
G1 X106.388 Y97.919 E-.40027
G1 X107.058 Y98.589 E-.35973
; WIPE_END
G1 E-.04 F1800
G1 X100.188 Y95.263 Z4 F30000
G1 X99.815 Y95.082 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.552
G1 F7071.585
G1 X99.592 Y94.945 E.01085
G1 X99.44 Y94.738 E.01068
G1 X96.305 Y97.873 E.18392
G1 X96.525 Y98.214 E.01688
G1 X96.615 Y98.282 E.00466
G1 X99.772 Y95.125 E.18524
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.38491
G1 F10526.624
G1 X98.319 Y89.271 E.00386
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.414003
G1 F9701.353
G1 X98.076 Y89.04 E.00595
G3 X95.998 Y86.974 I263.458 J-267.155 E.08861
G1 X94.775 Y88.196 E.05227
G3 X98.051 Y89.083 I-111.944 J419.901 E.10262
G1 X98.168 Y89.144 E.004
G1 X96.741 Y88.297 F30000
; LINE_WIDTH: 0.48703
G1 F8106.101
G1 X95.998 Y87.554 E.03803
G1 X95.569 Y87.983 E.02196
G1 X96.683 Y88.282 E.04174
; WIPE_START
G1 X95.569 Y87.983 E-.43827
G1 X95.998 Y87.554 E-.23054
G1 X96.167 Y87.724 E-.0912
; WIPE_END
G1 E-.04 F1800
G1 X92.276 Y94.29 Z4 F30000
G1 X90.875 Y96.652 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.38078
G1 F10655.301
G1 X90.908 Y96.682 E.00121
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.41516
G1 F9671.191
G1 X90.719 Y96.413 E.00867
G3 X89.835 Y93.136 I642.491 J-175.099 E.10294
G1 X88.613 Y94.358 E.05243
G3 X90.835 Y96.607 I-113.51 J114.397 E.09591
G1 X89.937 Y95.101 F30000
; LINE_WIDTH: 0.48703
G1 F8106.101
G1 X89.623 Y93.929 E.04391
G1 X89.194 Y94.358 E.02195
G1 X89.894 Y95.059 E.03586
G1 X98.246 Y103.991 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.24 Y105.986 E.08666
G1 X101.392 Y104.834 E.05004
G1 X98.304 Y104.007 E.09823
G1 X99.558 Y104.749 F30000
; LINE_WIDTH: 0.45042
G1 F8834.356
G1 X100.24 Y105.431 E.03202
G1 X100.634 Y105.037 E.01849
G1 X99.616 Y104.765 E.03498
G1 X92.238 Y97.507 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X93.811 Y97.928 E.05401
G1 X96.548 Y100.665 E.12839
G1 X96.085 Y98.939 E.05929
G1 X95.815 Y98.886 E.00914
G1 X95.772 Y98.826 E.00243
G1 X94.129 Y100.47 E.0771
G1 X95.28 Y101.621 E.05401
; WIPE_START
G1 X94.129 Y100.47 E-.61876
G1 X94.392 Y100.207 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X91.207 Y93.271 Z4 F30000
G1 X90.418 Y91.553 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.573822
G1 F6780.912
G1 X93.192 Y88.779 E.16974
; WIPE_START
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.088 Y92.388 Z4 F30000
G1 X103.26 Y93.641 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X102.109 Y92.49 E.05401
G1 X100.235 Y94.363 E.08789
G1 X102.304 Y94.908 E.07098
G1 X99.568 Y92.172 E.12839
G1 X99.146 Y90.599 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X99.568 Y92.172 E-.61876
G1 X99.83 Y92.434 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 19/30
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z4 I-1.211 J-.115 P1  F30000
G1 X94.964 Y143.538 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F8843.478
G1 X94.964 Y141.938 E.05307
G1 X80.546 Y141.938 E.47828
G1 X80.546 Y162.357 E.67731
G1 X94.964 Y162.357 E.47828
G1 X94.964 Y146.757 E.51748
G1 X95.746 Y146.757 E.02593
G1 X95.746 Y163.138 E.54341
G1 X79.764 Y163.138 E.53014
G1 X79.764 Y141.157 E.72917
G1 X95.746 Y141.157 E.53014
G1 X95.746 Y143.538 E.07901
G1 X95.024 Y143.538 E.02394
; WIPE_START
G1 X94.964 Y141.938 E-.60843
G1 X94.565 Y141.938 E-.15157
; WIPE_END
G1 E-.04 F1800
G1 X86.936 Y142.173 Z4.2 F30000
G1 X81.345 Y142.345 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F8843.478
G1 X94.557 Y142.345 E.43827
G1 X94.557 Y161.949 E.65031
G1 X80.953 Y161.949 E.45127
G1 X80.953 Y142.345 E.65031
G1 X81.285 Y142.345 E.01102
M204 S250
G1 X81.345 Y142.737 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.941 Y143.533 Z4.2 F30000
G1 X95.153 Y143.945 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X95.153 Y146.349 E.07975
G1 X96.153 Y146.349 E.03317
G1 X96.153 Y163.545 E.57042
G1 X79.357 Y163.545 E.55715
G1 X79.357 Y140.749 E.75618
G1 X96.153 Y140.749 E.55715
G1 X96.153 Y143.945 E.10601
G1 X95.213 Y143.945 E.03118
M204 S250
G1 X95.545 Y144.337 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 19 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer19 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
M204 S10000
G1 X94.855 Y143.742 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.23172
G1 F15000
M73 P88 R3
G1 X94.855 Y146.553 E.04325
G1 X95.355 Y146.96 F30000
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y162.56 E.47627
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y162.715 E.00532
G1 X95.245 Y162.731 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.168 Y162.747 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.342 Y162.747 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y162.715 E.00532
G1 X80.171 Y162.638 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.155 Y162.56 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X80.155 Y141.735 E.6358
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X80.187 Y141.58 E.00532
G1 X80.265 Y141.563 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X80.342 Y141.547 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.168 Y141.547 E.45262
; LINE_WIDTH: 0.455078
G1 F8734.513
G1 X95.323 Y141.58 E.00532
G1 X95.339 Y141.657 E.00266
; LINE_WIDTH: 0.43365
G1 F9213.523
G1 X95.355 Y141.735 E.00252
; LINE_WIDTH: 0.41758
G1 F9608.712
G1 X95.355 Y143.335 E.04885
; OBJECT_ID: 236
; WIPE_START
G1 X95.355 Y141.735 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X94.64 Y134.136 Z4.2 F30000
G1 X92.366 Y109.965 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X91.093 Y108.693 E.05971
G1 X80.615 Y119.171 E.49155
G1 X95.336 Y133.892 E.69058
G1 X105.814 Y123.413 E.49155
G1 X98.884 Y116.484 E.32508
G1 X99.295 Y116.072 E.0193
G1 X106.636 Y123.413 E.34438
G1 X95.336 Y134.714 E.53014
G1 X79.792 Y119.171 E.72917
G1 X91.093 Y107.87 E.53014
G1 X92.777 Y109.554 E.07901
G1 X92.408 Y109.923 E.01731
; WIPE_START
G1 X91.093 Y108.693 E-.68438
G1 X90.952 Y108.833 E-.07562
; WIPE_END
G1 E-.04 F1800
G1 X92.395 Y116.328 Z4.2 F30000
G1 X95.613 Y133.039 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F8843.478
G1 X95.336 Y133.316 E.01301
G1 X81.191 Y119.171 E.66357
G1 X91.093 Y109.268 E.46454
G1 X105.238 Y123.413 E.66357
G1 X95.655 Y132.996 E.44955
M204 S250
G1 X95.336 Y132.761 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.27 Y123.79 Z4.2 F30000
G1 X96.888 Y114.504 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X98.588 Y116.204 E.07975
G1 X99.295 Y115.497 E.03317
G1 X107.212 Y123.413 E.37139
G1 X95.336 Y135.29 E.55715
G1 X79.217 Y119.171 E.75618
G1 X91.093 Y107.294 E.55715
G1 X93.353 Y109.554 E.10601
G1 X92.646 Y110.261 E.03317
G1 X94.346 Y111.961 E.07975
G1 X95.053 Y111.254 E.03317
G1 X95.474 Y111.675 E.01977
G1 X94.767 Y112.383 E.03317
G1 X96.467 Y114.083 E.07975
G1 X97.174 Y113.375 E.03317
G1 X97.595 Y113.797 E.01977
G1 X96.931 Y114.461 E.03118
M204 S250
G1 X97.443 Y114.504 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X91.178 Y106.825 E.00369
G1 X93.907 Y109.554 E.11861
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.321 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
M204 S10000
G1 X97.241 Y113.73 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.231718
G1 F15000
G1 X96.542 Y114.429 E.01521
G1 X94.42 Y112.308 F30000
; LINE_WIDTH: 0.231723
G1 F15000
G1 X95.12 Y111.609 E.01521
; WIPE_START
G1 X94.42 Y112.308 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.428 Y109.616 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.2177
G1 F15000
G1 X91.155 Y108.343 E.02564
G1 X91.093 Y108.303 E.00105
G1 X91.031 Y108.343 E.00105
G1 X80.265 Y119.109 E.21684
G1 X80.225 Y119.171 E.00105
G1 X80.265 Y119.233 E.00105
G1 X95.274 Y134.241 E.3023
G1 X95.336 Y134.282 E.00105
G1 X95.397 Y134.241 E.00105
G1 X106.163 Y123.475 E.21684
G1 X106.204 Y123.413 E.00105
G1 X106.163 Y123.352 E.00105
G1 X99.234 Y116.422 E.13958
; OBJECT_ID: 225
; WIPE_START
G1 X100.648 Y117.836 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X106.325 Y112.735 Z4.2 F30000
G1 X145.197 Y77.807 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X143.497 Y77.807 E.05639
G1 X143.497 Y92.425 E.48492
G1 X164.116 Y92.425 E.68395
G1 X164.116 Y77.807 E.48492
G1 X151.416 Y77.807 E.42128
G1 X151.416 Y77.125 E.02261
G1 X164.797 Y77.125 E.4439
G1 X164.797 Y93.107 E.53014
G1 X142.816 Y93.107 E.72917
G1 X142.816 Y77.125 E.53014
G1 X145.197 Y77.125 E.07901
G1 X145.197 Y77.747 E.02062
; WIPE_START
G1 X143.497 Y77.807 E-.6464
G1 X143.497 Y78.106 E-.1136
; WIPE_END
G1 E-.04 F1800
G1 X144.296 Y78.214 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
G1 F8843.478
G1 X163.709 Y78.214 E.64393
G1 X163.709 Y92.018 E.45791
G1 X143.904 Y92.018 E.65694
G1 X143.904 Y78.214 E.45791
G1 X144.236 Y78.214 E.01102
M204 S250
G1 X144.296 Y78.606 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.997 Y77.718 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X148.009 Y77.718 E.06674
G1 X148.009 Y76.718 E.03317
G1 X148.604 Y76.718 E.01977
G1 X148.604 Y77.718 E.03317
G1 X151.009 Y77.718 E.07975
G1 X151.009 Y76.718 E.03317
G1 X165.204 Y76.718 E.4709
G1 X165.204 Y93.514 E.55715
G1 X142.409 Y93.514 E.75618
G1 X142.409 Y76.718 E.55715
G1 X145.604 Y76.718 E.10601
G1 X145.604 Y77.718 E.03317
G1 X145.937 Y77.718 E.01102
M204 S250
G1 X145.996 Y77.326 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
M204 S10000
G1 X145.401 Y77.966 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.132106
G1 F15000
G1 X148.212 Y77.966 E.02043
G1 X148.256 Y77.944 E.00036
; LINE_WIDTH: 0.19832
G1 X148.301 Y77.922 E.00063
; LINE_WIDTH: 0.22612
G1 X148.306 Y77.916 E.00012
G1 X148.306 Y76.922 F30000
; LINE_WIDTH: 0.231676
G1 F15000
G1 X148.312 Y77.922 E.01538
; LINE_WIDTH: 0.19832
G1 X148.356 Y77.944 E.00063
; LINE_WIDTH: 0.15392
G1 X148.401 Y77.966 E.00045
; LINE_WIDTH: 0.13172
G1 X151.212 Y77.966 E.02034
G1 X151.619 Y77.466 F30000
; LINE_WIDTH: 0.31791
G1 F13091.396
G1 X164.319 Y77.466 E.28458
G1 X164.433 Y77.49 E.0026
G1 X164.457 Y77.604 E.0026
G1 X164.457 Y92.629 E.33669
G1 X164.433 Y92.743 E.0026
G1 X164.319 Y92.766 E.0026
G1 X143.294 Y92.766 E.47114
G1 X143.18 Y92.743 E.0026
G1 X143.156 Y92.629 E.0026
G1 X143.156 Y77.604 E.33669
G1 X143.18 Y77.49 E.0026
G1 X143.294 Y77.466 E.0026
G1 X144.994 Y77.466 E.03809
; OBJECT_ID: 247
; WIPE_START
G1 X143.294 Y77.466 E-.646
G1 X143.18 Y77.49 E-.04415
G1 X143.156 Y77.604 E-.04415
G1 X143.156 Y77.671 E-.0257
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X135.991 Y80.299 Z4.2 F30000
G1 X112.992 Y88.732 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X120.051 Y81.673 E.33111
G1 X131.351 Y92.974 E.53014
G1 X124.293 Y100.032 E.33111
G1 X113.035 Y88.774 E.52815
G1 X112.417 Y88.732 F30000
G1 F8843.478
G1 X120.051 Y81.098 E.35812
G1 X131.927 Y92.974 E.55715
G1 X124.293 Y100.608 E.35812
G1 X112.459 Y88.774 E.55516
M204 S250
G1 X111.862 Y88.732 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.348 Y88.608 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43061
G1 F9285.769
G1 X124.297 Y99.557 E.4892
G1 X124.571 Y99.283 E.01225
G1 X113.742 Y88.454 E.48384
G1 X114.016 Y88.18 E.01225
G1 X124.845 Y99.009 E.48384
G1 X125.119 Y98.735 E.01225
G1 X114.29 Y87.905 E.48384
G1 X114.564 Y87.631 E.01225
G1 X125.394 Y98.461 E.48384
G1 X125.668 Y98.187 E.01225
G1 X114.838 Y87.357 E.48384
G1 X115.112 Y87.083 E.01225
G1 X125.942 Y97.912 E.48384
G1 X126.216 Y97.638 E.01225
G1 X115.386 Y86.809 E.48384
G1 X115.661 Y86.535 E.01225
G1 X126.49 Y97.364 E.48384
G1 X126.764 Y97.09 E.01225
G1 X115.935 Y86.261 E.48384
G1 X116.209 Y85.986 E.01225
G1 X127.038 Y96.816 E.48384
G1 X127.313 Y96.542 E.01225
G1 X116.483 Y85.712 E.48384
G1 X116.757 Y85.438 E.01225
G1 X127.587 Y96.268 E.48384
G1 X127.861 Y95.994 E.01225
G1 X117.031 Y85.164 E.48384
G1 X117.305 Y84.89 E.01225
G1 X128.135 Y95.719 E.48384
G1 X128.409 Y95.445 E.01225
G1 X117.58 Y84.616 E.48384
G1 X117.854 Y84.342 E.01225
G1 X128.683 Y95.171 E.48384
G1 X128.957 Y94.897 E.01225
G1 X118.128 Y84.067 E.48384
G1 X118.402 Y83.793 E.01225
G1 X129.231 Y94.623 E.48384
G1 X129.506 Y94.349 E.01225
G1 X118.676 Y83.519 E.48384
G1 X118.95 Y83.245 E.01225
G1 X129.78 Y94.075 E.48384
G1 X130.054 Y93.8 E.01225
G1 X119.224 Y82.971 E.48384
G1 X119.499 Y82.697 E.01225
G1 X130.328 Y93.526 E.48384
G1 X130.602 Y93.252 E.01225
G1 X119.773 Y82.423 E.48384
G1 X120.047 Y82.149 E.01225
G1 X130.996 Y93.098 E.4892
; OBJECT_ID: 258
; WIPE_START
G1 X129.582 Y91.684 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X122.485 Y94.493 Z4.2 F30000
G1 X105.45 Y101.235 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
M73 P89 R3
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X100.705 Y90.594 E.22084
G1 X108.67 Y98.559 E.37365
; WIPE_START
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z4.2 F30000
G1 X98.384 Y93.76 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F8843.478
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z4.2 F30000
G1 X109.288 Y98.601 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
M73 P89 R2
G1 X95.998 Y85.31 E.42446
G1 X100.993 Y90.306 E.23435
G1 X109.246 Y98.559 E.38716
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X101.27 Y90.029 E.22912
G1 X109.8 Y98.559 E.37067
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.47 Y99.289 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X108.158 Y98.601 E.0299
G1 X107.47 Y97.913 E.0299
; LINE_WIDTH: 0.436413
G1 F9148.84
G1 X106.624 Y97.09 E.03786
; LINE_WIDTH: 0.469258
G1 F8444.015
G1 X105.777 Y96.267 E.04102
; LINE_WIDTH: 0.50593
G1 F7775.21
G1 X105.583 Y96.101 E.00963
; LINE_WIDTH: 0.55895
G1 F6976.337
G3 X105.16 Y95.706 I2.268 J-2.857 E.02436
G1 X105.025 Y95.921 E.01065
; LINE_WIDTH: 0.543298
G1 F7194.569
G1 X104.974 Y95.943 E.00228
; LINE_WIDTH: 0.516533
G1 F7601.151
G1 X104.923 Y95.966 E.00216
; LINE_WIDTH: 0.480643
G1 F8224.389
G1 X104.829 Y95.964 E.00335
; LINE_WIDTH: 0.416738
G1 F9630.355
G1 X104.735 Y95.962 E.00286
G1 X99.972 Y94.698 E.15011
G1 X99.766 Y94.446 E.00991
G1 X98.532 Y89.807 E.14624
G3 X98.656 Y89.52 I.341 J-.022 E.00988
G1 X98.911 Y89.354 E.00928
G1 X95.998 Y86.44 E.1255
G1 X94.047 Y88.391 E.08403
G1 X97.956 Y89.438 E.12327
G1 X98.063 Y89.515 E.00401
G1 X99.302 Y94.113 E.14506
G1 X99.254 Y94.297 E.00581
G1 X95.933 Y97.618 E.14304
G1 X95.783 Y97.67 E.00483
G1 X95.752 Y97.663 E.00098
G1 X91.542 Y96.535 E.13277
G1 X91.126 Y96.401 E.01329
G1 X91.078 Y96.317 E.00297
G1 X90.03 Y92.408 E.12327
G1 X88.08 Y94.358 E.08403
G1 X90.993 Y97.272 E.1255
G1 X91.291 Y96.916 E.01413
G1 X91.446 Y96.893 E.00476
G1 X95.656 Y98.021 E.13277
G1 X95.936 Y98.117 E.00901
G1 X96.054 Y98.311 E.00691
G1 X96.052 Y98.533 E.00676
G1 X96.325 Y98.616 E.00868
G3 X96.481 Y98.917 I-.271 J.332 E.01062
G1 X97.601 Y103.096 E.13179
; LINE_WIDTH: 0.435628
G1 F9167.128
G1 X97.603 Y103.19 E.00301
; LINE_WIDTH: 0.480643
G1 F8224.389
G1 X97.605 Y103.284 E.00335
; LINE_WIDTH: 0.519035
G1 F7561.199
G1 X97.57 Y103.355 E.00309
; LINE_WIDTH: 0.555218
G1 F7027.159
G1 X97.535 Y103.427 E.00333
G1 X97.345 Y103.52 E.00883
G1 X97.737 Y103.933 E.02373
; LINE_WIDTH: 0.52376
G1 F7486.898
G1 X97.821 Y104.035 E.00521
; LINE_WIDTH: 0.49838
G1 F7904.097
G1 X97.906 Y104.138 E.00493
; LINE_WIDTH: 0.469265
G1 F8443.866
G1 X98.729 Y104.984 E.04102
; LINE_WIDTH: 0.422975
G1 F9472.327
G2 X100.24 Y106.519 I55.93 J-53.572 E.0667
G1 X102.12 Y104.639 E.08234
G1 X100.492 Y104.203 E.0522
; LINE_WIDTH: 0.436415
G1 F9148.782
G1 X99.347 Y103.913 E.03786
; LINE_WIDTH: 0.469265
G1 F8443.866
G1 X98.203 Y103.623 E.04102
; LINE_WIDTH: 0.49838
G1 F7904.097
G1 X98.144 Y103.604 E.00229
; LINE_WIDTH: 0.539241
G1 F7253.375
G1 X98.086 Y103.584 E.0025
G1 X98.012 Y103.476 E.00529
; LINE_WIDTH: 0.532745
G1 F7349.563
G1 X97.994 Y103.317 E.00637
; LINE_WIDTH: 0.484895
G1 F8145.257
G1 X97.976 Y103.159 E.00575
; LINE_WIDTH: 0.415832
G1 F9653.768
G1 X97.959 Y103 E.00485
G1 X96.839 Y98.821 E.13147
G1 X96.874 Y98.65 E.00529
G3 X100.316 Y95.217 I598.168 J596.196 E.14772
G1 X100.46 Y95.2 E.0044
G1 X104.639 Y96.32 E.13147
; LINE_WIDTH: 0.432315
G1 F9245.111
G1 X104.761 Y96.332 E.00388
; LINE_WIDTH: 0.470705
G1 F8415.443
G1 X104.883 Y96.345 E.00427
; LINE_WIDTH: 0.509095
G1 F7722.422
G1 X105.004 Y96.358 E.00465
; LINE_WIDTH: 0.550901
G1 F7086.883
G1 X105.126 Y96.371 E.00507
G1 X105.252 Y96.478 E.00686
; LINE_WIDTH: 0.526548
G1 F7443.745
G1 X105.257 Y96.521 E.0017
; LINE_WIDTH: 0.499303
G1 F7888.12
G1 X105.263 Y96.564 E.0016
; LINE_WIDTH: 0.469258
G1 F8444.015
G1 X105.552 Y97.708 E.04102
; LINE_WIDTH: 0.424307
G1 F9439.234
G2 X106.278 Y100.481 I100.001 J-24.7 E.08908
G1 X107.428 Y99.332 E.05052
G1 X107.203 Y99.022 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X107.625 Y98.601 E.01831
G1 X105.63 Y96.607 E.08666
G1 X106.473 Y99.752 E.10007
G1 X107.161 Y99.065 E.02988
G1 X106.926 Y98.745 F30000
; LINE_WIDTH: 0.45042
G1 F8834.356
G1 X107.07 Y98.601 E.00677
G1 X106.388 Y97.919 E.03202
G1 X106.676 Y98.995 E.03697
G1 X106.883 Y98.787 E.00973
; WIPE_START
G1 X106.676 Y98.995 E-.11131
G1 X106.388 Y97.919 E-.42308
G1 X106.808 Y98.339 E-.22561
; WIPE_END
G1 E-.04 F1800
G1 X99.889 Y95.117 Z4.2 F30000
G1 X99.815 Y95.082 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.551995
G1 F7071.65
G1 X99.592 Y94.945 E.01085
G1 X99.44 Y94.738 E.01068
G1 X96.305 Y97.873 E.18392
G1 X96.525 Y98.214 E.01688
G1 X96.615 Y98.282 E.00466
G1 X99.772 Y95.125 E.18524
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.38491
G1 F10526.624
G1 X98.319 Y89.271 E.00386
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.414003
G1 F9701.353
G1 X98.076 Y89.04 E.00595
G3 X95.998 Y86.974 I263.458 J-267.155 E.08861
G1 X94.775 Y88.196 E.05227
G3 X98.051 Y89.083 I-111.944 J419.901 E.10262
G1 X98.168 Y89.144 E.004
G1 X96.741 Y88.297 F30000
; LINE_WIDTH: 0.48703
G1 F8106.101
G1 X95.998 Y87.554 E.03803
G1 X95.569 Y87.983 E.02196
G1 X96.683 Y88.282 E.04174
; WIPE_START
G1 X95.569 Y87.983 E-.43827
G1 X95.998 Y87.554 E-.23054
G1 X96.167 Y87.724 E-.0912
; WIPE_END
G1 E-.04 F1800
G1 X92.276 Y94.29 Z4.2 F30000
G1 X90.875 Y96.652 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.38078
G1 F10655.301
G1 X90.908 Y96.682 E.00121
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.41516
G1 F9671.191
G1 X90.719 Y96.413 E.00867
G3 X89.835 Y93.136 I643.553 J-175.384 E.10294
G1 X88.613 Y94.358 E.05243
G3 X90.835 Y96.607 I-113.45 J114.336 E.09591
G1 X89.937 Y95.101 F30000
; LINE_WIDTH: 0.48703
G1 F8106.101
G1 X89.623 Y93.929 E.04391
G1 X89.194 Y94.358 E.02196
G1 X89.894 Y95.059 E.03586
G1 X98.246 Y103.991 F30000
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X100.24 Y105.986 E.08666
G1 X101.392 Y104.834 E.05004
G1 X98.304 Y104.007 E.09823
G1 X99.558 Y104.749 F30000
; LINE_WIDTH: 0.45042
G1 F8834.356
G1 X100.24 Y105.431 E.03202
G1 X100.634 Y105.037 E.01849
G1 X99.616 Y104.765 E.03498
; WIPE_START
G1 X100.634 Y105.037 E-.40028
G1 X100.24 Y105.431 E-.21154
G1 X99.964 Y105.155 E-.14818
; WIPE_END
G1 E-.03999 F1800
G1 X103.023 Y104.264 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F8102.312
G1 X105.903 Y101.384 E.14748
; WIPE_START
G1 X104.489 Y102.798 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X96.918 Y101.83 Z4.2 F30000
G1 X95.28 Y101.621 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X94.129 Y100.47 E.05401
G1 X95.772 Y98.826 E.0771
G1 X95.815 Y98.886 E.00243
G1 X96.085 Y98.939 E.00914
G1 X96.548 Y100.665 E.05929
G1 X93.811 Y97.928 E.12839
G1 X92.238 Y97.507 E.05401
; WIPE_START
G1 X93.811 Y97.928 E-.61876
G1 X94.074 Y98.191 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F6780.812
G1 X93.192 Y88.779 E.16974
; WIPE_START
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.146 Y90.599 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X99.568 Y92.172 E.05401
G1 X102.304 Y94.908 E.12839
G1 X100.235 Y94.363 E.07098
G1 X102.109 Y92.49 E.08789
G1 X103.26 Y93.641 E.05401
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X102.109 Y92.49 E-.61876
G1 X101.846 Y92.753 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 20/30
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
M106 S232.05
; OBJECT_ID: 214
; start printing object, unique label id: 214
M624 CAAAAAAAAAA=
G17
G3 Z4.2 I-1.126 J-.462 P1  F30000
G1 X81.345 Y142.737 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X94.165 Y142.737 E.39392
G1 X94.165 Y161.557 E.57829
G1 X81.345 Y161.557 E.39392
G1 X81.345 Y142.797 E.57644
; WIPE_START
M204 S10000
G1 X83.345 Y142.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.917 Y143.75 Z4.4 F30000
G1 X95.545 Y144.337 Z4.4
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X95.545 Y145.957 E.04978
G1 X96.545 Y145.957 E.03073
G1 X96.545 Y163.937 E.55248
; object ids of layer 20 start: 214,225,236,247,258
M624 +AAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer20 end: 214,225,236,247,258
M625
G1 X78.965 Y163.937 E.54018
G1 X78.965 Y140.357 E.72455
G1 X96.545 Y140.357 E.54018
G1 X96.545 Y144.337 E.12229
G1 X95.605 Y144.337 E.02888
; WIPE_START
M204 S10000
G1 X95.545 Y145.957 E-.61602
G1 X95.924 Y145.957 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X96.109 Y153.588 Z4.4 F30000
G1 X96.338 Y163.029 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X95.636 Y163.73 E.03048
G1 X95.103 Y163.73
G1 X96.338 Y162.495 E.05365
G1 X96.338 Y161.962
G1 X94.57 Y163.73 E.07683
G1 X94.036 Y163.73
G1 X96.338 Y161.429 E.1
G1 X96.338 Y160.896
G1 X93.503 Y163.73 E.12317
G1 X92.97 Y163.73
G1 X96.338 Y160.362 E.14634
G1 X96.338 Y159.829
G1 X92.437 Y163.73 E.16952
G1 X91.903 Y163.73
G1 X93.869 Y161.765 E.0854
G1 X93.335 Y161.765
G1 X91.37 Y163.73 E.0854
G1 X90.837 Y163.73
G1 X92.802 Y161.765 E.0854
G1 X92.269 Y161.765
G1 X90.304 Y163.73 E.0854
G1 X89.77 Y163.73
G1 X91.736 Y161.765 E.0854
G1 X91.202 Y161.765
G1 X89.237 Y163.73 E.0854
G1 X88.704 Y163.73
G1 X90.669 Y161.765 E.0854
G1 X90.136 Y161.765
G1 X88.17 Y163.73 E.0854
G1 X87.637 Y163.73
G1 X89.602 Y161.765 E.0854
G1 X89.069 Y161.765
G1 X87.104 Y163.73 E.0854
G1 X86.571 Y163.73
G1 X88.536 Y161.765 E.0854
G1 X88.003 Y161.765
G1 X86.037 Y163.73 E.0854
G1 X85.504 Y163.73
G1 X87.469 Y161.765 E.0854
G1 X86.936 Y161.765
G1 X84.971 Y163.73 E.0854
G1 X84.438 Y163.73
G1 X86.403 Y161.765 E.0854
G1 X85.87 Y161.765
G1 X83.904 Y163.73 E.0854
G1 X83.371 Y163.73
G1 X85.336 Y161.765 E.0854
G1 X84.803 Y161.765
G1 X82.838 Y163.73 E.0854
G1 X82.305 Y163.73
G1 X84.27 Y161.765 E.0854
G1 X83.737 Y161.765
G1 X81.771 Y163.73 E.0854
G1 X81.238 Y163.73
G1 X83.203 Y161.765 E.0854
G1 X82.67 Y161.765
G1 X80.705 Y163.73 E.0854
G1 X80.172 Y163.73
G1 X82.137 Y161.765 E.0854
G1 X81.604 Y161.765
G1 X79.638 Y163.73 E.0854
G1 X79.172 Y163.663
G1 X81.138 Y161.698 E.0854
G1 X81.138 Y161.164
G1 X79.172 Y163.13 E.0854
G1 X79.172 Y162.596
G1 X81.138 Y160.631 E.0854
G1 X81.138 Y160.098
G1 X79.172 Y162.063 E.0854
G1 X79.172 Y161.53
G1 X81.138 Y159.565 E.0854
G1 X81.138 Y159.031
G1 X79.172 Y160.997 E.0854
G1 X79.172 Y160.463
G1 X81.138 Y158.498 E.0854
G1 X81.138 Y157.965
G1 X79.172 Y159.93 E.0854
G1 X79.172 Y159.397
G1 X81.138 Y157.432 E.0854
G1 X81.138 Y156.898
G1 X79.172 Y158.864 E.0854
G1 X79.172 Y158.33
G1 X81.138 Y156.365 E.0854
G1 X81.138 Y155.832
G1 X79.172 Y157.797 E.0854
G1 X79.172 Y157.264
G1 X81.138 Y155.299 E.0854
G1 X81.138 Y154.765
G1 X79.172 Y156.731 E.0854
G1 X79.172 Y156.197
G1 X81.138 Y154.232 E.0854
G1 X81.138 Y153.699
G1 X79.172 Y155.664 E.0854
G1 X79.172 Y155.131
G1 X81.138 Y153.165 E.0854
G1 X81.138 Y152.632
G1 X79.172 Y154.597 E.0854
G1 X79.172 Y154.064
G1 X81.138 Y152.099 E.0854
G1 X81.138 Y151.566
G1 X79.172 Y153.531 E.0854
G1 X79.172 Y152.998
G1 X81.138 Y151.032 E.0854
G1 X81.138 Y150.499
G1 X79.172 Y152.464 E.0854
G1 X79.172 Y151.931
G1 X81.138 Y149.966 E.0854
G1 X81.138 Y149.433
G1 X79.172 Y151.398 E.0854
G1 X79.172 Y150.865
G1 X81.138 Y148.899 E.0854
G1 X81.138 Y148.366
G1 X79.172 Y150.331 E.0854
G1 X79.172 Y149.798
G1 X81.138 Y147.833 E.0854
G1 X81.138 Y147.3
G1 X79.172 Y149.265 E.0854
G1 X79.172 Y148.732
G1 X81.138 Y146.766 E.0854
G1 X81.138 Y146.233
G1 X79.172 Y148.198 E.0854
G1 X79.172 Y147.665
G1 X81.138 Y145.7 E.0854
G1 X81.138 Y145.167
G1 X79.172 Y147.132 E.0854
G1 X79.172 Y146.599
G1 X81.138 Y144.633 E.0854
G1 X81.138 Y144.1
G1 X79.172 Y146.065 E.0854
G1 X79.172 Y145.532
G1 X81.138 Y143.567 E.0854
G1 X81.138 Y143.034
G1 X79.172 Y144.999 E.0854
; WIPE_START
M204 S10000
G1 X80.586 Y143.585 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X85.28 Y149.603 Z4.4 F30000
G1 X94.372 Y161.261 Z4.4
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X96.338 Y159.296 E.0854
G1 X96.338 Y158.763
G1 X94.372 Y160.728 E.0854
G1 X94.372 Y160.195
G1 X96.338 Y158.229 E.0854
G1 X96.338 Y157.696
G1 X94.372 Y159.661 E.0854
G1 X94.372 Y159.128
G1 X96.338 Y157.163 E.0854
G1 X96.338 Y156.63
G1 X94.372 Y158.595 E.0854
G1 X94.372 Y158.061
G1 X96.338 Y156.096 E.0854
G1 X96.338 Y155.563
G1 X94.372 Y157.528 E.0854
G1 X94.372 Y156.995
G1 X96.338 Y155.03 E.0854
G1 X96.338 Y154.496
G1 X94.372 Y156.462 E.0854
G1 X94.372 Y155.928
G1 X96.338 Y153.963 E.0854
G1 X96.338 Y153.43
G1 X94.372 Y155.395 E.0854
G1 X94.372 Y154.862
G1 X96.338 Y152.897 E.0854
G1 X96.338 Y152.363
G1 X94.372 Y154.329 E.0854
G1 X94.372 Y153.795
G1 X96.338 Y151.83 E.0854
G1 X96.338 Y151.297
G1 X94.372 Y153.262 E.0854
G1 X94.372 Y152.729
G1 X96.338 Y150.764 E.0854
G1 X96.338 Y150.23
G1 X94.372 Y152.196 E.0854
G1 X94.372 Y151.662
G1 X96.338 Y149.697 E.0854
M73 P90 R2
G1 X96.338 Y149.164
G1 X94.372 Y151.129 E.0854
G1 X94.372 Y150.596
G1 X96.338 Y148.631 E.0854
G1 X96.338 Y148.097
G1 X94.372 Y150.063 E.0854
G1 X94.372 Y149.529
G1 X96.338 Y147.564 E.0854
G1 X96.338 Y147.031
G1 X94.372 Y148.996 E.0854
G1 X94.372 Y148.463
G1 X96.338 Y146.498 E.0854
G1 X96.137 Y146.165
G1 X94.372 Y147.93 E.07669
G1 X94.372 Y147.396
G1 X95.604 Y146.165 E.05352
G1 X95.338 Y145.898
G1 X94.372 Y146.863 E.04194
G1 X94.372 Y146.33
G1 X95.338 Y145.365 E.04194
G1 X95.338 Y144.831
G1 X94.372 Y145.797 E.04194
G1 X94.372 Y145.263
G1 X95.338 Y144.298 E.04194
G1 X95.506 Y144.13
G1 X96.338 Y143.298 E.03615
G1 X96.338 Y142.765
G1 X94.372 Y144.73 E.0854
G1 X94.372 Y144.197
G1 X96.338 Y142.232 E.0854
G1 X96.338 Y141.698
G1 X94.372 Y143.664 E.0854
G1 X94.372 Y143.13
G1 X96.338 Y141.165 E.0854
G1 X96.338 Y140.632
G1 X94.372 Y142.597 E.0854
G1 X93.906 Y142.53
G1 X95.871 Y140.565 E.0854
G1 X95.338 Y140.565
G1 X93.373 Y142.53 E.0854
G1 X92.84 Y142.53
G1 X94.805 Y140.565 E.0854
G1 X94.272 Y140.565
G1 X92.306 Y142.53 E.0854
G1 X91.773 Y142.53
G1 X93.738 Y140.565 E.0854
G1 X93.205 Y140.565
G1 X91.24 Y142.53 E.0854
G1 X90.706 Y142.53
G1 X92.672 Y140.565 E.0854
G1 X92.138 Y140.565
G1 X90.173 Y142.53 E.0854
G1 X89.64 Y142.53
G1 X91.605 Y140.565 E.0854
G1 X91.072 Y140.565
G1 X89.107 Y142.53 E.0854
G1 X88.573 Y142.53
G1 X90.539 Y140.565 E.0854
G1 X90.005 Y140.565
G1 X88.04 Y142.53 E.0854
G1 X87.507 Y142.53
G1 X89.472 Y140.565 E.0854
G1 X88.939 Y140.565
G1 X86.974 Y142.53 E.0854
G1 X86.44 Y142.53
G1 X88.406 Y140.565 E.0854
G1 X87.872 Y140.565
G1 X85.907 Y142.53 E.0854
G1 X85.374 Y142.53
G1 X87.339 Y140.565 E.0854
G1 X86.806 Y140.565
G1 X84.841 Y142.53 E.0854
G1 X84.307 Y142.53
G1 X86.273 Y140.565 E.0854
G1 X85.739 Y140.565
G1 X83.774 Y142.53 E.0854
G1 X83.241 Y142.53
G1 X85.206 Y140.565 E.0854
G1 X84.673 Y140.565
G1 X82.708 Y142.53 E.0854
G1 X82.174 Y142.53
G1 X84.14 Y140.565 E.0854
G1 X83.606 Y140.565
G1 X81.641 Y142.53 E.0854
; WIPE_START
M204 S10000
G1 X83.055 Y141.116 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X83.073 Y140.565 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X79.172 Y144.466 E.16951
G1 X79.172 Y143.932
G1 X82.54 Y140.565 E.14634
G1 X82.007 Y140.565
G1 X79.172 Y143.399 E.12317
G1 X79.172 Y142.866
G1 X81.473 Y140.565 E.09999
G1 X80.94 Y140.565
G1 X79.172 Y142.333 E.07682
G1 X79.172 Y141.799
G1 X80.407 Y140.565 E.05365
G1 X79.874 Y140.565
G1 X79.172 Y141.266 E.03047
; OBJECT_ID: 236
; WIPE_START
M204 S10000
G1 X79.874 Y140.565 E-.37688
G1 X80.407 Y140.565 E-.20264
G1 X80.071 Y140.901 E-.18048
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 214
M625
; start printing object, unique label id: 236
M624 IAAAAAAAAAA=
G1 X86.806 Y137.31 Z4.4 F30000
G1 X95.336 Y132.761 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
G1 F9547.055
M204 S5000
G1 X81.745 Y119.171 E.59058
G1 X91.093 Y109.823 E.40621
G1 X104.684 Y123.413 E.59058
G1 X95.378 Y132.719 E.40437
; WIPE_START
M204 S10000
G1 X93.959 Y131.309 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.509 Y123.836 Z4.4 F30000
G1 X97.443 Y114.504 Z4.4
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X98.588 Y115.649 E.04978
G1 X99.295 Y114.942 E.03073
G1 X107.767 Y123.413 E.36811
G1 X95.336 Y135.844 E.54018
G1 X78.662 Y119.171 E.72455
G1 X91.093 Y106.74 E.54018
G1 X93.907 Y109.554 E.12229
G1 X93.2 Y110.261 E.03073
G1 X94.346 Y111.407 E.04978
G1 X95.053 Y110.7 E.03073
G1 X96.029 Y111.675 E.0424
G1 X95.322 Y112.383 E.03073
G1 X96.467 Y113.528 E.04978
G1 X97.174 Y112.821 E.03073
G1 X98.15 Y113.797 E.0424
G1 X97.485 Y114.461 E.02888
; WIPE_START
M204 S10000
G1 X98.588 Y115.649 E-.61602
G1 X98.856 Y115.381 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X104.447 Y120.578 Z4.4 F30000
G1 X107.149 Y123.089 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X95.011 Y135.226 E.52744
G1 X94.744 Y134.96
G1 X106.882 Y122.822 E.52744
G1 X106.615 Y122.556
G1 X94.478 Y134.693 E.52744
G1 X94.211 Y134.427
G1 X106.349 Y122.289 E.52744
G1 X106.082 Y122.022
G1 X104.834 Y123.27 E.05424
G1 X104.567 Y123.004
G1 X105.816 Y121.756 E.05424
G1 X105.549 Y121.489
G1 X104.301 Y122.737 E.05424
G1 X104.034 Y122.471
G1 X105.282 Y121.222 E.05424
G1 X105.016 Y120.956
G1 X103.767 Y122.204 E.05424
G1 X103.501 Y121.937
G1 X104.749 Y120.689 E.05424
G1 X104.482 Y120.422
G1 X103.234 Y121.671 E.05424
G1 X102.968 Y121.404
G1 X104.216 Y120.156 E.05424
G1 X103.949 Y119.889
G1 X102.701 Y121.137 E.05424
G1 X102.434 Y120.871
G1 X103.682 Y119.623 E.05424
G1 X103.416 Y119.356
G1 X102.168 Y120.604 E.05424
G1 X101.901 Y120.338
G1 X103.149 Y119.089 E.05424
G1 X102.883 Y118.823
G1 X101.634 Y120.071 E.05424
G1 X101.368 Y119.804
G1 X102.616 Y118.556 E.05424
G1 X102.349 Y118.289
G1 X101.101 Y119.538 E.05424
G1 X100.835 Y119.271
G1 X102.083 Y118.023 E.05424
G1 X101.816 Y117.756
G1 X100.568 Y119.004 E.05424
G1 X100.301 Y118.738
G1 X101.549 Y117.49 E.05424
G1 X101.283 Y117.223
G1 X100.035 Y118.471 E.05424
G1 X99.768 Y118.205
G1 X101.016 Y116.956 E.05424
G1 X100.75 Y116.69
G1 X99.501 Y117.938 E.05424
G1 X99.235 Y117.671
G1 X100.483 Y116.423 E.05424
G1 X100.216 Y116.156
G1 X98.968 Y117.405 E.05424
G1 X98.701 Y117.138
G1 X99.95 Y115.89 E.05424
G1 X99.683 Y115.623
G1 X98.435 Y116.871 E.05424
G1 X98.168 Y116.605
G1 X99.416 Y115.357 E.05424
G1 X98.443 Y115.797
G1 X97.902 Y116.338 E.02351
G1 X97.635 Y116.072
G1 X98.176 Y115.53 E.02351
G1 X97.909 Y115.264
G1 X97.368 Y115.805 E.02351
G1 X97.102 Y115.538
G1 X97.643 Y114.997 E.02351
G1 X97.376 Y114.731
G1 X96.835 Y115.272 E.02351
G1 X96.568 Y115.005
G1 X97.817 Y113.757 E.05424
G1 X97.55 Y113.49
G1 X96.302 Y114.738 E.05424
G1 X96.035 Y114.472
G1 X97.283 Y113.224 E.05424
G1 X96.31 Y113.664
G1 X95.769 Y114.205 E.02351
G1 X95.502 Y113.938
G1 X96.043 Y113.397 E.02351
G1 X95.776 Y113.131
G1 X95.235 Y113.672 E.02351
G1 X94.969 Y113.405
G1 X95.51 Y112.864 E.02351
G1 X95.243 Y112.597
G1 X94.702 Y113.139 E.02351
G1 X94.435 Y112.872
G1 X95.684 Y111.624 E.05424
G1 X95.417 Y111.357
G1 X94.169 Y112.605 E.05424
G1 X93.902 Y112.339
G1 X95.15 Y111.09 E.05424
G1 X94.177 Y111.531
G1 X93.636 Y112.072 E.02351
G1 X93.369 Y111.805
G1 X93.91 Y111.264 E.02351
G1 X93.643 Y110.998
G1 X93.102 Y111.539 E.02351
G1 X92.836 Y111.272
G1 X93.377 Y110.731 E.02351
G1 X93.11 Y110.464
G1 X92.569 Y111.006 E.02351
G1 X92.302 Y110.739
G1 X93.551 Y109.491 E.05424
G1 X93.284 Y109.224
G1 X92.036 Y110.472 E.05424
G1 X91.769 Y110.206
G1 X93.017 Y108.957 E.05424
G1 X92.751 Y108.691
G1 X91.502 Y109.939 E.05424
G1 X91.236 Y109.672
G1 X92.484 Y108.424 E.05424
; WIPE_START
M204 S10000
G1 X91.236 Y109.672 E-.67079
G1 X91.402 Y109.838 E-.08921
; WIPE_END
G1 E-.04 F1800
G1 X92.639 Y117.37 Z4.4 F30000
G1 X95.193 Y132.912 Z4.4
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X93.944 Y134.16 E.05424
G1 X93.678 Y133.893
G1 X94.926 Y132.645 E.05424
G1 X94.659 Y132.378
G1 X93.411 Y133.627 E.05424
G1 X93.145 Y133.36
G1 X94.393 Y132.112 E.05424
G1 X94.126 Y131.845
G1 X92.878 Y133.093 E.05424
G1 X92.611 Y132.827
G1 X93.86 Y131.579 E.05424
G1 X93.593 Y131.312
G1 X92.345 Y132.56 E.05424
G1 X92.078 Y132.294
G1 X93.326 Y131.045 E.05424
G1 X93.06 Y130.779
G1 X91.811 Y132.027 E.05424
G1 X91.545 Y131.76
G1 X92.793 Y130.512 E.05424
G1 X92.526 Y130.245
G1 X91.278 Y131.494 E.05424
G1 X91.012 Y131.227
G1 X92.26 Y129.979 E.05424
G1 X91.993 Y129.712
G1 X90.745 Y130.96 E.05424
G1 X90.478 Y130.694
G1 X91.727 Y129.446 E.05424
G1 X91.46 Y129.179
G1 X90.212 Y130.427 E.05424
G1 X89.945 Y130.16
G1 X91.193 Y128.912 E.05424
G1 X90.927 Y128.646
G1 X89.678 Y129.894 E.05424
G1 X89.412 Y129.627
G1 X90.66 Y128.379 E.05424
G1 X90.393 Y128.112
G1 X89.145 Y129.361 E.05424
G1 X88.879 Y129.094
G1 X90.127 Y127.846 E.05424
G1 X89.86 Y127.579
G1 X88.612 Y128.827 E.05424
G1 X88.345 Y128.561
G1 X89.593 Y127.313 E.05424
G1 X89.327 Y127.046
G1 X88.079 Y128.294 E.05424
G1 X87.812 Y128.027
G1 X89.06 Y126.779 E.05424
G1 X88.794 Y126.513
G1 X87.545 Y127.761 E.05424
G1 X87.279 Y127.494
G1 X88.527 Y126.246 E.05424
G1 X88.26 Y125.979
G1 X87.012 Y127.228 E.05424
G1 X86.746 Y126.961
G1 X87.994 Y125.713 E.05424
G1 X87.727 Y125.446
G1 X86.479 Y126.694 E.05424
G1 X86.212 Y126.428
G1 X87.46 Y125.179 E.05424
G1 X87.194 Y124.913
G1 X85.946 Y126.161 E.05424
G1 X85.679 Y125.894
G1 X86.927 Y124.646 E.05424
G1 X86.661 Y124.38
G1 X85.412 Y125.628 E.05424
G1 X85.146 Y125.361
G1 X86.394 Y124.113 E.05424
G1 X86.127 Y123.846
G1 X84.879 Y125.095 E.05424
G1 X84.612 Y124.828
G1 X85.861 Y123.58 E.05424
G1 X85.594 Y123.313
G1 X84.346 Y124.561 E.05424
G1 X84.079 Y124.295
G1 X85.327 Y123.046 E.05424
G1 X85.061 Y122.78
G1 X83.813 Y124.028 E.05424
G1 X83.546 Y123.761
G1 X84.794 Y122.513 E.05424
G1 X84.528 Y122.247
G1 X83.279 Y123.495 E.05424
G1 X83.013 Y123.228
G1 X84.261 Y121.98 E.05424
G1 X83.994 Y121.713
G1 X82.746 Y122.962 E.05424
G1 X82.479 Y122.695
G1 X83.728 Y121.447 E.05424
G1 X83.461 Y121.18
G1 X82.213 Y122.428 E.05424
G1 X81.946 Y122.162
G1 X83.194 Y120.913 E.05424
G1 X82.928 Y120.647
G1 X81.68 Y121.895 E.05424
G1 X81.413 Y121.628
G1 X82.661 Y120.38 E.05424
G1 X82.395 Y120.114
G1 X81.146 Y121.362 E.05424
G1 X80.88 Y121.095
G1 X82.128 Y119.847 E.05424
G1 X81.861 Y119.58
G1 X80.613 Y120.828 E.05424
G1 X80.346 Y120.562
G1 X81.595 Y119.314 E.05424
; WIPE_START
M204 S10000
G1 X80.346 Y120.562 E-.67079
G1 X80.512 Y120.728 E-.08921
; WIPE_END
G1 E-.04 F1800
G1 X80.08 Y120.295 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X92.217 Y108.158 E.52744
G1 X91.951 Y107.891
G1 X79.813 Y120.029 E.52744
G1 X79.547 Y119.762
G1 X91.684 Y107.624 E.52744
G1 X91.418 Y107.358
G1 X79.28 Y119.495 E.52744
; WIPE_START
M204 S10000
G1 X80.694 Y118.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X88.184 Y119.548 Z4.4 F30000
G1 X107.398 Y123.311 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.332226
G1 F12443.586
G1 X95.233 Y135.475 E.40556
; WIPE_START
G1 X96.648 Y134.061 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.134 Y126.58 Z4.4 F30000
G1 X91.195 Y107.109 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.332141
G1 F12447.238
G1 X79.031 Y119.273 E.40544
; OBJECT_ID: 225
; WIPE_START
G1 X80.445 Y117.859 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 236
M625
; start printing object, unique label id: 225
M624 EAAAAAAAAAA=
G1 X86.947 Y113.862 Z4.4 F30000
G1 X144.296 Y78.606 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X163.316 Y78.606 E.58443
G1 X163.316 Y91.626 E.40007
G1 X144.296 Y91.626 E.58443
G1 X144.296 Y78.666 E.39822
; WIPE_START
M204 S10000
G1 X146.296 Y78.66 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.996 Y77.326 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S5000
G1 X147.616 Y77.326 E.04978
G1 X147.616 Y76.326 E.03073
G1 X148.996 Y76.326 E.0424
G1 X148.996 Y77.326 E.03073
G1 X150.616 Y77.326 E.04978
G1 X150.616 Y76.326 E.03073
G1 X165.597 Y76.326 E.46029
M73 P91 R2
G1 X165.597 Y93.906 E.54018
G1 X142.016 Y93.906 E.72455
G1 X142.016 Y76.326 E.54018
G1 X145.996 Y76.326 E.12229
G1 X145.996 Y77.266 E.02888
; WIPE_START
M204 S10000
G1 X147.616 Y77.326 E-.61602
G1 X147.616 Y76.947 E-.14398
; WIPE_END
G1 E-.04 F1800
G1 X153.281 Y82.063 Z4.4 F30000
G1 X165.389 Y92.998 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X164.688 Y93.699 E.03048
G1 X164.154 Y93.699
G1 X165.389 Y92.464 E.05365
G1 X165.389 Y91.931
G1 X163.621 Y93.699 E.07683
G1 X163.088 Y93.699
G1 X165.389 Y91.398 E.1
G1 X165.389 Y90.865
G1 X162.555 Y93.699 E.12317
G1 X162.021 Y93.699
G1 X165.389 Y90.331 E.14634
G1 X165.389 Y89.798
G1 X163.524 Y91.663 E.08105
G1 X163.524 Y91.13
G1 X165.389 Y89.265 E.08105
G1 X165.389 Y88.731
G1 X163.524 Y90.597 E.08105
G1 X163.524 Y90.063
G1 X165.389 Y88.198 E.08105
G1 X165.389 Y87.665
G1 X163.524 Y89.53 E.08105
G1 X163.524 Y88.997
G1 X165.389 Y87.132 E.08105
G1 X165.389 Y86.598
G1 X163.524 Y88.464 E.08105
G1 X163.524 Y87.93
G1 X165.389 Y86.065 E.08105
G1 X165.389 Y85.532
G1 X163.524 Y87.397 E.08105
G1 X163.524 Y86.864
G1 X165.389 Y84.999 E.08105
G1 X165.389 Y84.465
G1 X163.524 Y86.331 E.08105
G1 X163.524 Y85.797
G1 X165.389 Y83.932 E.08105
G1 X165.389 Y83.399
G1 X163.524 Y85.264 E.08105
G1 X163.524 Y84.731
G1 X165.389 Y82.866 E.08105
G1 X165.389 Y82.332
G1 X163.524 Y84.198 E.08105
G1 X163.524 Y83.664
G1 X165.389 Y81.799 E.08105
G1 X165.389 Y81.266
G1 X163.524 Y83.131 E.08105
G1 X163.524 Y82.598
G1 X165.389 Y80.733 E.08105
G1 X165.389 Y80.199
G1 X163.524 Y82.065 E.08105
G1 X163.524 Y81.531
G1 X165.389 Y79.666 E.08105
G1 X165.389 Y79.133
G1 X163.524 Y80.998 E.08105
G1 X163.524 Y80.465
G1 X165.389 Y78.6 E.08105
G1 X165.389 Y78.066
G1 X163.524 Y79.932 E.08105
G1 X163.524 Y79.398
G1 X165.389 Y77.533 E.08105
G1 X165.389 Y77
G1 X163.524 Y78.865 E.08105
G1 X163.457 Y78.399
G1 X165.322 Y76.534 E.08105
G1 X164.789 Y76.534
G1 X162.923 Y78.399 E.08105
G1 X162.39 Y78.399
G1 X164.255 Y76.534 E.08105
G1 X163.722 Y76.534
G1 X161.857 Y78.399 E.08105
G1 X161.324 Y78.399
G1 X163.189 Y76.534 E.08105
G1 X162.656 Y76.534
G1 X160.79 Y78.399 E.08105
G1 X160.257 Y78.399
G1 X162.122 Y76.534 E.08105
G1 X161.589 Y76.534
G1 X159.724 Y78.399 E.08105
G1 X159.191 Y78.399
G1 X161.056 Y76.534 E.08105
G1 X160.523 Y76.534
G1 X158.657 Y78.399 E.08105
G1 X158.124 Y78.399
G1 X159.989 Y76.534 E.08105
G1 X159.456 Y76.534
G1 X157.591 Y78.399 E.08105
G1 X157.058 Y78.399
G1 X158.923 Y76.534 E.08105
G1 X158.39 Y76.534
G1 X156.524 Y78.399 E.08105
G1 X155.991 Y78.399
G1 X157.856 Y76.534 E.08105
G1 X157.323 Y76.534
G1 X155.458 Y78.399 E.08105
G1 X154.925 Y78.399
G1 X156.79 Y76.534 E.08105
G1 X156.257 Y76.534
G1 X154.391 Y78.399 E.08105
G1 X153.858 Y78.399
G1 X155.723 Y76.534 E.08105
G1 X155.19 Y76.534
G1 X153.325 Y78.399 E.08105
G1 X152.792 Y78.399
G1 X154.657 Y76.534 E.08105
G1 X154.124 Y76.534
G1 X152.258 Y78.399 E.08105
G1 X151.725 Y78.399
G1 X153.59 Y76.534 E.08105
G1 X153.057 Y76.534
G1 X151.192 Y78.399 E.08105
G1 X150.659 Y78.399
G1 X152.524 Y76.534 E.08105
G1 X151.991 Y76.534
G1 X150.125 Y78.399 E.08105
G1 X150.457 Y77.534
G1 X149.592 Y78.399 E.0376
G1 X149.059 Y78.399
G1 X149.924 Y77.534 E.0376
G1 X149.391 Y77.534
G1 X148.526 Y78.399 E.0376
G1 X147.992 Y78.399
G1 X148.858 Y77.534 E.0376
G1 X148.789 Y77.069
G1 X147.459 Y78.399 E.0578
G1 X147.791 Y77.534
G1 X146.926 Y78.399 E.0376
G1 X146.392 Y78.399
G1 X147.258 Y77.534 E.0376
G1 X146.724 Y77.534
G1 X145.859 Y78.399 E.0376
G1 X145.326 Y78.399
G1 X146.191 Y77.534 E.0376
G1 X145.789 Y77.403
G1 X144.793 Y78.399 E.0433
G1 X144.259 Y78.399
G1 X145.789 Y76.869 E.06647
; WIPE_START
M204 S10000
G1 X144.375 Y78.284 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.824 Y77.501 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X148.789 Y76.536 E.04194
G1 X148.258 Y76.534
G1 X147.824 Y76.968 E.01885
; WIPE_START
M204 S10000
G1 X148.258 Y76.534 E-.23316
G1 X148.789 Y76.536 E-.20193
G1 X148.185 Y77.14 E-.32492
; WIPE_END
G1 E-.04 F1800
G1 X150.824 Y77.167 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X151.457 Y76.534 E.02753
; WIPE_START
M204 S10000
G1 X150.824 Y77.167 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X155.781 Y82.97 Z4.4 F30000
G1 X163.353 Y91.834 Z4.4
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X161.488 Y93.699 E.08105
G1 X160.955 Y93.699
G1 X162.82 Y91.834 E.08105
G1 X162.287 Y91.834
G1 X160.422 Y93.699 E.08105
G1 X159.888 Y93.699
G1 X161.754 Y91.834 E.08105
G1 X161.22 Y91.834
G1 X159.355 Y93.699 E.08105
G1 X158.822 Y93.699
G1 X160.687 Y91.834 E.08105
G1 X160.154 Y91.834
G1 X158.289 Y93.699 E.08105
G1 X157.755 Y93.699
G1 X159.621 Y91.834 E.08105
G1 X159.087 Y91.834
G1 X157.222 Y93.699 E.08105
G1 X156.689 Y93.699
G1 X158.554 Y91.834 E.08105
G1 X158.021 Y91.834
G1 X156.156 Y93.699 E.08105
G1 X155.622 Y93.699
G1 X157.488 Y91.834 E.08105
G1 X156.954 Y91.834
G1 X155.089 Y93.699 E.08105
G1 X154.556 Y93.699
G1 X156.421 Y91.834 E.08105
G1 X155.888 Y91.834
G1 X154.023 Y93.699 E.08105
G1 X153.489 Y93.699
G1 X155.355 Y91.834 E.08105
G1 X154.821 Y91.834
G1 X152.956 Y93.699 E.08105
G1 X152.423 Y93.699
G1 X154.288 Y91.834 E.08105
G1 X153.755 Y91.834
G1 X151.89 Y93.699 E.08105
G1 X151.356 Y93.699
G1 X153.222 Y91.834 E.08105
G1 X152.688 Y91.834
G1 X150.823 Y93.699 E.08105
G1 X150.29 Y93.699
G1 X152.155 Y91.834 E.08105
G1 X151.622 Y91.834
G1 X149.756 Y93.699 E.08105
G1 X149.223 Y93.699
G1 X151.088 Y91.834 E.08105
G1 X150.555 Y91.834
G1 X148.69 Y93.699 E.08105
G1 X148.157 Y93.699
G1 X150.022 Y91.834 E.08105
G1 X149.489 Y91.834
G1 X147.623 Y93.699 E.08105
G1 X147.09 Y93.699
G1 X148.955 Y91.834 E.08105
G1 X148.422 Y91.834
G1 X146.557 Y93.699 E.08105
G1 X146.024 Y93.699
G1 X147.889 Y91.834 E.08105
G1 X147.356 Y91.834
G1 X145.49 Y93.699 E.08105
G1 X144.957 Y93.699
G1 X146.822 Y91.834 E.08105
G1 X146.289 Y91.834
G1 X144.424 Y93.699 E.08105
G1 X143.891 Y93.699
G1 X145.756 Y91.834 E.08105
G1 X145.223 Y91.834
G1 X143.357 Y93.699 E.08105
G1 X142.824 Y93.699
G1 X144.689 Y91.834 E.08105
G1 X144.156 Y91.834
G1 X142.291 Y93.699 E.08105
G1 X142.224 Y93.233
G1 X144.089 Y91.367 E.08105
G1 X144.089 Y90.834
G1 X142.224 Y92.699 E.08105
G1 X142.224 Y92.166
G1 X144.089 Y90.301 E.08105
G1 X144.089 Y89.768
G1 X142.224 Y91.633 E.08105
G1 X142.224 Y91.1
G1 X144.089 Y89.234 E.08105
G1 X144.089 Y88.701
G1 X142.224 Y90.566 E.08105
G1 X142.224 Y90.033
G1 X144.089 Y88.168 E.08105
G1 X144.089 Y87.635
G1 X142.224 Y89.5 E.08105
G1 X142.224 Y88.967
G1 X144.089 Y87.101 E.08105
G1 X144.089 Y86.568
G1 X142.224 Y88.433 E.08105
G1 X142.224 Y87.9
G1 X144.089 Y86.035 E.08105
G1 X144.089 Y85.502
G1 X142.224 Y87.367 E.08105
G1 X142.224 Y86.834
G1 X144.089 Y84.968 E.08105
G1 X144.089 Y84.435
G1 X142.224 Y86.3 E.08105
G1 X142.224 Y85.767
G1 X144.089 Y83.902 E.08105
G1 X144.089 Y83.369
G1 X142.224 Y85.234 E.08105
G1 X142.224 Y84.701
G1 X144.089 Y82.835 E.08105
G1 X144.089 Y82.302
G1 X142.224 Y84.167 E.08105
G1 X142.224 Y83.634
G1 X144.089 Y81.769 E.08105
G1 X144.089 Y81.236
G1 X142.224 Y83.101 E.08105
G1 X142.224 Y82.568
G1 X144.089 Y80.702 E.08105
G1 X144.089 Y80.169
G1 X142.224 Y82.034 E.08105
G1 X142.224 Y81.501
G1 X144.089 Y79.636 E.08105
G1 X144.089 Y79.103
G1 X142.224 Y80.968 E.08105
G1 X142.224 Y80.435
G1 X144.089 Y78.569 E.08105
; WIPE_START
M204 S10000
G1 X142.675 Y79.984 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.224 Y79.901 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X145.591 Y76.534 E.14634
G1 X145.058 Y76.534
G1 X142.224 Y79.368 E.12317
G1 X142.224 Y78.835
G1 X144.525 Y76.534 E.09999
G1 X143.992 Y76.534
G1 X142.224 Y78.302 E.07682
G1 X142.224 Y77.768
G1 X143.458 Y76.534 E.05365
G1 X142.925 Y76.534
G1 X142.224 Y77.235 E.03047
; WIPE_START
M204 S10000
G1 X142.925 Y76.534 E-.37688
G1 X143.458 Y76.534 E-.20264
G1 X143.123 Y76.87 E-.18048
; WIPE_END
G1 E-.04 F1800
G1 X147.408 Y78.399 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108345
G1 F15000
G1 X147.226 Y78.366 E.00099
; WIPE_START
G1 X147.408 Y78.399 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.719 Y76.799 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.145484
G1 F15000
G2 X145.759 Y76.515 I-.323 J-.191 E.00246
; WIPE_START
G1 X145.759 Y76.702 E-.48547
G1 X145.719 Y76.799 E-.27453
; WIPE_END
G1 E-.04 F1800
G1 X144.189 Y78.329 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.159026
G1 F15000
G2 X144.019 Y78.499 I.055 J.226 E.0024
; WIPE_START
G1 X144.053 Y78.418 E-.26284
G1 X144.108 Y78.362 E-.23433
G1 X144.189 Y78.329 E-.26284
; WIPE_END
G1 E-.04 F1800
G1 X150.469 Y82.667 Z4.4 F30000
G1 X163.594 Y91.733 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.158959
G1 F15000
G3 X163.424 Y91.904 I-.226 J-.055 E.0024
; WIPE_START
G1 X163.505 Y91.87 E-.26305
G1 X163.56 Y91.815 E-.2339
G1 X163.594 Y91.733 E-.26305
; WIPE_END
G1 E-.04 F1800
G1 X158.16 Y86.374 Z4.4 F30000
G1 X150.075 Y78.399 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.108345
G1 F15000
G1 X149.892 Y78.366 E.00099
; WIPE_START
G1 X150.075 Y78.399 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X150.69 Y77.567 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F15000
G1 X150.508 Y77.533 E.00099
; OBJECT_ID: 247
; WIPE_START
G1 X150.69 Y77.567 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 225
M625
; start printing object, unique label id: 247
M624 QAAAAAAAAAA=
G1 X143.355 Y79.676 Z4.4 F30000
G1 X111.862 Y88.732 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X120.051 Y80.543 E.35582
G1 X132.482 Y92.974 E.54018
G1 X124.293 Y101.162 E.35582
G1 X111.905 Y88.774 E.53834
; WIPE_START
M204 S10000
G1 X113.312 Y87.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.652 Y89.445 Z4.4 F30000
G1 X131.852 Y92.638 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Top surface
G1 F9547.055
M204 S2000
G1 X123.957 Y100.533 E.34308
G1 X123.69 Y100.266
G1 X131.585 Y92.371 E.34308
G1 X131.319 Y92.105
G1 X123.424 Y100 E.34308
G1 X123.157 Y99.733
G1 X131.052 Y91.838 E.34308
G1 X130.785 Y91.571
G1 X122.89 Y99.466 E.34308
G1 X122.624 Y99.2
G1 X130.519 Y91.305 E.34308
G1 X130.252 Y91.038
G1 X122.357 Y98.933 E.34308
G1 X122.091 Y98.666
G1 X129.986 Y90.771 E.34308
G1 X129.719 Y90.505
G1 X121.824 Y98.4 E.34308
G1 X121.557 Y98.133
G1 X129.452 Y90.238 E.34308
G1 X129.186 Y89.972
G1 X121.291 Y97.867 E.34308
M73 P92 R2
G1 X121.024 Y97.6
G1 X128.919 Y89.705 E.34308
G1 X128.652 Y89.438
G1 X120.757 Y97.333 E.34308
G1 X120.491 Y97.067
G1 X128.386 Y89.172 E.34308
G1 X128.119 Y88.905
G1 X120.224 Y96.8 E.34308
G1 X119.958 Y96.533
G1 X127.853 Y88.638 E.34308
G1 X127.586 Y88.372
G1 X119.691 Y96.267 E.34308
G1 X119.424 Y96
G1 X127.319 Y88.105 E.34308
G1 X127.053 Y87.839
G1 X119.158 Y95.734 E.34308
G1 X118.891 Y95.467
G1 X126.786 Y87.572 E.34308
G1 X126.519 Y87.305
G1 X118.624 Y95.2 E.34308
G1 X118.358 Y94.934
G1 X126.253 Y87.039 E.34308
G1 X125.986 Y86.772
G1 X118.091 Y94.667 E.34308
G1 X117.824 Y94.4
G1 X125.719 Y86.505 E.34308
G1 X125.453 Y86.239
G1 X117.558 Y94.134 E.34308
G1 X117.291 Y93.867
G1 X125.186 Y85.972 E.34308
G1 X124.92 Y85.706
G1 X117.025 Y93.601 E.34308
G1 X116.758 Y93.334
G1 X124.653 Y85.439 E.34308
G1 X124.386 Y85.172
G1 X116.491 Y93.067 E.34308
G1 X116.225 Y92.801
G1 X124.12 Y84.906 E.34308
G1 X123.853 Y84.639
G1 X115.958 Y92.534 E.34308
G1 X115.691 Y92.267
G1 X123.586 Y84.372 E.34308
G1 X123.32 Y84.106
G1 X115.425 Y92.001 E.34308
G1 X115.158 Y91.734
G1 X123.053 Y83.839 E.34308
G1 X122.787 Y83.572
G1 X114.892 Y91.467 E.34308
G1 X114.625 Y91.201
G1 X122.52 Y83.306 E.34308
G1 X122.253 Y83.039
G1 X114.358 Y90.934 E.34308
G1 X114.092 Y90.668
G1 X121.987 Y82.773 E.34308
G1 X121.72 Y82.506
G1 X113.825 Y90.401 E.34308
G1 X113.558 Y90.134
G1 X121.453 Y82.239 E.34308
G1 X121.187 Y81.973
G1 X113.292 Y89.868 E.34308
G1 X113.025 Y89.601
G1 X120.92 Y81.706 E.34308
G1 X120.654 Y81.439
G1 X112.759 Y89.334 E.34308
G1 X112.492 Y89.068
G1 X120.387 Y81.173 E.34308
; WIPE_START
M204 S10000
G1 X118.973 Y82.587 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.983 Y87.291 Z4.4 F30000
G1 X132.107 Y92.866 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.348786
G1 F11769.856
G1 X124.185 Y100.788 E.27922
; WIPE_START
G1 X125.599 Y99.374 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.441 Y92.053 Z4.4 F30000
G1 X120.159 Y80.918 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.348702
G1 F11773.123
G1 X112.237 Y88.84 E.27915
; OBJECT_ID: 258
; WIPE_START
G1 X113.651 Y87.425 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 247
M625
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G1 X109.754 Y93.988 Z4.4 F30000
G1 X105.45 Y101.235 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X98.479 Y98.175 E.03659
G1 X100.594 Y96.06 E.09925
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X98.756 Y98.452 E.02694
G1 X100.712 Y96.497 E.08498
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X98.191 Y97.887 E.10705
G1 X97.245 Y98.834 E.04439
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X100.234 Y90.122 E.19873
G1 X108.67 Y98.559 E.39577
; WIPE_START
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z4.4 F30000
G1 X98.384 Y93.76 Z4.4
G1 Z4
G1 E.8 F1800
G1 F8843.478
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z4.4 F30000
G1 X109.288 Y98.601 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X100.522 Y89.834 E.21223
G1 X109.246 Y98.559 E.40927
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S5000
G1 X100.24 Y108.204 E.41728
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X100.799 Y89.557 E.20864
G1 X109.8 Y98.559 E.39116
; WIPE_START
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.714 Y97.095 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X107.866 Y98.247 E.05401
G1 X106.106 Y100.007 E.08257
G1 X106.255 Y100.566 E.01919
G1 X107.109 Y99.712 E.04002
G1 X105.631 Y98.235 E.06932
G1 X105.209 Y96.662 E.05401
; WIPE_START
G1 X105.631 Y98.235 E-.61877
G1 X105.894 Y98.498 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F8102.312
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.301 Y103.57 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X99.874 Y103.992 E.05401
G1 X101.352 Y105.469 E.06932
G1 X102.205 Y104.616 E.04002
G1 X101.646 Y104.467 E.01919
G1 X99.886 Y106.227 E.08257
G1 X98.734 Y105.075 E.05401
; WIPE_START
G1 X99.886 Y106.227 E-.61876
G1 X100.149 Y105.964 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X99.179 Y98.393 Z4.4 F30000
G1 X98.715 Y94.773 Z4.4
G1 Z4
G1 E.8 F1800
G1 F8843.478
G1 X97.564 Y95.925 E.05401
G1 X98.612 Y96.973 E.04919
G1 X99.764 Y95.822 E.05401
G1 X98.034 Y89.536 F30000
G1 F8843.478
G1 X96.486 Y89.09 E.05344
G1 X94.886 Y87.49 E.07506
G1 X93.962 Y88.414 E.04334
G1 X94.521 Y88.564 E.01919
G1 X96.352 Y86.733 E.08588
G1 X99.23 Y89.611 E.13504
G1 X98.303 Y90.539 E.04351
G1 X98.437 Y91.041 E.01726
G1 X103.435 Y96.039 E.23444
G1 X104.13 Y96.225 E.02389
G1 X104.987 Y95.368 E.04019
G1 X102.109 Y92.49 E.13504
G1 X94.129 Y100.47 E.37435
G1 X97.007 Y103.348 E.13504
G1 X97.864 Y102.491 E.04019
G1 X97.678 Y101.796 E.02389
G1 X92.68 Y96.798 E.23444
G1 X92.178 Y96.664 E.01726
G1 X91.25 Y97.591 E.04351
G1 X88.372 Y94.713 E.13504
G1 X90.203 Y92.882 E.08588
G1 X90.053 Y92.323 E.01919
G1 X89.129 Y93.247 E.04334
G1 X90.729 Y94.847 E.07506
G1 X91.175 Y96.395 E.05344
; WIPE_START
G1 X90.729 Y94.847 E-.61219
G1 X90.454 Y94.572 E-.14781
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z4.4 F30000
G1 Z4
M73 P92 R1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F6780.812
G1 X93.192 Y88.779 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 21/30
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
M106 S252.45
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z4.4 I-.765 J.947 P1  F30000
G1 X105.45 Y101.235 Z4.4
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3455
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X98.657 Y97.997 E.04495
G1 X100.594 Y96.06 E.0909
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3455
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X98.934 Y98.274 E.03468
G1 X100.712 Y96.497 E.07724
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3455
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X98.369 Y97.709 E.09869
G1 X97.245 Y98.834 E.05274
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X99.762 Y89.651 E.17661
G1 X108.67 Y98.559 E.41788
; WIPE_START
G1 F8843.478
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z4.6 F30000
G1 X98.384 Y93.76 Z4.6
G1 Z4.2
G1 E.8 F1800
G1 F3455
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3455
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z4.6 F30000
G1 X109.288 Y98.601 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3455
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X100.05 Y89.363 E.19012
G1 X109.246 Y98.559 E.43139
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3455
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 21 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer21 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
M73 P93 R1
G1 X100.327 Y89.086 E.18815
G1 X109.8 Y98.559 E.41164
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F3455
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.734 Y105.075 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3455
G1 X99.886 Y106.227 E.05401
G1 X101.646 Y104.467 E.08257
G1 X102.205 Y104.616 E.01919
G1 X101.352 Y105.469 E.04002
G1 X99.874 Y103.992 E.06932
G1 X98.301 Y103.57 E.05401
; WIPE_START
G1 F8843.478
G1 X99.874 Y103.992 E-.61877
G1 X100.137 Y104.255 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X99.8 Y96.63 Z4.6 F30000
G1 X99.764 Y95.822 Z4.6
G1 Z4.2
G1 E.8 F1800
G1 F3455
G1 X98.612 Y96.973 E.05401
G1 X97.564 Y95.925 E.04919
G1 X98.715 Y94.773 E.05401
; WIPE_START
G1 F8843.478
G1 X97.564 Y95.925 E-.61876
G1 X97.827 Y96.188 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X98.034 Y89.536 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
G1 F3455
G1 X96.486 Y89.09 E.05344
G1 X94.886 Y87.49 E.07506
G1 X93.962 Y88.414 E.04334
G1 X94.521 Y88.564 E.01919
G1 X96.352 Y86.733 E.08588
G1 X99.23 Y89.611 E.13504
G1 X98.303 Y90.539 E.04351
G1 X98.437 Y91.041 E.01726
G1 X103.435 Y96.039 E.23444
G1 X104.13 Y96.225 E.02389
G1 X104.987 Y95.368 E.04019
G1 X107.866 Y98.247 E.13504
G1 X106.106 Y100.007 E.08257
G1 X106.255 Y100.566 E.01919
G1 X107.109 Y99.712 E.04002
G1 X105.631 Y98.235 E.06932
G1 X105.209 Y96.662 E.05401
; WIPE_START
G1 F8843.478
G1 X105.631 Y98.235 E-.61877
G1 X105.894 Y98.498 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X98.338 Y97.418 Z4.6 F30000
G1 X91.175 Y96.395 Z4.6
G1 Z4.2
G1 E.8 F1800
G1 F3455
G1 X90.729 Y94.847 E.05344
G1 X89.129 Y93.247 E.07506
G1 X90.053 Y92.323 E.04334
G1 X90.203 Y92.882 E.01919
G1 X88.372 Y94.713 E.08588
G1 X91.25 Y97.591 E.13504
G1 X92.178 Y96.664 E.04351
G1 X92.68 Y96.798 E.01726
G1 X97.678 Y101.796 E.23444
G1 X97.864 Y102.491 E.02389
G1 X97.007 Y103.348 E.04019
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X100.957 Y91.338 E.05401
; WIPE_START
G1 F8843.478
G1 X102.109 Y92.49 E-.61876
G1 X101.846 Y92.753 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X94.91 Y89.568 Z4.6 F30000
G1 X93.192 Y88.779 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F3455
G1 X90.418 Y91.553 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.832 Y90.139 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 22/30
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z4.6 I-.769 J.943 P1  F30000
G1 X105.45 Y101.235 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3441
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3441
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3441
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X99.291 Y89.179 E.1545
G1 X108.67 Y98.559 E.44
; WIPE_START
G1 F8843.478
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z4.8 F30000
G1 X98.384 Y93.76 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F3441
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3441
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z4.8 F30000
G1 X109.288 Y98.601 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3441
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X99.579 Y88.892 E.168
G1 X109.246 Y98.559 E.4535
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3441
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 22 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer22 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X99.856 Y88.614 E.16767
G1 X109.8 Y98.559 E.43213
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.714 Y97.095 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3441
G1 X107.866 Y98.247 E.05401
G1 X106.106 Y100.007 E.08257
G1 X106.255 Y100.566 E.01919
G1 X107.109 Y99.712 E.04002
G1 X105.631 Y98.235 E.06932
G1 X105.209 Y96.662 E.05401
; WIPE_START
G1 F8843.478
G1 X105.631 Y98.235 E-.61877
G1 X105.894 Y98.498 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F3441
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.301 Y103.57 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3441
G1 X99.874 Y103.992 E.05401
G1 X101.352 Y105.469 E.06932
G1 X102.205 Y104.616 E.04002
G1 X101.646 Y104.467 E.01919
G1 X99.886 Y106.227 E.08257
G1 X98.734 Y105.075 E.05401
; WIPE_START
G1 F8843.478
G1 X99.886 Y106.227 E-.61876
G1 X100.149 Y105.964 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X99.179 Y98.393 Z4.8 F30000
G1 X98.715 Y94.773 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F3441
G1 X97.564 Y95.925 E.05401
G1 X98.612 Y96.973 E.04919
G1 X97.461 Y98.125 E.05401
; WIPE_START
G1 F8843.478
G1 X98.612 Y96.973 E-.61876
G1 X98.35 Y96.71 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X98.034 Y89.536 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
G1 F3441
G1 X96.486 Y89.09 E.05344
G1 X94.886 Y87.49 E.07506
G1 X93.962 Y88.414 E.04334
G1 X94.521 Y88.564 E.01919
G1 X96.352 Y86.733 E.08588
G1 X99.23 Y89.611 E.13504
G1 X98.303 Y90.539 E.04351
G1 X98.437 Y91.041 E.01726
G1 X103.435 Y96.039 E.23444
G1 X104.13 Y96.225 E.02389
G1 X104.987 Y95.368 E.04019
G1 X102.109 Y92.49 E.13504
G1 X94.129 Y100.47 E.37435
G1 X97.007 Y103.348 E.13504
G1 X97.864 Y102.491 E.04019
G1 X97.678 Y101.796 E.02389
G1 X92.68 Y96.798 E.23444
G1 X92.178 Y96.664 E.01726
G1 X91.25 Y97.591 E.04351
G1 X88.372 Y94.713 E.13504
G1 X90.203 Y92.882 E.08588
G1 X90.053 Y92.323 E.01919
G1 X89.129 Y93.247 E.04334
G1 X90.729 Y94.847 E.07506
G1 X91.175 Y96.395 E.05344
; WIPE_START
G1 F8843.478
G1 X90.729 Y94.847 E-.61219
G1 X90.454 Y94.572 E-.14781
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F3441
G1 X93.192 Y88.779 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 23/30
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z4.8 I-.765 J.947 P1  F30000
G1 X105.45 Y101.235 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3423
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X99.013 Y97.641 E.06166
G1 X100.594 Y96.06 E.07419
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3423
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X99.29 Y97.918 E.05016
G1 X100.712 Y96.497 E.06177
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z5 F30000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3423
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X98.725 Y97.353 E.08198
G1 X97.245 Y98.834 E.06945
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
M73 P94 R1
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X98.819 Y88.708 E.13238
G1 X108.67 Y98.559 E.46211
; WIPE_START
G1 F8843.478
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z5 F30000
G1 X98.384 Y93.76 Z5
G1 Z4.6
G1 E.8 F1800
G1 F3423
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3423
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z5 F30000
G1 X109.288 Y98.601 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3423
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X99.107 Y88.42 E.14589
G1 X109.246 Y98.559 E.47562
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3423
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 23 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer23 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X99.385 Y88.143 E.14718
G1 X109.8 Y98.559 E.45261
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z5 F30000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F3423
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.734 Y105.075 Z5 F30000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3423
G1 X99.886 Y106.227 E.05401
G1 X101.646 Y104.467 E.08257
G1 X102.205 Y104.616 E.01919
G1 X101.352 Y105.469 E.04002
G1 X99.874 Y103.992 E.06932
G1 X98.301 Y103.57 E.05401
; WIPE_START
G1 F8843.478
G1 X99.874 Y103.992 E-.61877
G1 X100.137 Y104.255 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X97.461 Y98.125 Z5 F30000
G1 Z4.6
G1 E.8 F1800
G1 F3423
G1 X98.612 Y96.973 E.05401
G1 X97.564 Y95.925 E.04919
G1 X98.715 Y94.773 E.05401
G1 X105.209 Y96.662 F30000
G1 F3423
G1 X105.631 Y98.235 E.05401
G1 X107.109 Y99.712 E.06932
G1 X106.255 Y100.566 E.04002
G1 X106.106 Y100.007 E.01919
G1 X107.866 Y98.247 E.08257
G1 X106.714 Y97.095 E.05401
; WIPE_START
G1 F8843.478
G1 X107.866 Y98.247 E-.61876
G1 X107.603 Y98.51 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X100.033 Y97.535 Z5 F30000
G1 X91.175 Y96.395 Z5
G1 Z4.6
G1 E.8 F1800
G1 F3423
G1 X90.729 Y94.847 E.05344
G1 X89.129 Y93.247 E.07506
G1 X90.053 Y92.323 E.04334
G1 X90.203 Y92.882 E.01919
G1 X88.372 Y94.713 E.08588
G1 X91.25 Y97.591 E.13504
G1 X92.178 Y96.664 E.04351
G1 X92.68 Y96.798 E.01726
G1 X97.678 Y101.796 E.23444
G1 X97.864 Y102.491 E.02389
G1 X97.007 Y103.348 E.04019
G1 X94.129 Y100.47 E.13504
G1 X102.109 Y92.49 E.37435
G1 X104.987 Y95.368 E.13504
G1 X104.13 Y96.225 E.04019
G1 X103.435 Y96.039 E.02389
G1 X98.437 Y91.041 E.23444
G1 X98.303 Y90.539 E.01726
G1 X99.23 Y89.611 E.04351
G1 X96.352 Y86.733 E.13504
G1 X94.521 Y88.564 E.08588
G1 X93.962 Y88.414 E.01919
G1 X94.886 Y87.49 E.04334
G1 X96.486 Y89.09 E.07506
G1 X98.034 Y89.536 E.05344
; WIPE_START
G1 F8843.478
G1 X96.486 Y89.09 E-.61219
G1 X96.211 Y88.815 E-.14781
; WIPE_END
G1 E-.04 F1800
G1 X93.192 Y88.779 Z5 F30000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F3423
G1 X90.418 Y91.553 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.832 Y90.139 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 24/30
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z5 I-.769 J.943 P1  F30000
G1 X105.45 Y101.235 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3412
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3412
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X102.41 Y96.952 E.05403
G1 X104.23 Y97.44 E.0579
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.707 Y95.869 Z5.2 F30000
G1 X98.384 Y93.76 Z5.2
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3412
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3412
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.95 Y97.279 Z5.2 F30000
G1 X108.713 Y98.601 Z5.2
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3412
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X98.348 Y88.237 E.11027
G1 X108.67 Y98.559 E.48423
G1 X109.288 Y98.601 F30000
G1 F3412
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X98.636 Y87.949 E.12377
G1 X109.246 Y98.559 E.49773
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3412
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 24 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer24 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X98.913 Y87.671 E.1267
G1 X109.8 Y98.559 E.4731
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.714 Y97.095 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3412
G1 X107.866 Y98.247 E.05401
G1 X106.106 Y100.007 E.08257
G1 X106.255 Y100.566 E.01919
G1 X107.109 Y99.712 E.04002
G1 X105.631 Y98.235 E.06932
G1 X105.209 Y96.662 E.05401
; WIPE_START
G1 F8843.478
G1 X105.631 Y98.235 E-.61877
G1 X105.894 Y98.498 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F3412
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.301 Y103.57 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3412
G1 X99.874 Y103.992 E.05401
G1 X101.352 Y105.469 E.06932
G1 X102.205 Y104.616 E.04002
G1 X101.646 Y104.467 E.01919
G1 X99.886 Y106.227 E.08257
G1 X98.734 Y105.075 E.05401
; WIPE_START
G1 F8843.478
G1 X99.886 Y106.227 E-.61876
G1 X100.149 Y105.964 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X99.179 Y98.393 Z5.2 F30000
G1 X98.715 Y94.773 Z5.2
G1 Z4.8
G1 E.8 F1800
G1 F3412
G1 X97.564 Y95.925 E.05401
G1 X98.612 Y96.973 E.04919
G1 X97.461 Y98.125 E.05401
; WIPE_START
G1 F8843.478
G1 X98.612 Y96.973 E-.61876
G1 X98.35 Y96.71 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X98.034 Y89.536 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
G1 F3412
G1 X96.486 Y89.09 E.05344
G1 X94.886 Y87.49 E.07506
G1 X93.962 Y88.414 E.04334
G1 X94.521 Y88.564 E.01919
G1 X96.352 Y86.733 E.08588
G1 X99.23 Y89.611 E.13504
G1 X98.303 Y90.539 E.04351
G1 X98.437 Y91.041 E.01726
G1 X103.435 Y96.039 E.23444
G1 X104.13 Y96.225 E.02389
G1 X104.987 Y95.368 E.04019
G1 X102.109 Y92.49 E.13504
G1 X94.129 Y100.47 E.37435
G1 X97.007 Y103.348 E.13504
G1 X97.864 Y102.491 E.04019
G1 X97.678 Y101.796 E.02389
G1 X92.68 Y96.798 E.23444
M73 P95 R1
G1 X92.178 Y96.664 E.01726
G1 X91.25 Y97.591 E.04351
G1 X88.372 Y94.713 E.13504
G1 X90.203 Y92.882 E.08588
G1 X90.053 Y92.323 E.01919
G1 X89.129 Y93.247 E.04334
G1 X90.729 Y94.847 E.07506
G1 X91.175 Y96.395 E.05344
; WIPE_START
G1 F8843.478
G1 X90.729 Y94.847 E-.61219
G1 X90.454 Y94.572 E-.14781
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F3412
G1 X93.192 Y88.779 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 25/30
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z5.2 I-.765 J.947 P1  F30000
G1 X105.45 Y101.235 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4188
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4188
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.707 Y95.869 Z5.4 F30000
G1 X98.384 Y93.76 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4188
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4188
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.95 Y97.279 Z5.4 F30000
G1 X108.713 Y98.601 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4188
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X97.877 Y87.765 E.08816
G1 X108.67 Y98.559 E.50634
G1 X109.288 Y98.601 F30000
G1 F4188
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X98.164 Y87.477 E.10166
G1 X109.246 Y98.559 E.51984
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4188
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 25 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer25 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X98.442 Y87.2 E.10621
G1 X109.8 Y98.559 E.49358
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.38 Y98.294 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4188
G1 X107.687 Y98.601 E.01439
G1 X106.842 Y99.446 E.03963
G1 X106.164 Y98.768 E.03178
G1 X105.743 Y97.195 E.05401
; WIPE_START
G1 F8843.478
G1 X106.164 Y98.768 E-.61877
G1 X106.427 Y99.031 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F4188
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.933 Y105.741 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4188
G1 X100.24 Y106.047 E.01439
G1 X101.085 Y105.203 E.03963
G1 X100.407 Y104.525 E.03178
G1 X98.835 Y104.104 E.05401
; WIPE_START
G1 F8843.478
G1 X100.407 Y104.525 E-.61877
G1 X100.67 Y104.788 E-.14123
; WIPE_END
G1 E-.04 F1800
G1 X98.035 Y97.625 Z5.4 F30000
G1 X98.01 Y97.555 Z5.4
G1 Z5
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383563
G1 F3000;_EXTRUDE_SET_SPEED
G1 X96.905 Y98.66 E.04337
G2 X96.864 Y98.814 I.057 J.098 E.0049
G1 X98.106 Y103.451 E.13325
G2 X98.219 Y103.563 I.113 J-.001 E.0049
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40408
;_EXTRUDE_SET_SPEED
G1 X100.065 Y104.058 E.05623
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.439338
;_EXTRUDE_SET_SPEED
G1 X101.91 Y104.552 E.06173
G1 X102.074 Y104.651 E.00618
G1 X101.982 Y104.819 E.00618
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.399252
;_EXTRUDE_SET_SPEED
G1 X100.353 Y106.448 E.06689
G1 X100.24 Y106.522 E.00391
G1 X100.128 Y106.448 E.00391
G1 X88.151 Y94.471 E.49181
G1 X88.077 Y94.358 E.00391
G1 X88.151 Y94.246 E.00391
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.404085
;_EXTRUDE_SET_SPEED
G1 X89.001 Y93.396 E.03537
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.43619
;_EXTRUDE_SET_SPEED
G1 X89.85 Y92.546 E.03851
G1 X90.018 Y92.454 E.00613
G1 X90.117 Y92.618 E.00613
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.383481
;_EXTRUDE_SET_SPEED
G1 X91.106 Y96.309 E.10606
G2 X91.218 Y96.422 I.113 J-.001 E.0049
G1 X95.759 Y97.638 E.13044
G2 X95.912 Y97.597 I.056 J-.098 E.0049
G1 X96.939 Y96.57 E.04031
; Slow Down End
G1 X98.013 Y97.046 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4188
G1 X98.277 Y97.309 E.01236
G1 X98.612 Y96.973 E.01576
G1 X97.564 Y95.925 E.04919
G1 X97.228 Y96.261 E.01576
G1 X97.495 Y96.527 E.01251
G1 X96.946 Y97.076 E.02575
G1 X98.161 Y95.348 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383563
G1 F3000;_EXTRUDE_SET_SPEED
G1 X99.236 Y94.273 E.0422
G2 X99.277 Y94.119 I-.057 J-.098 E.0049
G1 X98.061 Y89.579 E.13047
G2 X97.948 Y89.467 I-.113 J.001 E.0049
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40408
;_EXTRUDE_SET_SPEED
G1 X96.102 Y88.972 E.05623
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.439338
;_EXTRUDE_SET_SPEED
G1 X94.257 Y88.478 E.06172
G1 X94.093 Y88.379 E.00618
G1 X94.185 Y88.211 E.00618
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.399255
;_EXTRUDE_SET_SPEED
G1 X95.885 Y86.512 E.06979
G1 X95.998 Y86.438 E.00391
G1 X96.11 Y86.512 E.00391
G1 X108.087 Y98.488 E.49182
G1 X108.161 Y98.601 E.00391
G1 X108.087 Y98.714 E.00391
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.40408
;_EXTRUDE_SET_SPEED
G1 X107.272 Y99.528 E.0339
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.435844
;_EXTRUDE_SET_SPEED
G1 X106.458 Y100.342 E.03688
G1 X106.29 Y100.435 E.00613
G1 X106.192 Y100.271 E.00613
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.383474
;_EXTRUDE_SET_SPEED
G1 X105.202 Y96.58 E.10605
G2 X105.09 Y96.467 I-.113 J.001 E.0049
G1 X100.453 Y95.225 E.13321
G2 X100.299 Y95.266 I-.056 J.098 E.0049
G1 X99.232 Y96.334 E.04191
; Slow Down End
G1 X92.669 Y98.476 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4188
G1 X91.517 Y97.324 E.05401
G1 X91.87 Y96.972 E.01655
G1 X93.214 Y97.332 E.04615
G1 X97.144 Y101.262 E.18439
G1 X97.556 Y102.799 E.05278
G1 X97.274 Y103.081 E.01324
G1 X94.396 Y100.203 E.13504
G1 X101.842 Y92.756 E.34933
G1 X104.721 Y95.635 E.13504
G1 X104.438 Y95.917 E.01324
G1 X102.901 Y95.505 E.05278
G1 X98.971 Y91.575 E.18439
G1 X98.611 Y90.231 E.04615
G1 X98.964 Y89.878 E.01655
G1 X100.115 Y91.029 E.05401
G1 X97.526 Y88.978 F30000
G1 F4188
G1 X95.953 Y88.557 E.05401
G1 X95.153 Y87.757 E.03753
G1 X95.998 Y86.912 E.03963
G1 X96.304 Y87.219 E.01439
; WIPE_START
G1 F8843.478
G1 X95.998 Y86.912 E-.1648
G1 X95.153 Y87.757 E-.45396
G1 X95.416 Y88.019 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X93.192 Y88.779 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F4188
G1 X90.418 Y91.553 E.16974
; WIPE_START
G1 F6780.812
G1 X91.832 Y90.139 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X90.617 Y95.886 Z5.4 F30000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4188
G1 X90.196 Y94.314 E.05401
G1 X89.396 Y93.514 E.03753
G1 X88.551 Y94.358 E.03963
G1 X88.858 Y94.665 E.01439
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X88.551 Y94.358 E-.1648
G1 X89.396 Y93.514 E-.45396
G1 X89.659 Y93.776 E-.14124
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 26/30
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z5.4 I-.52 J1.1 P1  F30000
G1 X105.45 Y101.235 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F6090
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X99.547 Y97.107 E.08672
G1 X100.594 Y96.06 E.04913
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6090
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X99.824 Y97.384 E.07337
G1 X100.712 Y96.497 E.03855
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.713 Y98.601 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6090
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X99.259 Y96.819 E.05692
G1 X97.245 Y98.834 E.09452
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X97.405 Y87.294 E.06604
G1 X108.67 Y98.559 E.52846
; WIPE_START
G1 F8843.478
G1 X107.279 Y99.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.029 Y95.614 Z5.6 F30000
G1 X98.384 Y93.76 Z5.6
G1 Z5.2
G1 E.8 F1800
G1 F6090
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6090
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.974 Y97.193 Z5.6 F30000
G1 X109.288 Y98.601 Z5.6
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6090
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X97.693 Y87.006 E.07954
G1 X109.246 Y98.559 E.54196
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6090
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 26 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer26 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X97.97 Y86.729 E.08573
G1 X109.8 Y98.559 E.51407
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.795 Y99.548 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42047
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X106.519 Y100.272 E.05792
G1 X106.852 Y99.939 E.02662
G1 X105.838 Y98.925 E.08111
G1 X105.595 Y98.016 E.05323
G1 X107.184 Y99.606 E.12721
G1 X107.517 Y99.274 E.02662
G1 X105.351 Y97.107 E.17331
G1 X105.184 Y96.485 E.03644
G1 X104.562 Y96.319 E.03644
G1 X95.325 Y87.081 E.73905
G1 X95.658 Y86.749 E.02662
G1 X107.85 Y98.941 E.97548
G1 X108.182 Y98.608 E.02662
G1 X95.847 Y86.273 E.98694
M106 S252.45
G1 X94.184 Y87.936 F30000
M106 S255
G1 F3000
G1 X94.887 Y88.639 E.05626
G1 X95.796 Y88.883 E.05323
G1 X94.66 Y87.747 E.09091
G1 X94.992 Y87.414 E.02662
G1 X96.991 Y89.413 E.15992
M106 S252.45
; WIPE_START
G1 X95.577 Y87.999 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.115 Y90.536 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X103.653 Y96.075 E.44314
G1 X102.744 Y95.832 E.05323
G1 X98.645 Y91.732 E.32802
G1 X98.888 Y92.641 E.05323
G1 X101.835 Y95.588 E.23582
G1 X100.927 Y95.344 E.05323
G1 X99.132 Y93.549 E.14362
G1 X99.309 Y94.21 E.03871
G1 X99.218 Y94.301 E.00726
G1 X100.236 Y95.319 E.08147
G1 X99.904 Y95.652 E.02662
G1 X98.885 Y94.634 E.08147
G1 X98.553 Y94.966 E.02662
G1 X99.571 Y95.985 E.08147
G1 X99.238 Y96.317 E.02662
G1 X98.077 Y95.156 E.09293
M106 S252.45
G1 X98.579 Y96.945 F30000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F3000;_EXTRUDE_SET_SPEED
G1 X98.235 Y97.289 E.01495
G1 X97.248 Y96.302 E.04287
G1 X97.936 Y95.615 E.02989
G1 X98.923 Y96.601 E.04287
G1 X98.621 Y96.903 E.0131
; Slow Down End
G1 X97.936 Y96.302 F30000
; LINE_WIDTH: 0.6386
G1 F6043.513
G1 X98.192 Y96.559 E.01759
G1 X98.095 Y97.747 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.41977
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
M73 P96 R1
G1 X96.933 Y96.586 E.09262
G1 X96.601 Y96.918 E.02649
G1 X97.619 Y97.936 E.0812
G1 X97.287 Y98.269 E.02649
G1 X96.269 Y97.25 E.0812
G1 X95.937 Y97.582 E.02649
G1 X96.955 Y98.601 E.0812
G1 X96.832 Y98.723 E.00976
G1 X96.986 Y99.296 E.03346
G1 X95.18 Y97.49 E.14403
G1 X94.272 Y97.247 E.05298
G1 X97.229 Y100.204 E.23579
G1 X97.472 Y101.111 E.05298
G1 X93.365 Y97.004 E.32755
G1 X92.457 Y96.761 E.05298
G1 X97.715 Y102.019 E.41931
G1 X97.959 Y102.926 E.05298
G1 X88.719 Y93.687 E.73677
G1 X88.387 Y94.019 E.02649
G1 X100.579 Y106.211 E.97224
G1 X100.247 Y106.544 E.02649
G1 X87.912 Y94.208 E.98365
M106 S252.45
G1 X88.908 Y93.212 F30000
M106 S255
G1 F3000
G1 X90.767 Y95.07 E.14821
G1 X90.524 Y94.163 E.05298
G1 X89.384 Y93.023 E.09091
G1 X89.716 Y92.69 E.02649
G1 X90.567 Y93.542 E.06787
M106 S252.45
; WIPE_START
G1 X89.716 Y92.69 E-.45739
G1 X89.384 Y93.023 E-.17851
G1 X89.615 Y93.254 E-.1241
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
; LAYER_HEIGHT: 0.2
G1 F6090
G1 X93.192 Y88.779 E.16974
; WIPE_START
G1 F6780.812
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.217 Y97.007 Z5.6 F30000
G1 X98.457 Y103.425 Z5.6
G1 Z5.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41977
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X100.912 Y105.879 E.19574
G1 X101.244 Y105.547 E.02649
G1 X99.651 Y103.954 E.12703
G1 X100.558 Y104.197 E.05298
G1 X101.576 Y105.215 E.08115
G1 X101.908 Y104.883 E.02649
G1 X101.179 Y104.154 E.0581
M106 S252.45
; WIPE_START
G1 X101.908 Y104.883 E-.39156
G1 X101.576 Y105.215 E-.17851
G1 X101.222 Y104.861 E-.18993
; WIPE_END
G1 E-.04 F1800
G1 X103.023 Y104.264 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
; LAYER_HEIGHT: 0.2
G1 F6090
G1 X105.903 Y101.384 E.14748
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8102.312
G1 X104.489 Y102.798 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 27/30
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z5.6 I1.037 J.637 P1  F30000
G1 X105.45 Y101.235 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.707 Y95.869 Z5.8 F30000
G1 X98.384 Y93.76 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.95 Y97.279 Z5.8 F30000
G1 X108.713 Y98.601 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X96.934 Y86.822 E.04393
G1 X108.67 Y98.559 E.55057
G1 X109.288 Y98.601 F30000
G1 F4562
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X97.222 Y86.535 E.05743
G1 X109.246 Y98.559 E.56407
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 27 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer27 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X97.499 Y86.257 E.06524
G1 X109.8 Y98.559 E.53455
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.63 Y96.607 Z5.8 F30000
G1 Z5.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F4562
G1 X106.473 Y99.752 E.10007
G1 X107.625 Y98.601 E.05004
G1 X105.673 Y96.649 E.08482
G1 X106.388 Y97.919 F30000
; LINE_WIDTH: 0.45042
M73 P96 R0
G1 F4562
G1 X106.676 Y98.995 E.03697
G1 X107.07 Y98.601 E.01849
G1 X106.431 Y97.962 E.03003
; WIPE_START
G1 F8834.356
G1 X107.07 Y98.601 E-.3436
G1 X106.676 Y98.995 E-.21154
G1 X106.537 Y98.474 E-.20487
; WIPE_END
G1 E-.04 F1800
G1 X100.861 Y103.577 Z5.8 F30000
G1 X99.558 Y104.749 Z5.8
G1 Z5.4
G1 E.8 F1800
G1 F4562
G1 X100.24 Y105.431 E.03202
G1 X100.634 Y105.037 E.01849
G1 X99.616 Y104.765 E.03498
G1 X98.246 Y103.991 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X100.24 Y105.986 E.08666
G1 X101.392 Y104.834 E.05004
G1 X98.304 Y104.007 E.09823
G1 X89.937 Y95.101 F30000
; LINE_WIDTH: 0.48703
G1 F4562
G1 X89.623 Y93.929 E.04391
G1 X89.194 Y94.358 E.02196
G1 X89.894 Y95.059 E.03586
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.37995
G1 F4562
G1 X90.901 Y96.676 E.00095
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.41516
G1 F4562
G1 X90.719 Y96.413 E.00867
G3 X89.835 Y93.136 I643.553 J-175.384 E.10294
G1 X88.613 Y94.358 E.05243
G3 X90.835 Y96.607 I-113.45 J114.336 E.09591
G1 X95.387 Y99.094 F30000
; LINE_WIDTH: 0.35572
G1 F4562
G1 X94.73 Y98.921 E.01733
G1 X95.555 Y99.746 E.02975
G3 X95.399 Y99.153 I4.905 J-1.605 E.01565
G1 X95.715 Y98.784 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X95.383 Y98.739 E.0103
G1 X93.576 Y98.255 E.05749
G1 X96.221 Y100.9 E.11497
G1 X95.739 Y99.099 E.0573
G1 X95.72 Y98.844 E.00786
G1 X96.256 Y98.273 F30000
G1 F4562
G1 X95.863 Y98.425 E.01295
G1 X95.48 Y98.375 E.01184
G1 X92.314 Y97.526 E.10073
G1 X96.95 Y102.162 E.20145
G1 X96.104 Y99.006 E.1004
G1 X96.082 Y98.657 E.01074
G1 X96.231 Y98.328 E.01111
G1 X96.92 Y98.604 F30000
G1 F4562
G1 X100.279 Y95.245 E.14596
G1 X100.461 Y95.196 E.00579
; LINE_WIDTH: 0.436415
G1 X102.783 Y95.802 E.07696
; LINE_WIDTH: 0.469265
G1 X105.106 Y96.407 E.08339
; LINE_WIDTH: 0.49838
G1 X105.165 Y96.427 E.00229
; LINE_WIDTH: 0.52376
G1 X105.223 Y96.446 E.00242
; LINE_WIDTH: 0.517025
G1 X105.236 Y96.507 E.00239
; LINE_WIDTH: 0.478175
G1 X105.249 Y96.567 E.00219
; LINE_WIDTH: 0.429106
G2 X106.278 Y100.481 I238.776 J-60.662 E.12735
G1 X108.158 Y98.601 E.08367
G2 X105.787 Y96.257 I-144.039 J143.353 E.10493
; LINE_WIDTH: 0.47911
G1 X105.648 Y96.148 E.00627
; LINE_WIDTH: 0.516344
G3 X105.403 Y95.892 I.343 J-.576 E.01381
; LINE_WIDTH: 0.469265
G1 X103.718 Y94.184 E.08339
; LINE_WIDTH: 0.422498
G2 X95.998 Y86.44 I-1185.009 J1173.732 E.3382
G1 X94.047 Y88.391 E.08533
G1 X97.956 Y89.438 E.12517
G3 X98.089 Y89.572 I-.049 J.182 E.00611
G1 X99.306 Y94.112 E.14538
G1 X99.257 Y94.294 E.00583
G1 X95.933 Y97.618 E.14538
G3 X95.676 Y97.646 I-.149 J-.168 E.00854
G1 X91.211 Y96.45 E.14297
G3 X91.078 Y96.317 I.049 J-.182 E.00611
G1 X90.03 Y92.408 E.12517
G1 X88.08 Y94.358 E.08533
G1 X90.83 Y97.109 E.12032
G2 X97.522 Y103.773 I829.552 J-826.273 E.29212
; LINE_WIDTH: 0.47911
G1 X97.66 Y103.883 E.00627
; LINE_WIDTH: 0.516344
G3 X97.906 Y104.138 I-.343 J.576 E.01381
; LINE_WIDTH: 0.469265
G1 X98.729 Y104.984 E.04102
; LINE_WIDTH: 0.422975
G2 X100.24 Y106.519 I55.93 J-53.572 E.0667
G1 X102.12 Y104.639 E.08234
G1 X100.492 Y104.203 E.0522
; LINE_WIDTH: 0.436415
G1 X99.347 Y103.913 E.03786
; LINE_WIDTH: 0.469265
G1 X98.203 Y103.623 E.04102
; LINE_WIDTH: 0.49838
G1 X98.144 Y103.604 E.00229
; LINE_WIDTH: 0.52376
G1 X98.086 Y103.584 E.00242
; LINE_WIDTH: 0.517025
G1 X98.072 Y103.524 E.00239
; LINE_WIDTH: 0.478175
G1 X98.059 Y103.463 E.00219
; LINE_WIDTH: 0.43867
G1 X96.836 Y98.822 E.1548
G1 X96.878 Y98.647 E.0058
G1 X99.93 Y94.967 F30000
; LINE_WIDTH: 0.52999
G1 F4562
G1 X100.067 Y94.917 E.00581
; LINE_WIDTH: 0.48599
G1 X100.205 Y94.867 E.00528
; LINE_WIDTH: 0.420322
G1 X100.343 Y94.817 E.0045
G1 X100.558 Y94.832 E.00665
G1 X105.063 Y96.039 E.14342
G1 X101.75 Y92.726 E.14409
; LINE_WIDTH: 0.413018
G1 X98.486 Y89.454 E.1394
G1 X98.291 Y89.236 E.0088
G1 X98.448 Y89.476 E.00862
G1 X99.65 Y93.939 E.1394
G1 X99.688 Y94.198 E.00791
; LINE_WIDTH: 0.44199
G1 X99.649 Y94.335 E.00461
; LINE_WIDTH: 0.48599
G1 X99.609 Y94.471 E.00512
; LINE_WIDTH: 0.551388
G1 X99.57 Y94.607 E.00588
G1 X96.193 Y97.981 E.19777
; LINE_WIDTH: 0.533107
G1 X96.075 Y98.003 E.00482
; LINE_WIDTH: 0.48786
G1 X95.956 Y98.026 E.00438
; LINE_WIDTH: 0.427122
G1 X95.837 Y98.049 E.00378
G1 X95.578 Y98.01 E.00821
; LINE_WIDTH: 0.415115
G1 X91.116 Y96.805 E.14019
G1 X90.945 Y96.716 E.00584
G1 X97.678 Y103.424 E.28825
G1 X96.47 Y98.913 E.14165
G1 X96.456 Y98.703 E.00636
; LINE_WIDTH: 0.442109
G1 X96.494 Y98.578 E.00428
; LINE_WIDTH: 0.486345
G1 X96.533 Y98.452 E.00475
; LINE_WIDTH: 0.551415
G1 X96.571 Y98.326 E.00545
G2 X99.888 Y95.01 I-237.672 J-241.024 E.19435
G1 X99.888 Y94.642 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X100.296 Y94.443 E.01396
G1 X100.656 Y94.468 E.01108
G1 X103.801 Y95.311 E.10005
G1 X99.165 Y90.675 E.20145
G1 X100.034 Y93.917 E.10313
G1 X100.064 Y94.223 E.00947
G1 X99.911 Y94.587 E.01212
G1 X100.423 Y94.076 F30000
G1 F4562
G1 X100.754 Y94.104 E.01018
G1 X102.54 Y94.582 E.05682
G1 X99.894 Y91.936 E.11497
G1 X100.398 Y93.819 E.05989
G1 X100.417 Y94.016 E.00608
G1 X100.731 Y93.73 F30000
; LINE_WIDTH: 0.35572
G1 F4562
G1 X101.385 Y93.916 E.01733
G1 X100.56 Y93.091 E.02975
G1 X100.716 Y93.672 E.01534
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.37995
G1 F4562
G1 X98.247 Y89.196 E.00095
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.414003
G1 F4562
G1 X98.076 Y89.04 E.00595
G3 X95.998 Y86.974 I263.458 J-267.155 E.08861
G1 X94.775 Y88.196 E.05227
G3 X98.051 Y89.083 I-111.944 J419.901 E.10262
G1 X98.168 Y89.144 E.004
G1 X96.741 Y88.297 F30000
; LINE_WIDTH: 0.48703
G1 F4562
G1 X95.998 Y87.554 E.03803
G1 X95.569 Y87.983 E.02196
G1 X96.683 Y88.282 E.04174
; WIPE_START
G1 F8106.101
G1 X95.569 Y87.983 E-.43827
G1 X95.998 Y87.554 E-.23054
G1 X96.167 Y87.724 E-.0912
; WIPE_END
G1 E-.04 F1800
G1 X93.192 Y88.779 Z5.8 F30000
G1 Z5.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F4562
G1 X90.418 Y91.553 E.16974
; WIPE_START
G1 F6780.812
G1 X91.832 Y90.139 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X96.572 Y96.121 Z5.8 F30000
G1 X103.023 Y104.264 Z5.8
G1 Z5.4
G1 E.8 F1800
; LINE_WIDTH: 0.487238
G1 F4562
G1 X105.903 Y101.384 E.14748
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8102.312
G1 X104.489 Y102.798 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 28/30
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z5.8 I1.037 J.637 P1  F30000
G1 X105.45 Y101.235 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X99.903 Y96.751 E.10343
G1 X100.594 Y96.06 E.03242
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.181 Y97.028 E.08885
G1 X100.712 Y96.497 E.02307
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.707 Y95.869 Z6 F30000
G1 X98.384 Y93.76 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.95 Y97.279 Z6 F30000
G1 X108.713 Y98.601 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4562
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X99.616 Y96.463 E.04021
G1 X97.245 Y98.834 E.11122
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X96.462 Y86.351 E.02181
G1 X108.67 Y98.559 E.57269
G1 X109.288 Y98.601 F30000
G1 F4562
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X96.75 Y86.063 E.03531
G1 X109.246 Y98.559 E.58619
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4562
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 28 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer28 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X97.028 Y85.786 E.04476
G1 X109.8 Y98.559 E.55504
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.63 Y96.607 Z6 F30000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F4562
G1 X106.473 Y99.752 E.10007
M73 P97 R0
G1 X107.625 Y98.601 E.05004
G1 X105.673 Y96.649 E.08482
G1 X106.388 Y97.919 F30000
; LINE_WIDTH: 0.45042
G1 F4562
G1 X106.676 Y98.995 E.03697
G1 X107.07 Y98.601 E.01849
G1 X106.431 Y97.962 E.03003
; WIPE_START
G1 F8834.356
G1 X107.07 Y98.601 E-.3436
G1 X106.676 Y98.995 E-.21154
G1 X106.537 Y98.474 E-.20487
; WIPE_END
G1 E-.04 F1800
G1 X100.861 Y103.577 Z6 F30000
G1 X99.558 Y104.749 Z6
G1 Z5.6
G1 E.8 F1800
G1 F4562
G1 X100.24 Y105.431 E.03202
G1 X100.634 Y105.037 E.01849
G1 X99.616 Y104.765 E.03498
G1 X98.246 Y103.991 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X100.24 Y105.986 E.08666
G1 X101.392 Y104.834 E.05004
G1 X98.304 Y104.007 E.09823
G1 X89.937 Y95.101 F30000
; LINE_WIDTH: 0.48703
G1 F4562
G1 X89.623 Y93.929 E.04391
G1 X89.194 Y94.358 E.02196
G1 X89.894 Y95.059 E.03586
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.41516
G1 F4562
G1 X90.719 Y96.413 E.00867
G3 X89.835 Y93.136 I643.553 J-175.384 E.10294
G1 X88.613 Y94.358 E.05243
G3 X90.835 Y96.607 I-113.45 J114.336 E.09591
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.37995
G1 F4562
G1 X90.901 Y96.676 E.00095
G1 X95.387 Y99.094 F30000
; LINE_WIDTH: 0.35573
G1 F4562
G1 X94.73 Y98.921 E.01733
G1 X95.555 Y99.746 E.02975
G3 X95.399 Y99.153 I4.899 J-1.603 E.01565
G1 X95.715 Y98.784 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X95.383 Y98.739 E.0103
G1 X93.576 Y98.255 E.05749
G1 X96.221 Y100.9 E.11497
G1 X95.739 Y99.099 E.0573
G1 X95.72 Y98.844 E.00786
G1 X96.256 Y98.273 F30000
G1 F4562
G1 X95.863 Y98.425 E.01295
G1 X95.48 Y98.375 E.01184
G1 X92.314 Y97.526 E.10073
G1 X96.95 Y102.162 E.20145
G1 X96.104 Y99.006 E.1004
G1 X96.082 Y98.657 E.01074
G1 X96.231 Y98.328 E.01111
G1 X96.606 Y98.291 F30000
; LINE_WIDTH: 0.552
G1 F4562
G1 X99.93 Y94.967 E.19498
; LINE_WIDTH: 0.530007
G1 X100.068 Y94.917 E.00581
; LINE_WIDTH: 0.486
G1 X100.205 Y94.867 E.00528
; LINE_WIDTH: 0.420322
G1 X100.343 Y94.817 E.0045
G1 X100.558 Y94.832 E.00665
G1 X105.063 Y96.039 E.14342
G1 X101.75 Y92.726 E.14409
; LINE_WIDTH: 0.413018
G1 X98.486 Y89.454 E.1394
G1 X98.291 Y89.236 E.0088
G1 X98.448 Y89.476 E.00862
G1 X99.65 Y93.939 E.1394
G1 X99.688 Y94.198 E.00791
; LINE_WIDTH: 0.441994
G1 X99.649 Y94.335 E.00461
; LINE_WIDTH: 0.486
G1 X99.609 Y94.471 E.00512
; LINE_WIDTH: 0.551393
G1 X99.57 Y94.607 E.00588
G1 X96.193 Y97.981 E.19777
; LINE_WIDTH: 0.533115
G1 X96.075 Y98.003 E.00482
; LINE_WIDTH: 0.487865
G1 X95.956 Y98.026 E.00438
; LINE_WIDTH: 0.427123
G1 X95.837 Y98.049 E.00378
G1 X95.578 Y98.01 E.00821
; LINE_WIDTH: 0.415115
G1 X91.116 Y96.805 E.14019
G1 X90.945 Y96.716 E.00584
G1 X97.678 Y103.424 E.28825
G1 X96.47 Y98.913 E.14165
G1 X96.456 Y98.703 E.00636
; LINE_WIDTH: 0.44211
G1 X96.494 Y98.581 E.00417
; LINE_WIDTH: 0.48635
G1 X96.531 Y98.458 E.00463
; LINE_WIDTH: 0.53059
G1 X96.568 Y98.336 E.00509
G1 X96.92 Y98.604 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X100.279 Y95.245 E.14596
G1 X100.461 Y95.196 E.00579
; LINE_WIDTH: 0.436415
G1 X102.783 Y95.802 E.07696
; LINE_WIDTH: 0.469265
G1 X105.106 Y96.407 E.08339
; LINE_WIDTH: 0.49838
G1 X105.165 Y96.427 E.00229
; LINE_WIDTH: 0.52376
G1 X105.223 Y96.446 E.00242
; LINE_WIDTH: 0.517025
G1 X105.236 Y96.507 E.00239
; LINE_WIDTH: 0.478175
G1 X105.249 Y96.567 E.00219
; LINE_WIDTH: 0.429106
G2 X106.278 Y100.481 I238.776 J-60.662 E.12735
G1 X108.158 Y98.601 E.08367
G2 X105.787 Y96.257 I-144.039 J143.353 E.10493
; LINE_WIDTH: 0.47911
G1 X105.648 Y96.148 E.00627
; LINE_WIDTH: 0.516344
G3 X105.403 Y95.892 I.343 J-.576 E.01381
; LINE_WIDTH: 0.469265
G1 X103.718 Y94.184 E.08339
; LINE_WIDTH: 0.422498
G2 X95.998 Y86.44 I-1185.01 J1173.734 E.3382
G1 X94.047 Y88.391 E.08533
G1 X97.956 Y89.438 E.12517
G3 X98.089 Y89.572 I-.049 J.182 E.00611
G1 X99.306 Y94.112 E.14538
G1 X99.257 Y94.294 E.00583
G1 X95.933 Y97.618 E.14538
G3 X95.676 Y97.646 I-.149 J-.168 E.00854
G1 X91.211 Y96.45 E.14297
G3 X91.078 Y96.317 I.049 J-.182 E.00611
G1 X90.03 Y92.408 E.12517
G1 X88.08 Y94.358 E.08533
G1 X90.83 Y97.109 E.12032
G2 X97.522 Y103.773 I828.637 J-825.355 E.29212
; LINE_WIDTH: 0.47911
G1 X97.66 Y103.883 E.00627
; LINE_WIDTH: 0.516344
G3 X97.906 Y104.138 I-.343 J.576 E.01381
; LINE_WIDTH: 0.469265
G1 X98.729 Y104.984 E.04102
; LINE_WIDTH: 0.422975
G2 X100.24 Y106.519 I55.93 J-53.572 E.0667
G1 X102.12 Y104.639 E.08234
G1 X100.492 Y104.203 E.0522
; LINE_WIDTH: 0.436415
G1 X99.347 Y103.913 E.03786
; LINE_WIDTH: 0.469265
G1 X98.203 Y103.623 E.04102
; LINE_WIDTH: 0.49838
G1 X98.144 Y103.604 E.00229
; LINE_WIDTH: 0.52376
G1 X98.086 Y103.584 E.00242
; LINE_WIDTH: 0.517025
G1 X98.072 Y103.524 E.00239
; LINE_WIDTH: 0.478175
G1 X98.059 Y103.463 E.00219
; LINE_WIDTH: 0.43867
G1 X96.836 Y98.822 E.1548
G1 X96.878 Y98.647 E.0058
G1 X99.888 Y94.642 F30000
; LINE_WIDTH: 0.41999
G1 F4562
G1 X100.296 Y94.443 E.01396
G1 X100.656 Y94.468 E.01108
G1 X103.801 Y95.311 E.10005
G1 X99.165 Y90.675 E.20145
G1 X100.034 Y93.917 E.10313
G1 X100.064 Y94.223 E.00947
G1 X99.911 Y94.587 E.01212
G1 X100.423 Y94.076 F30000
G1 F4562
G1 X100.754 Y94.104 E.01018
G1 X102.54 Y94.582 E.05681
G1 X99.894 Y91.936 E.11497
G1 X100.398 Y93.819 E.05989
G1 X100.417 Y94.016 E.00608
G1 X100.731 Y93.73 F30000
; LINE_WIDTH: 0.35573
G1 F4562
G1 X101.385 Y93.916 E.01733
G1 X100.56 Y93.091 E.02975
G1 X100.716 Y93.672 E.01534
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.37995
G1 F4562
G1 X98.247 Y89.196 E.00095
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.414003
G1 F4562
G1 X98.076 Y89.04 E.00595
G3 X95.998 Y86.974 I263.458 J-267.155 E.08861
G1 X94.775 Y88.196 E.05227
G3 X98.051 Y89.083 I-111.944 J419.901 E.10262
G1 X98.168 Y89.144 E.004
G1 X96.741 Y88.297 F30000
; LINE_WIDTH: 0.48703
G1 F4562
G1 X95.998 Y87.554 E.03803
G1 X95.569 Y87.983 E.02196
G1 X96.683 Y88.282 E.04174
; WIPE_START
G1 F8106.101
G1 X95.569 Y87.983 E-.43827
G1 X95.998 Y87.554 E-.23054
G1 X96.167 Y87.724 E-.0912
; WIPE_END
G1 E-.04 F1800
G1 X93.192 Y88.779 Z6 F30000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F4562
G1 X90.418 Y91.553 E.16974
; WIPE_START
G1 F6780.812
G1 X91.832 Y90.139 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X96.572 Y96.121 Z6 F30000
G1 X103.023 Y104.264 Z6
G1 Z5.6
G1 E.8 F1800
; LINE_WIDTH: 0.487238
G1 F4562
G1 X105.903 Y101.384 E.14748
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8102.312
G1 X104.489 Y102.798 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 29/30
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z6 I1.037 J.637 P1  F30000
G1 X105.45 Y101.235 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4545
G1 X102.714 Y103.971 E.12834
G1 X98.759 Y102.911 E.13585
G1 X97.699 Y98.955 E.13585
G1 X100.594 Y96.06 E.13585
G1 X104.55 Y97.119 E.13585
G1 X105.61 Y101.075 E.13585
G1 X105.492 Y101.193 E.00552
M204 S250
G1 X105.173 Y100.958 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4545
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X101.194 Y96.626 E.01533
G1 X104.23 Y97.44 E.09659
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.707 Y95.869 Z6.2 F30000
G1 X98.384 Y93.76 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4545
G1 X98.442 Y93.978 E.00751
G1 X95.617 Y96.803 E.13253
G1 X91.758 Y95.769 E.13253
G1 X90.724 Y91.91 E.13253
G1 X93.549 Y89.085 E.13253
G1 X97.408 Y90.119 E.13253
G1 X98.368 Y93.702 E.12303
M204 S250
G1 X98.005 Y93.861 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4545
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X97.088 Y90.439 E.10885
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.95 Y97.279 Z6.2 F30000
G1 X108.713 Y98.601 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4545
G1 X106.075 Y101.238 E.12372
G1 X104.882 Y96.787 E.15286
G1 X100.473 Y95.606 E.15144
G1 X97.245 Y98.834 E.15144
G1 X98.426 Y103.243 E.15144
G1 X102.877 Y104.436 E.15286
G1 X100.24 Y107.073 E.12372
G1 X87.525 Y94.358 E.59649
G1 X90.233 Y91.65 E.12704
G1 X91.426 Y96.102 E.15286
G1 X95.739 Y97.257 E.14812
G1 X98.896 Y94.1 E.14812
G1 X97.741 Y89.787 E.14812
G1 X93.289 Y88.594 E.15286
G1 X95.998 Y85.886 E.12704
G1 X108.67 Y98.559 E.5945
G1 X109.288 Y98.601 F30000
G1 F4545
G1 X100.24 Y107.649 E.42446
G1 X86.949 Y94.358 E.62349
G1 X95.998 Y85.31 E.42446
G1 X96.279 Y85.592 E.0132
G1 X109.246 Y98.559 E.6083
M204 S250
G1 X109.843 Y98.601 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4545
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 29 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer29 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X96.556 Y85.314 E.02427
G1 X109.8 Y98.559 E.57552
; WIPE_START
G1 F9547.055
M204 S10000
G1 X108.392 Y99.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.903 Y101.384 Z6.2 F30000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.487238
G1 F4545
G1 X103.023 Y104.264 E.14748
; WIPE_START
G1 F8102.312
G1 X104.437 Y102.85 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.246 Y103.991 Z6.2 F30000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F4545
G1 X100.24 Y105.986 E.08666
G1 X101.392 Y104.834 E.05004
G1 X98.304 Y104.007 E.09823
G1 X99.558 Y104.749 F30000
; LINE_WIDTH: 0.45042
G1 F4545
G1 X100.24 Y105.431 E.03202
G1 X100.634 Y105.037 E.01849
G1 X99.616 Y104.765 E.03498
; WIPE_START
G1 F8834.356
G1 X100.634 Y105.037 E-.40028
G1 X100.24 Y105.431 E-.21154
G1 X99.964 Y105.155 E-.14818
; WIPE_END
G1 E-.03999 F1800
G1 X105.032 Y99.447 Z6.2 F30000
G1 X106.388 Y97.919 Z6.2
G1 Z5.8
G1 E.8 F1800
G1 F4545
G1 X106.676 Y98.995 E.03697
G1 X107.07 Y98.601 E.01849
G1 X106.431 Y97.962 E.03003
G1 X105.63 Y96.607 F30000
; LINE_WIDTH: 0.41999
G1 F4545
G1 X106.473 Y99.752 E.10007
G1 X107.625 Y98.601 E.05004
G1 X105.673 Y96.649 E.08482
G1 X96.741 Y88.297 F30000
; LINE_WIDTH: 0.48703
G1 F4545
G1 X95.998 Y87.554 E.03803
G1 X95.569 Y87.983 E.02196
G1 X96.683 Y88.282 E.04174
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.414006
G1 F4545
G1 X98.076 Y89.039 E.00595
G3 X95.998 Y86.974 I263.247 J-266.944 E.08861
G1 X94.775 Y88.196 E.05227
G3 X98.051 Y89.083 I-111.842 J419.525 E.10262
G1 X98.168 Y89.144 E.004
G1 X98.221 Y89.172 F30000
; LINE_WIDTH: 0.37997
G1 F4545
G1 X98.247 Y89.196 E.00095
G1 X100.731 Y93.73 F30000
; LINE_WIDTH: 0.35573
G1 F4545
G1 X101.385 Y93.916 E.01734
G1 X100.56 Y93.091 E.02975
G1 X100.716 Y93.672 E.01534
G1 X100.423 Y94.076 F30000
; LINE_WIDTH: 0.41999
G1 F4545
G1 X100.754 Y94.104 E.01018
G1 X102.54 Y94.582 E.05682
G1 X99.894 Y91.936 E.11497
G1 X100.398 Y93.819 E.05989
G1 X100.417 Y94.016 E.00608
G1 X99.888 Y94.642 F30000
G1 F4545
G1 X100.296 Y94.443 E.01396
G1 X100.656 Y94.468 E.01108
G1 X103.801 Y95.311 E.10006
G1 X99.165 Y90.675 E.20145
G1 X100.034 Y93.917 E.10313
G1 X100.064 Y94.223 E.00947
G1 X99.911 Y94.587 E.01212
G1 X99.93 Y94.967 F30000
; LINE_WIDTH: 0.52999
G1 F4545
G1 X100.067 Y94.917 E.00581
; LINE_WIDTH: 0.48599
G1 X100.205 Y94.867 E.00528
; LINE_WIDTH: 0.420322
G1 X100.343 Y94.817 E.0045
G1 X100.558 Y94.832 E.00665
G1 X105.063 Y96.039 E.14342
G1 X101.75 Y92.726 E.14409
; LINE_WIDTH: 0.413018
G1 X98.486 Y89.454 E.1394
G1 X98.291 Y89.236 E.0088
G1 X98.448 Y89.476 E.00862
G1 X99.65 Y93.939 E.1394
G1 X99.688 Y94.198 E.00791
; LINE_WIDTH: 0.44199
G1 X99.649 Y94.335 E.00461
; LINE_WIDTH: 0.48599
G1 X99.609 Y94.471 E.00512
; LINE_WIDTH: 0.551388
G1 X99.57 Y94.607 E.00588
G1 X96.193 Y97.981 E.19777
; LINE_WIDTH: 0.533107
G1 X96.075 Y98.003 E.00482
; LINE_WIDTH: 0.48786
G1 X95.956 Y98.026 E.00438
; LINE_WIDTH: 0.427122
G1 X95.837 Y98.049 E.00378
G1 X95.578 Y98.01 E.00821
; LINE_WIDTH: 0.415115
G1 X91.116 Y96.805 E.14019
G1 X90.945 Y96.716 E.00584
G1 X97.678 Y103.424 E.28825
G1 X96.47 Y98.913 E.14165
G1 X96.456 Y98.703 E.00636
; LINE_WIDTH: 0.442109
G1 X96.494 Y98.578 E.00428
; LINE_WIDTH: 0.486345
G1 X96.533 Y98.452 E.00475
; LINE_WIDTH: 0.551415
G1 X96.571 Y98.326 E.00545
G2 X99.888 Y95.01 I-237.672 J-241.024 E.19435
G1 X96.92 Y98.604 F30000
; LINE_WIDTH: 0.41999
G1 F4545
G1 X100.279 Y95.245 E.14596
G1 X100.461 Y95.196 E.00579
; LINE_WIDTH: 0.436415
G1 X102.783 Y95.802 E.07696
; LINE_WIDTH: 0.469265
G1 X105.106 Y96.407 E.08339
; LINE_WIDTH: 0.49838
G1 X105.165 Y96.427 E.00229
; LINE_WIDTH: 0.52376
G1 X105.223 Y96.446 E.00242
; LINE_WIDTH: 0.517025
G1 X105.236 Y96.507 E.00239
; LINE_WIDTH: 0.478175
G1 X105.249 Y96.567 E.00219
; LINE_WIDTH: 0.429106
G2 X106.278 Y100.481 I238.776 J-60.662 E.12735
G1 X108.158 Y98.601 E.08367
G2 X105.787 Y96.257 I-144.144 J143.458 E.10493
; LINE_WIDTH: 0.479113
G1 X105.648 Y96.147 E.00627
; LINE_WIDTH: 0.51635
G3 X105.403 Y95.892 I.343 J-.576 E.01381
; LINE_WIDTH: 0.469265
G1 X103.718 Y94.184 E.08339
; LINE_WIDTH: 0.422498
G2 X95.998 Y86.44 I-1185.514 J1174.237 E.3382
G1 X94.047 Y88.391 E.08533
G1 X97.956 Y89.438 E.12517
G3 X98.089 Y89.572 I-.049 J.182 E.00611
G1 X99.306 Y94.112 E.14538
G1 X99.257 Y94.294 E.00583
G1 X95.933 Y97.618 E.14538
G3 X95.676 Y97.646 I-.149 J-.168 E.00854
G1 X91.211 Y96.45 E.14297
G3 X91.078 Y96.317 I.049 J-.182 E.00611
G1 X90.03 Y92.408 E.12517
G1 X88.08 Y94.358 E.08533
G1 X90.83 Y97.109 E.12032
G2 X97.522 Y103.773 I829.552 J-826.273 E.29212
; LINE_WIDTH: 0.47911
G1 X97.66 Y103.883 E.00627
; LINE_WIDTH: 0.516344
G3 X97.906 Y104.138 I-.343 J.576 E.01381
; LINE_WIDTH: 0.469265
G1 X98.729 Y104.984 E.04102
; LINE_WIDTH: 0.422975
G2 X100.24 Y106.519 I55.93 J-53.572 E.0667
G1 X102.12 Y104.639 E.08234
G1 X100.492 Y104.203 E.0522
; LINE_WIDTH: 0.436415
G1 X99.347 Y103.913 E.03786
; LINE_WIDTH: 0.469265
G1 X98.203 Y103.623 E.04102
; LINE_WIDTH: 0.49838
G1 X98.144 Y103.604 E.00229
; LINE_WIDTH: 0.52376
G1 X98.086 Y103.584 E.00242
; LINE_WIDTH: 0.517025
G1 X98.072 Y103.524 E.00239
; LINE_WIDTH: 0.478175
G1 X98.059 Y103.463 E.00219
; LINE_WIDTH: 0.43867
G1 X96.836 Y98.822 E.1548
G1 X96.878 Y98.647 E.0058
G1 X96.256 Y98.273 F30000
; LINE_WIDTH: 0.41999
G1 F4545
G1 X95.863 Y98.425 E.01295
G1 X95.48 Y98.375 E.01184
G1 X92.314 Y97.526 E.10073
G1 X96.95 Y102.162 E.20145
G1 X96.104 Y99.006 E.1004
G1 X96.082 Y98.657 E.01074
G1 X96.231 Y98.328 E.01111
G1 X95.715 Y98.784 F30000
G1 F4545
G1 X95.383 Y98.739 E.0103
G1 X93.576 Y98.255 E.05749
G1 X96.221 Y100.9 E.11497
G1 X95.739 Y99.099 E.0573
G1 X95.72 Y98.844 E.00786
G1 X95.387 Y99.094 F30000
; LINE_WIDTH: 0.35572
G1 F4545
G1 X94.73 Y98.921 E.01733
G1 X95.555 Y99.746 E.02975
G3 X95.399 Y99.153 I4.905 J-1.605 E.01565
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.41516
G1 F4545
G1 X90.719 Y96.413 E.00867
G3 X89.835 Y93.136 I643.553 J-175.384 E.10294
G1 X88.613 Y94.358 E.05243
G3 X90.835 Y96.607 I-113.45 J114.336 E.09591
G1 X90.875 Y96.652 F30000
; LINE_WIDTH: 0.37995
G1 F4545
G1 X90.901 Y96.676 E.00095
G1 X89.937 Y95.101 F30000
; LINE_WIDTH: 0.48703
G1 F4545
G1 X89.623 Y93.929 E.04391
G1 X89.194 Y94.358 E.02196
M73 P98 R0
G1 X89.894 Y95.059 E.03586
; WIPE_START
G1 F8106.101
G1 X89.194 Y94.358 E-.3765
G1 X89.623 Y93.929 E-.23054
G1 X89.727 Y94.318 E-.15297
; WIPE_END
G1 E-.04 F1800
G1 X90.418 Y91.553 Z6.2 F30000
G1 Z5.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57383
G1 F4545
G1 X93.192 Y88.779 E.16974
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6780.812
G1 X91.778 Y90.193 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 258
M625
; layer num/total_layer_count: 30/30
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 258
; start printing object, unique label id: 258
M624 gAAAAAAAAAA=
G17
G3 Z6.2 I-.762 J.949 P1  F30000
G1 X105.173 Y100.958 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5374
M204 S5000
G1 X102.597 Y103.534 E.11192
G1 X99.079 Y102.591 E.11192
G1 X98.136 Y99.072 E.11192
G1 X100.712 Y96.497 E.11192
G1 X104.23 Y97.44 E.11192
G1 X105.157 Y100.9 E.11008
; WIPE_START
G1 F9547.055
M204 S10000
G1 X103.763 Y102.334 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.473 Y96.021 Z6.4 F30000
G1 X98.005 Y93.861 Z6.4
G1 Z6
G1 E.8 F1800
G1 F5374
M204 S5000
G1 X95.5 Y96.366 E.10885
G1 X92.078 Y95.449 E.10885
G1 X91.162 Y92.027 E.10885
G1 X93.666 Y89.522 E.10885
G1 X93.902 Y89.585 E.00748
G1 X97.088 Y90.439 E.10137
G1 X97.99 Y93.803 E.10701
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.596 Y95.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.994 Y97.116 Z6.4 F30000
G1 X109.843 Y98.601 Z6.4
G1 Z6
G1 E.8 F1800
G1 F5374
M204 S5000
G1 X100.24 Y108.204 E.41728
; object ids of layer 30 start: 258
M624 gAAAAAAAAAA=
;========Date 20250206========
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END
; object ids of this layer30 end: 258
M625
G1 X86.395 Y94.358 E.60164
G1 X95.998 Y84.756 E.41728
G1 X96.085 Y84.843 E.00379
G1 X109.8 Y98.559 E.59601
M204 S10000
G1 X109.306 Y98.357 F30000
; FEATURE: Top surface
G1 F5374
M204 S2000
G1 X99.997 Y107.667 E.40453
G1 X99.73 Y107.4
G1 X109.039 Y98.091 E.40453
G1 X108.773 Y97.824
G1 X99.463 Y107.133 E.40453
G1 X99.197 Y106.867
G1 X102.375 Y103.689 E.1381
G1 X101.954 Y103.576
G1 X98.93 Y106.6 E.13141
G1 X98.663 Y106.334
G1 X101.534 Y103.463 E.12472
G1 X101.113 Y103.351
G1 X98.397 Y106.067 E.11804
G1 X98.13 Y105.8
G1 X100.693 Y103.238 E.11135
G1 X100.272 Y103.125
G1 X97.864 Y105.534 E.10466
G1 X97.597 Y105.267
G1 X99.851 Y103.013 E.09797
G1 X99.431 Y102.9
G1 X97.33 Y105 E.09128
G1 X97.064 Y104.734
G1 X99.01 Y102.787 E.08459
G1 X98.824 Y102.44
G1 X96.797 Y104.467 E.08807
G1 X96.53 Y104.2
G1 X98.711 Y102.02 E.09476
G1 X98.598 Y101.599
G1 X96.264 Y103.934 E.10145
G1 X95.997 Y103.667
G1 X98.486 Y101.179 E.10814
G1 X98.373 Y100.758
G1 X95.731 Y103.401 E.11483
G1 X95.464 Y103.134
G1 X98.26 Y100.338 E.12152
G1 X98.148 Y99.917
G1 X95.197 Y102.867 E.12821
G1 X94.931 Y102.601
G1 X98.035 Y99.496 E.1349
G1 X97.922 Y99.076
G1 X94.664 Y102.334 E.14159
; WIPE_START
G1 F9547.055
M204 S10000
G1 X96.078 Y100.92 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.446 Y98.927 Z6.4 F30000
G1 X108.506 Y97.558 Z6.4
G1 Z6
G1 E.8 F1800
G1 F5374
M204 S2000
G1 X105.328 Y100.736 E.1381
G1 X105.215 Y100.315
G1 X108.239 Y97.291 E.13141
G1 X107.973 Y97.024
G1 X105.102 Y99.894 E.12472
G1 X104.99 Y99.474
G1 X107.706 Y96.758 E.11804
G1 X107.439 Y96.491
G1 X104.877 Y99.053 E.11135
G1 X104.764 Y98.633
G1 X107.173 Y96.224 E.10466
G1 X106.906 Y95.958
G1 X104.652 Y98.212 E.09797
G1 X104.539 Y97.792
G1 X106.64 Y95.691 E.09128
G1 X106.373 Y95.425
G1 X104.426 Y97.371 E.08459
G1 X104.08 Y97.185
G1 X106.106 Y95.158 E.08807
G1 X105.84 Y94.891
G1 X103.659 Y97.072 E.09476
G1 X103.238 Y96.959
G1 X105.573 Y94.625 E.10145
G1 X105.306 Y94.358
G1 X102.818 Y96.847 E.10814
G1 X102.397 Y96.734
G1 X105.04 Y94.091 E.11483
G1 X104.773 Y93.825
G1 X101.977 Y96.621 E.12152
G1 X101.556 Y96.508
G1 X104.507 Y93.558 E.12821
G1 X104.24 Y93.291
G1 X101.136 Y96.396 E.1349
G1 X100.715 Y96.283
G1 X103.973 Y93.025 E.14158
G1 X103.707 Y92.758
G1 X94.397 Y102.067 E.40453
G1 X94.131 Y101.801
G1 X103.44 Y92.492 E.40453
G1 X103.173 Y92.225
G1 X93.864 Y101.534 E.40453
G1 X93.597 Y101.268
G1 X102.907 Y91.958 E.40453
G1 X102.64 Y91.692
G1 X93.331 Y101.001 E.40453
G1 X93.064 Y100.734
G1 X102.373 Y91.425 E.40453
G1 X102.107 Y91.158
G1 X92.798 Y100.468 E.40453
G1 X92.531 Y100.201
G1 X101.84 Y90.892 E.40453
G1 X101.574 Y90.625
G1 X92.264 Y99.934 E.40453
G1 X91.998 Y99.668
G1 X95.173 Y96.493 E.13797
G1 X94.752 Y96.38
G1 X91.731 Y99.401 E.13128
G1 X91.464 Y99.135
G1 X94.332 Y96.267 E.12459
G1 X93.911 Y96.155
G1 X91.198 Y98.868 E.1179
G1 X90.931 Y98.601
G1 X93.49 Y96.042 E.11121
G1 X93.07 Y95.929
G1 X90.665 Y98.335 E.10452
G1 X90.398 Y98.068
G1 X92.649 Y95.817 E.09783
G1 X92.229 Y95.704
G1 X90.131 Y97.801 E.09114
G1 X89.865 Y97.535
G1 X91.882 Y95.517 E.08766
G1 X91.769 Y95.097
G1 X89.598 Y97.268 E.09435
G1 X89.331 Y97.002
G1 X91.657 Y94.676 E.10104
G1 X91.544 Y94.256
G1 X89.065 Y96.735 E.10773
G1 X88.798 Y96.468
G1 X91.431 Y93.835 E.11442
G1 X91.319 Y93.415
G1 X88.532 Y96.202 E.12111
G1 X88.265 Y95.935
G1 X91.206 Y92.994 E.1278
G1 X91.093 Y92.573
G1 X87.998 Y95.668 E.13449
G1 X87.732 Y95.402
G1 X90.98 Y92.153 E.14118
; WIPE_START
G1 F9547.055
M204 S10000
G1 X89.566 Y93.567 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.199 Y93.537 Z6.4 F30000
G1 X98.132 Y93.534 Z6.4
G1 Z6
G1 E.8 F1800
G1 F5374
M204 S2000
G1 X101.307 Y90.359 E.13797
G1 X101.04 Y90.092
G1 X98.019 Y93.113 E.13128
G1 X97.907 Y92.692
G1 X100.774 Y89.825 E.12459
G1 X100.507 Y89.559
G1 X97.794 Y92.272 E.1179
G1 X97.681 Y91.851
G1 X100.24 Y89.292 E.11121
G1 X99.974 Y89.025
G1 X97.569 Y91.431 E.10452
G1 X97.456 Y91.01
G1 X99.707 Y88.759 E.09783
G1 X99.441 Y88.492
G1 X97.343 Y90.59 E.09114
G1 X97.157 Y90.243
G1 X99.174 Y88.226 E.08766
G1 X98.907 Y87.959
G1 X96.736 Y90.13 E.09435
G1 X96.315 Y90.017
G1 X98.641 Y87.692 E.10104
G1 X98.374 Y87.426
G1 X95.895 Y89.905 E.10773
G1 X95.474 Y89.792
G1 X98.107 Y87.159 E.11442
G1 X97.841 Y86.892
G1 X95.054 Y89.679 E.12111
G1 X94.633 Y89.567
G1 X97.574 Y86.626 E.1278
G1 X97.308 Y86.359
G1 X94.213 Y89.454 E.13449
G1 X93.792 Y89.341
G1 X97.041 Y86.093 E.14118
G1 X96.774 Y85.826
G1 X87.465 Y95.135 E.40453
G1 X87.198 Y94.868
G1 X96.508 Y85.559 E.40453
G1 X96.241 Y85.293
G1 X86.932 Y94.602 E.40453
; WIPE_START
G1 F9547.055
M204 S10000
G1 X88.346 Y93.188 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.746 Y95.058 Z6.4 F30000
G1 X109.514 Y98.539 Z6.4
G1 Z6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.217583
G1 F5374
G1 X100.178 Y107.875 E.18791
; WIPE_START
G1 F15000
G1 X101.593 Y106.461 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.915 Y98.859 Z6.4 F30000
G1 X100.686 Y96.277 Z6.4
G1 Z6
G1 E.8 F1800
; LINE_WIDTH: 0.102385
G1 F5374
G2 X100.624 Y96.255 I-.067 J.088 E.00032
; LINE_WIDTH: 0.147182
G1 X100.603 Y96.255 E.00018
; LINE_WIDTH: 0.191501
G1 X100.582 Y96.255 E.00025
G1 X97.894 Y98.943 E.04602
; LINE_WIDTH: 0.17678
G1 X97.894 Y98.964 E.00023
; LINE_WIDTH: 0.147176
G1 X97.894 Y98.985 E.00018
; LINE_WIDTH: 0.102386
G2 X97.916 Y99.046 I.111 J-.005 E.00032
; WIPE_START
G1 F15000
G1 X97.894 Y98.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X92.826 Y95.907 Z6.4 F30000
G1 Z6
G1 E.8 F1800
; LINE_WIDTH: 0.089202
G1 F5374
G1 X92.679 Y95.822 E.00064
; WIPE_START
G1 F15000
G1 X92.826 Y95.907 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X95.011 Y88.594 Z6.4 F30000
G1 X96.059 Y85.084 Z6.4
G1 Z6
G1 E.8 F1800
; LINE_WIDTH: 0.217491
G1 F5374
G1 X86.723 Y94.42 E.18782
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F15000
G1 X88.138 Y93.006 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z6.4 I1.217 J0 P1  F30000
; stop printing object, unique label id: 258
M625
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z6.5 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
M73 P99 R0
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z106 F600
    G1 Z104

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

