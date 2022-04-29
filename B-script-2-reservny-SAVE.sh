#! /bin/bash -x

# =============================================================================================
# =============================================================================================
# script parameters:
# =============================================================================================

   # DECLARE seychas ne nuzhno, no pustj ostanutsya na potom,  esli vynesu parametry v otdelnyy fail


declare  input_DSU_limit_MB              # disk space usage limit in megabytes - to be occupied by all of the saved archives
                                         # (archives are saved in 'EpamBackup/B-Archives/')
                                         # (if the limit is reached, only a message is generated, but no deletion is performed)
                                         # (0 means "no limit")

                                   # below, the arrays are used to save parameters for (currently) three archives to be created:

declare -a input_consider_flag                   # - shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
declare -a input_name                            # - name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
declare -a input_amount_of_old                   # - amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
declare -a input_dirs_and_files_plus_1           # - directories and separate file names (or masks) TO BE included in the archive
declare -a input_dirs_and_files_plus_2           #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
declare -a input_dirs_and_files_plus_3           #   print nothing after = if there is no need for another mask
declare -a input_dirs_and_files_plus_4           #   but do not delete lines
declare -a input_dirs_and_files_plus_5           #   also do not duplicate lines, the max number of masks is 5.

declare -a input_dirs_and_files_minus_1          # - directories and separate file names (or masks) TO BE included in the archive
declare -a input_dirs_and_files_minus_2          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
declare -a input_dirs_and_files_minus_3          #   print nothing after = if there is no need for another mask
declare -a input_dirs_and_files_minus_4          #   but do not delete lines
declare -a input_dirs_and_files_minus_5          #   also do not duplicate lines, the max number of masks is 5.

declare -a input_compress                        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
declare -a input_verify                          # - verify the archive as does "tar --verify" ('on') or not ('off')







# =============================================================================================
# overall parameters:
input_DSU_limit_MB=500              # disk space usage limit in megabytes - to be occupied by all of the saved archives
                                    # (archives are saved in 'EpamBackup/B-Archives/')
                                    # (if the limit is reached, only a message is generated, but no deletion is performed)
                                    # (0 means "no limit")
# =============================================================================================

# The first set of parameters:
ord=1      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='d-s'           # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=~/*            # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=                #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=~/D*          # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_minus_2[ord]=*.mp3          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='bzip2'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='on'           # - verify the archive as does "tar --verify" ('on') or not ('off')



# The second set of parameters: ==================================================================================
ord=2      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='spec'           # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=~/*         # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=~/dir_for_backup    #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=*.txt          # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_minus_2[ord]=*.bmp          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='none'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='off'           # - verify the archive as does "tar --verify" ('on') or not ('off')



# The third set of parameters: ==================================================================================
ord=3      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='misc'          # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=/home/mysshfriend/*     # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=~/Music         #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=/etc                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=               # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_minus_2[ord]=               #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='bzip2'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='off'           # - verify the archive as does "tar --verify" ('on') or not ('off')



# =============================================================================================
# =============================================================================================

# in the very beginning we should change current directory to the directory ewhere script is located

script_dir="$(dirname "$(realpath "$0")")"    # I am not sure if the quotes are correct, but this works
echo script_dir:    ${script_dir}           # ATTENTION:  if script itself was called without full path
                                         #(e.g. "bash B-script-2.sh" )  and "cd" was called upper in the script
                                         # - then realpath "$0" IN FACT gives current dir - NOT the dir the script is located in
				 	# -- hence, if I call "cd" to be sure for paths, I should do it carefully

cd ${script_dir}   # this is done for correct expansion of paths by different commands

check_script_dir="$(dirname "$(realpath "$0")")"     # sama proverka - nizhe (see script_dir_test)
echo check_script_dir:    ${check_script_dir}

# =============================================================================================
# the primary  processing of user-defined settings:

param_sets_quantity=3        # (needs control) - quantity of sets of parameters
plus_quantity=5           # FOR INFO ONLY (needs control) - quantity of masks of dirs and files to be included in the archive
minus_quantity=5          # FOR INFO ONLY (needs control) - quantity of masks of dirs and files NOT to be included in the archive


declare -a plus_masks
declare -a minus_masks
declare -a minus_masks_exist

echo
echo "==========================================================================="
echo
echo "Local and universal time (year-month-day--hours-mins-secs): "
current_date=$(date +%Z%Y-%m-%d--%H-%M-%S)--$(date -u +%Z%Y-%m-%d--%H-%M-%S)
echo $current_date
echo "==========================================================================="
echo "Parameters:"
echo
# ostavitj kak primer skobok v if:    if (( ${input_DSU_limit_MB} == 0 )) && [[ ${input_consider_flag[$i]} == 'on' ]]; then
if [[ ${input_DSU_limit_MB} == 0 ]]; then
	echo "- no   input_DSU_limit_MB    is set (0 means 'no limit')";
else
	echo "- input_DSU_limit_MB:"   ${input_DSU_limit_MB}
fi

for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	echo "parameters set N:"   $i
	echo "- input_consider_flag:"   ${input_consider_flag[$i]}
	echo "- input_name:"   ${input_name[$i]}
	echo "- input_amount_of_old:"   ${input_amount_of_old[$i]}

	plus_masks[$i]=${input_dirs_and_files_plus_1[$i]}
	plus_masks[$i]+=" ${input_dirs_and_files_plus_2[$i]}"
	plus_masks[$i]+=" ${input_dirs_and_files_plus_3[$i]}"
	plus_masks[$i]+=" ${input_dirs_and_files_plus_4[$i]}"
	plus_masks[$i]+=" ${input_dirs_and_files_plus_5[$i]}"
	echo "- plus_masks:"   ${plus_masks[$i]}

	minus_masks_exist[$i]=0
	minus_masks[$i]=${input_dirs_and_files_minus_1[$i]}
	minus_masks[$i]+=" ${input_dirs_and_files_minus_2[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_3[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_4[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_5[$i]}"
	if [[ ${input_dirs_and_files_minus_1[$i]} != "" ]]; then
		minus_masks_exist[$i]=$(( ${minus_masks_exist[$i]}+1 ));
	fi
	if [[ ${input_dirs_and_files_minus_2[$i]} != "" ]]; then
		minus_masks_exist[$i]=$(( ${minus_masks_exist[$i]}+1 ));
	fi
	if [[ ${input_dirs_and_files_minus_3[$i]} != "" ]]; then
		minus_masks_exist[$i]=$(( ${minus_masks_exist[$i]}+1 ));
	fi
	if [[ ${input_dirs_and_files_minus_4[$i]} != "" ]]; then
		minus_masks_exist[$i]=$(( ${minus_masks_exist[$i]}+1 ));
	fi
	if [[ ${input_dirs_and_files_minus_5[$i]} != "" ]]; then
		minus_masks_exist[$i]=$(( ${minus_masks_exist[$i]}+1 ));
	fi
	echo "- minus_masks_exist: "    ${minus_masks_exist[$i]}
	echo "- minus_masks:"    ${minus_masks[$i]}
	echo "- input_compress:"   ${input_compress[$i]}
	echo "- input_verify:"   ${input_verify[$i]}
	echo "====================="

done    # for i in ${param_sets_quantity}
echo
echo "==========================================================================="




# =============================================================================================
# Let/s check the parameters (most of them):
# =============================================================================================

#  check:    script_dir   must be =  check_script_dir

script_dir_test=0
if [[ ${script_dir} != ${check_script_dir} ]]; then
	script_dir_test=1
	echo "problems with script directory - nothing can be fixed - contact the script developer"
	echo "=================================="
	echo
fi

# =============================================================================================

#  check:    input_DSU_limit_MB   - must be  >= 0

DSU_test=0
if (( ${input_DSU_limit_MB} < 0 )); then
	DSU_test=1
	echo "input_DSU_limit_MB   should be greater than 0"
	echo "=================================="
	echo
fi

# =============================================================================================

# check if the basic names for archives are correct:

declare -a short_name_test_result                # if ok then 0
echo
echo "analyzing short names given in parameters sets...."
echo "====="
for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	short_name_test_result[${i}]=0
	length_of_name=0
	first_symbol=''
	symbol=''
	echo "parameters set N:"   ${i}

	length_of_name=$(echo ${#input_name[${i}]})
	if (( ${length_of_name} > 15 )); then
		echo "name length should not exceed 15 characters, but now it is " ${length_of_name} "sharacters long"
		short_name_test_result[${i}]+=1
	fi

	first_symbol=$(echo ${input_name[${i}]:0:1})   # i.e. one symbol in position 0
	if [[ ${first_symbol} != [a-z] ]]  &&  [[ ${first_symbol} != [A-Z] ]]; then
		echo "the name should start with a letter"
		short_name_test_result[${i}]+=1
	fi

	for ((j=1; j<=${length_of_name}; j=j+1))
	do
		position=j-1
		symbol=$(echo ${input_name[${i}]:position:1})   # i.e. one symbol in position 'position'
		if [[ ${symbol} != [a-z] ]]  &&  [[ ${symbol} != [A-Z] ]]  &&  [[ ${symbol} != [0-9] ]]  &&  [[ ${symbol} != '-' ]] ; then 
			echo "only a-z, A-Z, -(hyphen) and 0-9 are allowed"
			short_name_test_result[${i}]+=1
		fi
	done

	if [[ ${short_name_test_result[${i}]} != 0 ]]; then
		echo "Check input_name (" ${input_name[${i}]} ")    for parameters set N"  ${i} 
		echo "Archive with parameters set N" ${i} "cannot be created" 
	else
		echo "..... ok"
	fi
	echo "====="
done
echo


# =============================================================================================

# check: input_amount_of_old should be >= 0  and integer (in bash all numbers are integer - so there is no need to check)

declare -a amount_of_old_test_result                # if ok then 0
echo
echo "analyzing amount of old archives to be stored...."
echo "====="
for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	amount_of_old_test_result[${i}]=0
	echo "parameters set N:"   ${i}
	if (( ${input_amount_of_old[${i}]} < 0 )); then
		amount_of_old_test_result[${i}]+=1
		echo "input_amount_of_old    should be >= 0"
		echo "Archive with parameters set N" ${i} "cannot be created" 
	else
		echo ".... ok"
	fi
	echo "====="
done
echo

# =============================================================================================

# check whether the plus_masks correspond to dirs and files inside the user/s home dir (if he is not root)
# (IN FACT, I DECIDED TO CHECK IF THE files and dirs to be archived belong to script_LEVELUP_dir)



UserName=$(whoami)
echo UserName:  ${UserName}

# script_dir  is determined in the very beginning


script_LEVELUP_dir=${script_dir%/*}
echo script_LEVELUP_dir:    ${script_LEVELUP_dir}

user_home_dir=$(realpath ~)        # no matter if a user is root or common user, this is his home dir
echo user_home_dir:    ${user_home_dir}


users_in_string=$(ls /home/)           # search for usernames                # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
# echo $users_in_string                                                      # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
users_array=($users_in_string)                                               # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
number_of_users=${#users_array[@]}                                           # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
echo ${number_of_users}                                                      # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
echo

declare -a user_paths_array                                                  # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
if (( $number_of_users>=1 )); then                                           # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
	for ((i=0; i<=($number_of_users - 1); ++i))                          # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
	do                                                                   # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
		#  echo ${users_array[i]};                                   # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
		user_paths_array[i]="/home/${users_array[i]}/EpamBackup/"    # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
	        #   echo wwwwww     ${user_paths_array[i]}                   # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
       	done                                                                 # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
fi                                                                           # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
# dalee db proverka togo, chto arhiviruemye directorii - v /home/username/   ili  v   /

# if user is not root, we must check that only files inside his home dir (IN FACT - in script_LEVELUP_dir) are archived
# getting sure the paths are expanded:
declare -a the_most_full_PLUS_paths
declare -a PLUS_path_test_result
if [[ UserName!="root" ]]; then           # first, lets extract all the paths
	echo
	echo "expanding plus_paths...."
	for ((j=1; j<=${param_sets_quantity}; j=j+1))
	do
		echo "====="
		echo "parameters set N:"   ${j}
		the_most_full_PLUS_paths[${j}]=""
		for k in ${plus_masks[${j}]}
		do
			the_most_full_PLUS_paths[${j}]+=" $(realpath ${k})"
		done
		echo "the_most_full_PLUS_paths:"   ${the_most_full_PLUS_paths[${j}]}
	done
	echo "=================================="
                           # next, find out whether full paths belong to user-s home dir (IN FACT - to script_LEVELUP_dir):
	echo
	echo "analyzing plus_paths...."
	for ((j=1; j<=${param_sets_quantity}; j=j+1))
	do
		echo "====="
		echo "parameters set N:"   ${j}
		PLUS_path_test_result[${j}]=0
		for k in ${the_most_full_PLUS_paths[${j}]}
		do
			string1=${k}
			remainder=${string1#${script_LEVELUP_dir}}
			#   echo ${remainder}
			if [ ${remainder} == ${string1} ]; then        # when nothing is taken away from path
				PLUS_path_test_result[${j}]=$(( ${PLUS_path_test_result[${j}]}+1 ))              # 123
			fi
		done
		if ((${PLUS_path_test_result[${j}]} == 0 )); then
			{
			echo "plus_paths for archive " ${j} " are ok"
			if [[ ${input_consider_flag[${j}]} == 'on' ]]; then
				echo "input_consider_flag is set to on"
			elif [[ ${input_consider_flag[${j}]} == 'off' ]]; then
				echo "but the input_consider_flag is set to off, so the archive will not be created"
			fi
			}
		else
			{
			echo ${PLUS_path_test_result[${j}]} "plus_paths after expansion do not belong to  " ${script_LEVELUP_dir}
			echo "archive " ${j} " can not be created"
			if [[ ${input_consider_flag[${j}]} == 'off' ]]; then
				echo "besides, input_consider_flag is set to off, so the archive would not be created anyway"
			fi
			}
		fi
	done
	echo "=================================="
fi
# if this script is started with sudo, then the user is detected as 'root' and his home dir - as '/root'
# (script works correctly, but  executing this script with "sudo" is not recommended) 
# (proverka idet na prinadlezhnostj arhiviruemyh papok papke "script_LEVELUP_dir")


# =============================================================================================

# check compession: let/s choose appropriate suffixes (filename extensions) and options for _tar_ command:

declare -a compress_test_result                # if ok then 0
declare -a extension
declare -a compress_option
echo
echo "analyzing compression...."
echo "====="
for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	compress_test_result[${i}]=0
	echo "parameters set N:"   ${i}
	case ${input_compress[${i}]} in
		'none')
			extension[${i}]='.tar'
			compress_option[${i}]=''   ;;
		'gzip')
			extension[${i}]='.tar.gz'
			compress_option[${i}]='--gzip'   ;;
		'bzip2')
			extension[${i}]='.tar.bz2'
			compress_option[${i}]='--bzip2'   ;;
		'xz')
			extension[${i}]='.tar.xz'
			compress_option[${i}]='--xz'   ;;
		'lzip')
			extension[${i}]='.tar.lz'
			compress_option[${i}]='--lzip'   ;;
		'lzma')
			extension[${i}]='.tar.lzma'
			compress_option[${i}]='--lzma'   ;;
		'lzop')
			extension[${i}]='.tar.lzo'
			compress_option[${i}]='--lzop'   ;;
		'zstd')
			extension[${i}]='.tar.zst'
			compress_option[${i}]='--zstd'   ;;
		*)
			compress_test_result[${i}]=1
			echo "You should have selected one of the following types of compression:"
			echo "  none (no compression), gzip, bzip2, xz,lzip, lzma, lzop, zstd"
			echo "Archive with parameters set N" ${i} "cannot be created" 
	esac
	if [[ ${compress_test_result[${i}]} == 0 ]]; then
		echo "archive extension:"   ${extension[${i}]}
		echo "archive compression option:"  ${compress_option[${i}]}
		if [[ ${compress_option[${i}]} == '' ]]; then echo "(no compression)"; fi
	fi
	echo "====="
done
echo
# =============================================================================================

# check: should archives be verified or not:

declare -a verify_test_result                # if ok then 0
declare -a verify_option
echo
echo "analyzing _verify_ option...."
echo "====="
for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	verify_test_result[${i}]=0
	echo "parameters set N:"   ${i}
	case ${input_verify[${i}]} in
		'on')
			verify_option[${i}]='--verify'   ;;
		'off')
			verify_option[${i}]=''   ;;
		*)
			verify_test_result[${i}]=1
			echo "You should have selected whether the archive should be verified"
			echo "  after creation (on) or not (off)"
			echo "Archive with parameters set N" ${i} "cannot be created" 
	esac
	if [[ ${verify_test_result[${i}]} == 0 ]]; then
		echo "archive verification option:"  ${verify_option[${i}]}
		if [[ ${verify_option[${i}]} == '' ]]; then echo "(no verification)"; fi
	fi
	echo "====="
done
echo




# =============================================================================================
# =============================================================================================


# now we will gather   "DSU_test"   "input_consider_flag"   "short_name_test_result"   "amount_of_old_test_result"
#   "PLUS_path_test_result"    "compress_test_result"    "verify_test_result"


declare -a tests      # if 0 then ok
declare -i ok_count
ok_count=0
echo
echo "============================================="
echo "============================================="
echo "============= Check summary: ================"
if [[ ${DSU_test} != 0 ]]; then
	echo "No archives can be created - "
	echo "- check  input_DSU_limit_MB"
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
		do
		tests[${i}]+=1
		done
else
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
	do
		echo "parameters set N:"   ${i}
		tests[${i}]=0
		if [[ ${input_consider_flag[${i}]} != 'on' ]]; then
			tests[${i}]+=1
			echo "input_consider_flag:" ${input_consider_flag[${i}]}
			echo "archive cannot be created"
		fi
		if (( short_name_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "check input_name:" ${input_name[${i}]}
			echo "archive cannot be created"
		fi
		if (( amount_of_old_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "check input_amount_of_old:" ${input_amount_of_old[${i}]}
			echo "archive cannot be created"
		fi
		if (( PLUS_path_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "common users can add only files within their home directory, check input_dirs_and_files_plus_..."
			echo "archive cannot be created"
		fi
		if (( compress_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "check input_compress:" ${input_compress[${i}]}
			echo "archive cannot be created"
		fi
		if (( verify_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "check input_verify:" ${input_verify[${i}]}
			echo "archive cannot be created"
		fi

                # if everything is ok:
		if (( tests[${i}] == 0 )); then
			ok_count+=1
			echo "everything is ok, archive can be created"
		fi
		echo "====="
	done
fi
echo "============================================="
echo "============================================="
echo "============================================="


# =============================================================================================
# now we should ask the user if he agrees to create  only those archives, the parameters of which are ok
# (or does he want to change parameters):

echo
echo
echo
echo
create_archives='no'

if (( $ok_count == 0 )); then
	echo "...Sorry, all parameters sets are not ok, no archives can be created, check the parameters"
	create_archives='no'
else
	echo "Would you like to continue?"
	echo "If you type"
	echo "            yes (or y):"
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
	do
		if (( tests[${i}] == 0 )); then
			echo "                archive with parameters set N" ${i} " will be created"
		else
			echo "                archive with parameters set N" ${i} " will NOT be created"
		fi
	done
	echo "            no (or anything else):"
	echo "                no archives will be created, script will be terminated,"
	echo "                you can change the parameters and start the script again"
	echo "Type your answer (yes/no) and press [Enter]:"
	read answer
	case ${answer} in
		'yes'|'Yes'|'YEs'|'YES'|'y'|'Y')
			create_archives='yes' ;;
		*)
			create_archives='no' ;;
	esac
fi



# =============================================================================================

# now let/s assemble the long names for archives, including date and extension,
# and gather optins (lists of files in {}, compression option, verificaton option)
# tut uzhe nado ne dlia vseh, a vyborochno (ispolzuem   !array  i  #array)
# - i mozhno voobsche zelikom komandu dlia tar sobiratj

# a potom escho nado budet uchestj DSU i amount_of_old
# =============================================================================================


echo $create_archives
if [[ $create_archives == 'yes' ]] ; then
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
	do
		if (( tests[${i}] == 0 )) ; then
			echo "i ="  $i                                               # potom steretj
			# assemble long names for archives:
			archive_name=$(echo ${input_name[${i}]}"--"${current_date}"--paramset"${i}${extension[${i}]})
			echo ${archive_name}
			# create long command for tar (gather options):
			echo "compress:______________" ${compress_option[${i}]}
			echo "verify:______________" ${verify[${i}]}
			echo "minus (--exclude):_____________" ${minus_masks[${i}]}
			echo "plus:______________" ${plus_masks[${i}]}
			if (( ${minus_masks_exist[$i]} == 0 )); then
				exclude_subphrase=""
			else
				exclude_subphrase=$(echo --exclude ${minus_masks[${i}]})
			fi
			text_for_tar=$(echo -cvf ${archive_name} ${exclude_subphrase} ${compress_option[${i}]} ${verify[${i}]})

# NADO SDELATJ V EXCLUDE V BRACES, V "" I S ZAPIATYMI - PEEHOZHU K VERSII 3

			echo text_for_tar__________  ${text_for_tar}
			# dalee tar
			echo "!!!!!!!!!!!!!!!!!!!!!tut pishem chto nado!!!!!!!!!!!!!!!!!!!!!"
		fi      #  (( tests[${i}] == 0 ))
	done
fi


















# potom sdelatj tak chtoby osnovnoy tekst pisalsya v logi
# a dlia voprosov sdelatj opziu ih otklucheniya (silent) - chtoby avtomaticheski vse rabotalo





# For "tar" command, there might exist a limit on the length of the lists of included and excluded paths,
# this should be checked sometimes.
