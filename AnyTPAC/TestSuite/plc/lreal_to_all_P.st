(*[[
]]*)
PROGRAM lreal_to_all_P 
#import "Crosstable.gvl"
#import "Resource1.gvl"
CONST
	this : int := 6;
	test_cases : int := 5;
END_CONST
VAR
	test_case : array [1..test_cases] of lreal_all_T := [
		(input := 0.0, ret_bool := 0, ret_byte := 0, ret_dword := 0, ret_int := 0, ret_dint := 0, ret_real := 0.0, 
		   ret_string := '0', ret_time := t#0ms, ret_udint := 0, ret_uint := 0, ret_word := 0),
		(input := 1.0, ret_bool := 1, ret_byte := 1, ret_dword := 1, ret_int := 1, ret_dint := 1, ret_real := 1.0, 
		   ret_string := '1', ret_time := t#1ms, ret_udint := 1, ret_uint := 1, ret_word := 1),
		(input := -1.0, ret_bool := 1, ret_byte := 0, ret_dword := 0, ret_int := -1, ret_dint := -1, ret_real := -1.0, 
		   ret_string := '-1', ret_time := t#-1ms, ret_udint := 0, ret_uint := 0, ret_word := 0),
		(input := 255.0, ret_bool := 1, ret_byte := 255, ret_dword := 255, ret_int := 255, ret_dint := 255, ret_real := 255.0, 
		   ret_string := '255', ret_time := t#255ms, ret_udint := 255, ret_uint := 255, ret_word := 255),
		(input := 400.0, ret_bool := 1, ret_byte := 255, ret_dword := 400, ret_int := 400, ret_dint := 400, ret_real := 400.0, 
		   ret_string := '400', ret_time := t#400ms, ret_udint := 400, ret_uint := 400, ret_word := 400)
	];
    ret_bool   : bool;
    ret_byte   : byte;
    ret_dword  : dword;
    ret_int    : int;
    ret_dint   : dint;
    ret_real   : real;
    ret_time   : time;
    ret_string : string;
    ret_udint  : udint;
    ret_uint   : uint;
    ret_word   : word;

	index : int := 1;
	expected : string;
	obtained : string;
	result : bool;
END_VAR

	if Status = STATUS_RUNNING AND test_level_06 > TEST_DISABLED and test_loops_06 < Target then

		(* ---------- test action ---------------*)
        ret_bool   := lreal_to_bool(test_case[index].input);
        ret_byte   := lreal_to_byte(test_case[index].input);
        ret_dword  := lreal_to_dword(test_case[index].input);
        ret_int    := lreal_to_int(test_case[index].input);
        ret_dint   := lreal_to_dint(test_case[index].input);
        ret_real   := lreal_to_real(test_case[index].input);
        ret_string := lreal_to_string(test_case[index].input);
        ret_time   := lreal_to_time(test_case[index].input);
        ret_udint  := lreal_to_udint(test_case[index].input);
        ret_uint   := lreal_to_uint(test_case[index].input);
        ret_word   := lreal_to_word(test_case[index].input);
    
		(* ---------- test condition ---------------*)
        result := (ret_bool = test_case[index].ret_bool)
		      and (ret_byte = test_case[index].ret_byte)
		      and (ret_dword = test_case[index].ret_dword)
		      and (ret_int = test_case[index].ret_int)
		      and (ret_dint = test_case[index].ret_dint)
		      and (ret_real = test_case[index].ret_real)
		      and (ret_string = test_case[index].ret_string)
		      and (ret_time = test_case[index].ret_time)
		      and (ret_udint = test_case[index].ret_udint)
		      and (ret_uint = test_case[index].ret_uint)
		      and (ret_word = test_case[index].ret_word);

		(* ---------- log message ---------------*)
		expected := '';
		expected := CONCAT(expected, comma_blank, bool_to_string(test_case[index].ret_bool));
		expected := CONCAT(expected, comma_blank, byte_to_string(test_case[index].ret_byte));
		expected := CONCAT(expected, comma_blank, dword_to_string(test_case[index].ret_dword));
		expected := CONCAT(expected, comma_blank, int_to_string(test_case[index].ret_int));
		expected := CONCAT(expected, comma_blank, dint_to_string(test_case[index].ret_dint));
		expected := CONCAT(expected, comma_blank, real_to_string(test_case[index].ret_real));
		expected := CONCAT(expected, comma_blank, test_case[index].ret_string);
		expected := CONCAT(expected, comma_blank, udint_to_string(test_case[index].ret_udint));
		expected := CONCAT(expected, comma_blank, time_to_string(test_case[index].ret_time));
		expected := CONCAT(expected, comma_blank, uint_to_string(test_case[index].ret_uint));
		expected := CONCAT(expected, comma_blank, word_to_string(test_case[index].ret_word));
		obtained := '';
		obtained := CONCAT(obtained, comma_blank, bool_to_string(ret_bool));
		obtained := CONCAT(obtained, comma_blank, byte_to_string(ret_byte));
		obtained := CONCAT(obtained, comma_blank, dword_to_string(ret_dword));
		obtained := CONCAT(obtained, comma_blank, int_to_string(ret_int));
		obtained := CONCAT(obtained, comma_blank, dint_to_string(ret_dint));
		obtained := CONCAT(obtained, comma_blank, real_to_string(ret_real));
		obtained := CONCAT(obtained, comma_blank, ret_string);
		obtained := CONCAT(obtained, comma_blank, time_to_string(ret_time));
		obtained := CONCAT(obtained, comma_blank, udint_to_string(ret_udint));
		obtained := CONCAT(obtained, comma_blank, uint_to_string(ret_uint));
		obtained := CONCAT(obtained, comma_blank, word_to_string(ret_word));

		(* ---------- cycle ----------*)
		SingleTest(this, result, expected, obtained, test_cases,
				   index, test_level_06, test_counter_06, test_loops_06, test_errors_06);
	end_if;

END_PROGRAM
