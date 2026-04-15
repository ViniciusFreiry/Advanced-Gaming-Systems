global.wave_frequency = 0.25;
global.shake_force = 3;
global.wheel_speed = 3;
global.pulse_speed = 2;
global.rainbow_speed = 0.2;

function set_draw_rich_text(_wave_frequency = 0.25, _shake_force = 3, _wheel_speed = 3, _pulse_speed = 2, _rainbow_speed = 0.2) {
	global.wave_frequency = _wave_frequency;
	global.shake_force = _shake_force;
	global.wheel_speed = _wheel_speed;
	global.pulse_speed = _pulse_speed;
	global.rainbow_speed = _rainbow_speed;
}

function draw_rich_text(_x, _y, _text, _sep, _w, _xscale = 1, _yscale = 1, _visible = -1) {
    var _halign = draw_get_halign();
    var _valign = draw_get_valign();
    
    var _line_height = string_height("A") * _yscale;
    var _time = current_time * 0.005;
    
	static get_char_advance = function(_char, _scale) {
	    var _width = string_width(_char);
    
	    switch (_char) {
	        case "I":
	        case "l":
	        case "i":
	        case "!":
	        case "|":
	            _width += 0.5 / _scale;
	        break;
        
	        case "W":
	        case "M":
	            _width -= 0.5 / _scale;
	        break;
        
	        case " ":
	            _width += 2 / _scale;
	        break;
	    }
    
	    return _width * _scale;
	}
	
    static make_color_hex = function(_hex_string) {
        if (string_char_at(_hex_string, 1) == "#") {
            _hex_string = string_delete(_hex_string, 1, 1);
        }
    
        if (string_length(_hex_string) != 6) return c_white;
    
        var _r = real("0x" + string_copy(_hex_string, 1, 2)),
		_g = real("0x" + string_copy(_hex_string, 3, 2)),
		_b = real("0x" + string_copy(_hex_string, 5, 2));
    
        return make_color_rgb(_r, _g, _b);
    }
    
    // Active Tags Controll
    var _active_tags = [];
    
    static push_tag = function(_tag_to_push, _array) {
        array_push(_array, _tag_to_push);
    }
    
    static remove_tag = function(_tag_to_remove, _array) {
        for (var _t = array_length(_array)-1; _t >= 0; _t--) {
            if (_array[_t] == _tag_to_remove) {
                array_delete(_array, _t, 1);
                break;
            }
        }
    }
    
    static build_active_string = function(_array) {
        var _s = "";
        for (var _t = 0; _t < array_length(_array); _t++) {
            _s += "{" + _array[_t] + "}";
        }
        return _s;
    }
	
	static trim_end_space = function(_str) {
	    while (string_length(_str) > 0 && string_char_at(_str, string_length(_str)) == " ") {
	        _str = string_delete(_str, string_length(_str), 1);
	    }
	    return _str;
	}
    
    // Step 1: Break text into _lines
    var _lines = [];
    var _line = "";
    var _line_width = 0;
    
    var i = 1;
	
    while (i <= string_length(_text)) {
        var c = string_char_at(_text, i);
        
        if (c == "\n") {
            array_push(_lines, _line);
            _line = build_active_string(_active_tags);
            _line_width = 0;
            i++;
            continue;
        }
        
        // Tag
        if (c == "{") {
            var tag = "";
            i++;
            
            while (i <= string_length(_text) && string_char_at(_text, i) != "}") {
                tag += string_char_at(_text, i);
                i++;
            }
            
            // State Controll
            if (string_char_at(tag,1) == "/") {
                remove_tag(string_delete(tag,1,1), _active_tags);
            } else {
                push_tag(tag, _active_tags);
            }
            
            _line += "{" + tag + "}";
            i++;
            continue;
        }
        
        // Word Wrap
        if (_w > 0 && c != " ") {
            
            var look_i = i;
            var word_w = 0;
            
            while (look_i <= string_length(_text)) {
                var lc = string_char_at(_text, look_i);
                
                if (lc == " " || lc == "\n") break;
                
                if (lc == "{") {
                    look_i++;
                    while (look_i <= string_length(_text) && string_char_at(_text, look_i) != "}") {
                        look_i++;
                    }
                    look_i++;
                    continue;
                }
                
                word_w += get_char_advance(lc, _xscale);
                look_i++;
            }
            
            if (_line_width > 0 && _line_width + word_w > _w) {
			    _line = trim_end_space(_line);
    
			    array_push(_lines, _line);
				
			    _line = build_active_string(_active_tags);
			    _line_width = 0;

			    while (i <= string_length(_text) && string_char_at(_text, i) == " ") {
			        i++;
			    }
    
			    continue;
			}
        }
        
        if (!(c == " " && _line == "")) {
            _line += c;
            _line_width += get_char_advance(c, _xscale);
        }
        
        i++;
    }
    
    if (_line != "") array_push(_lines, _line);
    
    // Vertical Alignment
    var total_h = (array_length(_lines) -  1) * (_line_height + _sep) - _sep;
    var start_y = _y;
	
    if (_valign == fa_middle) start_y -= total_h * 0.5;
    if (_valign == fa_bottom) start_y -= total_h;
    
    // PASSO 2: Draw
    var visible_count = 0;
    
    for (var li = 0; li < array_length(_lines); li++) {
        
        var text_line = _lines[li];
        
        var clean_w = 0;
        var skip = false;
        
        for (var j = 1; j <= string_length(text_line); j++) {
            var ch = string_char_at(text_line, j);
            
            if (ch == "{") { skip = true; continue; }
            if (ch == "}") { skip = false; continue; }
            if (!skip) clean_w += get_char_advance(ch, _xscale);
        }
        
        var start_x = _x;
        
        if (_halign == fa_center) {
			start_x -= clean_w * 0.5;
			draw_set_halign(-1);
		}
		
        if (_halign == fa_right) start_x -= clean_w;
        
        var pos_x = start_x;
        var pos_y = start_y + li * (_line_height + _sep);
        
        var current_color = c_white;
        
        var fx_shake = false;
        var fx_wave = false;
        var fx_outline = false;
        var fx_italic = false;
        var fx_rainbow = false;
        var fx_wheel = false;
		var fx_pulse = false;
        
        var k = 1;
        
        while (k <= string_length(text_line)) {
            var ch = string_char_at(text_line, k);
            
            if (ch == "{") {
                var tag = "";
                k++;
                
                while (k <= string_length(text_line) && string_char_at(text_line, k) != "}") {
                    tag += string_char_at(text_line, k);
                    k++;
                }
                
                if (string_length(tag) == 7 && string_char_at(tag,1) == "#") {
                    current_color = make_color_hex(tag);
                } else {
					if(string_copy(tag, 0, 2) == "/#") current_color = c_white;
					
                    switch(tag) {
                        case "shake": fx_shake = true; break;
                        case "/shake": fx_shake = false; break;
                        
                        case "wave": fx_wave = true; break;
                        case "/wave": fx_wave = false; break;
                        
                        case "outline": fx_outline = true; break;
                        case "/outline": fx_outline = false; break;
                        
                        case "italic": fx_italic = true; break;
                        case "/italic": fx_italic = false; break;
                        
                        case "rainbow": fx_rainbow = true; break;
                        case "/rainbow": fx_rainbow = false; break;
                        
                        case "wheel": fx_wheel = true; break;
                        case "/wheel": fx_wheel = false; break;
						
						case "pulse": fx_pulse = true; break;
						case "/pulse": fx_pulse = false; break;
                    }
                }
                
                k++;
                continue;
            }
            
            if (_visible != -1 && visible_count >= _visible) return;
            
            var draw_x = pos_x;
            var draw_y = pos_y;
            
            if (fx_shake) {
                draw_x += random_range(-global.shake_force, global.shake_force) * _xscale;
                draw_y += random_range(-global.shake_force, global.shake_force) * _yscale;
            }
            
            if (fx_wave) {
                draw_y += sin(_time + pos_x * global.wave_frequency) * (5 * _yscale);
            }
            
            var final_color = current_color;
            
            if (fx_rainbow) {
                var hue = frac((_time * global.rainbow_speed) + (pos_x * 0.01));
                final_color = make_color_hsv(hue * 255, 255, 255);
            }
            
            var rot = fx_italic ? -7 : 0;
            
            if (fx_wheel) {
                var radius_x = 6 * _xscale;
                var radius_y = 6 * _yscale;
                var angle = (_time * global.wheel_speed) + (pos_x * 0.05) + (pos_y * 0.05);
                draw_x += cos(angle) * radius_x;
                draw_y += sin(angle) * radius_y;
            }
			
			var final_xscale = _xscale;
			var final_yscale = _yscale;

			if (fx_pulse) {
			    var pulse = 1 + sin(_time * global.pulse_speed + pos_x * 0.05) * 0.15;
			    final_xscale *= pulse;
			    final_yscale *= pulse;
			}
            
            if (fx_outline) {
                draw_set_color(c_white);
                
                for (var ox = -1; ox <= 1; ox += 2) {
                    for (var oy = -1; oy <= 1; oy += 2) {
                        draw_text_transformed(draw_x + ox, draw_y + oy, ch, final_xscale, final_yscale, rot);
                    }
                }
            }
            
            draw_set_color(final_color);
            draw_text_transformed(draw_x, draw_y, ch, final_xscale, final_yscale, rot);
            
            pos_x += get_char_advance(ch, _xscale);
            visible_count++;
            k++;
        }
    }
	
	if(_halign == fa_center) draw_set_halign(fa_center);
}