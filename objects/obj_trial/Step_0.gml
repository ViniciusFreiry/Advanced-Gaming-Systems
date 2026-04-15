if (variable_global_exists("hitstop") and global.hitstop) exit;

image_alpha -= 0.1;

image_xscale = lerp(image_xscale, 0, 0.1);
image_yscale = lerp(image_yscale, 0, 0.1);

if (image_alpha <= 0) instance_destroy();