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
                                                 # (letters. numbers, dashes) are allowed
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
                                                 # (letters. numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=~/D*            # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=                #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=~/*          # directories and separate file names (or masks) TO BE included in the archive
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
                                                 # (letters. numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=**         # directories and separate file names (or masks) TO BE included in the archive
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
                input_verify[ord]='no'           # - verify the archive as does "tar --verify" ('on') or not ('off')



# The third set of parameters: ==================================================================================
ord=3      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='misc'          # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters. numbers, dashes) are allowed
        input_amount_of_old[ord]=2               # amount of old archives to be preserved,  besides the created one
                                                 #    (if 0 then no deletion of the oldest one is performed)

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=/home/mysshfriend/*     # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=~/Music         #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=/etc                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=*.txt          # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_minus_2[ord]=*.bmp          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='bzip2'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='off'           # - verify the archive as does "tar --verify" ('on') or not ('off')



# =============================================================================================
# =============================================================================================
# the primary  processing of user-defined settings:

param_sets_quantity=3        # (needs control) - quantity of sets of parameters
plus_quantity=5           # FOR INFO ONLY (needs control) - quantity of masks of dirs and files to be included in the archive
minus_quantity=5          # FOR INFO ONLY (needs control) - quantity of masks of dirs and files NOT to be included in the archive


echo
echo "==========================================================================="
echo
echo "Local and universal time (year-month-day--hours-mins-secs): "
echo $(date +%Z%Y-%m-%d--%H-%M-%S)--$(date -u +%Z%Y-%m-%d--%H-%M-%S)
echo "Set-up:"
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

	minus_masks[$i]=${input_dirs_and_files_minus_1[$i]}
	minus_masks[$i]+=" ${input_dirs_and_files_minus_2[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_3[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_4[$i]}"
	minus_masks[$i]+=" ${input_dirs_and_files_minus_5[$i]}"
	echo "- minus_masks:"   ${minus_masks[$i]}

	echo "- input_compress:"   ${input_compress[$i]}
	echo "- input_verify:"   ${input_verify[$i]}
	echo "====================="

	done    # for i in ${param_sets_quantity}
echo


# =============================================================================================
# check whether the plus_masks correspond to dirs and files inside the user/s home dir (if he is not root)
# (IN FACT, I DECIDED TO CHECK IF THE files and dirs to be archived belong to script_LEVELUP_dir)
# (- BECAUSE )
# some other check-ups are also performed in this section


UserName=$(whoami)
echo UserName:  ${UserName}

script_dir="$(dirname "$(realpath "$0")")"    # I am not sure if the quotes are correct, but this works
echo script_dir:    ${script_dir}

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
		do                                                           # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
		#  echo ${users_array[i]};                                   # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
		user_paths_array[i]="/home/${users_array[i]}/EpamBackup/"    # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
	        #   echo wwwwww     ${user_paths_array[i]}                   # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
        	done                                                         # NE ISPOLZUYU - POTOM STERETJ ESLI NE NADO BUDET
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
		for k in ${plus_masks[$j]}
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

# Compession: let/s choose appropriate suffixes (filename extensions) and options for _tar_ command:

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

# Should archives be verified or not:

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

# let/s check if the basic names for archives are correct:


# =============================================================================================

#  input_DSU_limit_MB    db >=0

# =============================================================================================

# now we will account both for input_flags ("input_consider_flag" array)
#    and for paths check results ("PLUS_path_test_result" array)
#          "compress_test_result"            "verify_test_result"   "short_name_test_result"
# and ask the user if he agrees to create those archives or wants to change parameters:


# =============================================================================================

# now let/s and assemble the long names for archives, including date and extension

# =============================================================================================














# For "tar" command, there might exist a limit on the length of the lists of included and excluded paths,
# this should be checked sometimes.
