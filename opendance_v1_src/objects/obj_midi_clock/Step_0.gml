
time = (get_timer() - start_time);

div_4_previous = div_4;
div_8_previous = div_8;
div_16_previous = div_16;
div_32_previous = div_32;


div_4 = (floor(time/(micros_per_sec/bpm)) mod 4) + 1 ;
div_8 = (floor(time/(micros_per_sec/2/bpm))mod 8) + 1;
div_16 = (floor(time/(micros_per_sec/4/bpm))mod 16) + 1;
div_32 = (floor(time/(micros_per_sec/8/bpm))mod 32) + 1;


if div_4_previous != div_4 {
quarter_count += 1;
div_4_trigger = true;
}
else div_4_trigger = false;

if quarter_count = 5{
measure +=1;
quarter_count = 1;
}

if div_8_previous != div_8 div_8_trigger = true;
else div_8_trigger = false;
if div_16_previous != div_16 div_16_trigger = true;
else div_16_trigger = false;
if div_32_previous != div_32 div_32_trigger = true;
else div_32_trigger = false;













