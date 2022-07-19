#! /bin/bash -x


# =============================================================================================
current_date=$(date +%Z%Y-%m-%d--%H-%M-%S)--$(date -u +%Z%Y-%m-%d--%H-%M-%S)

# redirect all errors to log file with errors (some "error" messages from tar are not errors in fact):
echo "                                           " >> B-log-errors              # for convenience
echo "============" ${current_date} "============" >> B-log-errors              # for convenience
exec 2>> B-log-errors
# =============================================================================================



# =============================================================================================
# =============================================================================================
# script parameters:
# =============================================================================================

   # DECLARE seychas ne nuzhno, no pustj ostanutsya na potom,  esli vynesu parametry v otdelnyy fail


declare  input_DSU_limit_MiB              # disk space usage limit in megabytes - to be occupied by all of the saved archives
                                         # (archives are saved in 'EpamBackup/B-Archives/')
                                         # (if the limit is reached, only a message is generated, but no deletion is performed)
                                         # (0 means "no limit")

                                   # below, the arrays are used to save parameters for (currently) three archives to be created:

declare -a input_consider_flag                   # - shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
declare -a input_name                            # - name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
                                                 # two dashes (--) are NOT allowed

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
declare -a input_dirs_and_files_plus_1           # - directories and separate file names (or masks) TO BE included in the archive
declare -a input_dirs_and_files_plus_2           #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
declare -a input_dirs_and_files_plus_3           #   print nothing after = if there is no need for another mask
declare -a input_dirs_and_files_plus_4           #   but do not delete lines
declare -a input_dirs_and_files_plus_5           #   also do not duplicate lines, the max number of masks is 5.

declare -a input_dirs_and_files_minus_1          # - directories and separate file names (or masks) NOT TO BE included in the archive
declare -a input_dirs_and_files_minus_2          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
declare -a input_dirs_and_files_minus_3          #   print nothing after = if there is no need for another mask
declare -a input_dirs_and_files_minus_4          #   but do not delete lines
declare -a input_dirs_and_files_minus_5          #   also do not duplicate lines, the max number of masks is 5.

declare -a input_compress                        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
declare -a input_verify                          # - verify the archive as does "tar --verify" ('on') or not ('off')







# =============================================================================================
# overall parameters:
input_DSU_limit_MiB=100             # disk space usage limit in mebibytes - to be occupied by all of the saved archives
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
                                                 # two dashes (--) are NOT allowed

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=~            # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=                #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=~/D*          # directories and separate file names (or masks) NOT TO BE included in the archive
input_dirs_and_files_minus_2[ord]=*.mp3          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=~/.??*              #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=*.mymymy              #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='bzip2'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='on'           # - verify the archive as does "tar --verify" ('on') or do not verify ('off')



# The second set of parameters: ==================================================================================
ord=2      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='spec'           # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
                                                 # two dashes (--) are NOT allowed

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=~                # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=~/dir_for_backup    #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=*.txt          # directories and separate file names (or masks) NOT TO BE included in the archive
input_dirs_and_files_minus_2[ord]=*.bmp          #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=~/.cache               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=*.mymymy               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='none'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='off'           # - verify the archive as does "tar --verify" ('on') or do not verify ('off')



# The third set of parameters: ==================================================================================
ord=3      # do not change this line

# make changes to the right of '=' sign:
        input_consider_flag[ord]='on'            # shows whether to use or not a set of parameters
                                                 # 'on' (perform archiving with these settings)  or 'off' (do not)
                 input_name[ord]='misc'          # name for an archive (also the date will be added automatically)
                                                 # inside ' ' start with a letter, no more than 15 characters
                                                 # (letters, numbers, dashes) are allowed
                                                 # two dashes (--) are NOT allowed

                                              # BELOW PATHS SHOULD start with / or ~ (only file masks can start with *)
input_dirs_and_files_plus_1[ord]=/home/mysshfriend/*     # directories and separate file names (or masks) TO BE included in the archive
input_dirs_and_files_plus_2[ord]=~/Music         #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_plus_3[ord]=/etc                #   print nothing after = if there is no need for another mask
input_dirs_and_files_plus_4[ord]=                #   but do not delete lines
input_dirs_and_files_plus_5[ord]=                #   also do not duplicate lines, the max number of masks is 5.

input_dirs_and_files_minus_1[ord]=               # directories and separate file names (or masks) NOT TO BE included in the archive
input_dirs_and_files_minus_2[ord]=               #   (one by each variable, WITHOUT QUOTES -WHY? I FORGOT... WITH = OK)
input_dirs_and_files_minus_3[ord]=               #   print nothing after = if there is no need for another mask
input_dirs_and_files_minus_4[ord]=               #   but do not delete lines
input_dirs_and_files_minus_5[ord]=               #   also do not duplicate lines, the max number of masks is 5.

              input_compress[ord]='bzip2'        # - compression agorythm:
                                                 # 'none' or one of: 'gzip', 'bzip2', 'xz', 'lzip', 'lzma', 'lzop', 'zstd'
                input_verify[ord]='off'           # - verify the archive as does "tar --verify" ('on') or do not verify ('off')



# =============================================================================================
# =============================================================================================

# in the very beginning we should change current directory to the directory where script is located



path_to_0=$(realpath "$0")
echo ${path_to_0}
script_dir=$(dirname ${path_to_0})
echo script_dir:    ${script_dir}           # ATTENTION:  if script itself was called without full path
                                         #(e.g. "bash B-script.sh" )  and "cd" was called upper in the script
                                         # - then realpath "$0" IN FACT gives current dir - NOT the dir the script is located in
 				 	 # -- hence, if I call "cd" to be sure for paths, I should do it carefully
                                         # (which means "no _ cd _ upper in the script" !!!)

cd ${script_dir}   # make script_dir current directory (this is done for correct expansion of paths by different commands)

check_script_dir="$(dirname "$(realpath "$0")")"       # the same expresion as for script_dir, but AFTER cd
echo check_script_dir:    ${check_script_dir}

# (the check itself is written further below (see script_dir_test))

# =============================================================================================
# the primary  processing of user-defined settings:

param_sets_quantity=ord    # (needs control !!!) - quantity of sets of parameters  (= the last ord value)
plus_quantity=5         # FOR INFO ONLY (needs control !!!) - quantity of masks of dirs and files to be included in one archive
minus_quantity=5        # FOR INFO ONLY (needs control !!!) - quantity of masks of dirs and files NOT to be included in one archive


declare -a plus_masks
declare -a minus_masks
declare -a minus_masks_exist           # we need to know the quantity of specified (non-empty) minus masks,
                         # because to exclude a mask, we must write "--exclude" for tar each time (this is done below, further)

echo
echo "==========================================================================="
echo
echo "Local and universal time (year-month-day--hours-mins-secs): "
echo $current_date
echo "==========================================================================="
echo "Parameters:"
echo
# ostavitj kak primer skobok v if:    if (( ${input_DSU_limit_MiB} == 0 )) && [[ ${input_consider_flag[$i]} == 'on' ]]; then
if [[ ${input_DSU_limit_MiB} == 0 ]]; then
	echo "- no   input_DSU_limit_MiB    is set (0 means 'no limit')";
else
	echo "- input_DSU_limit_MiB:"   ${input_DSU_limit_MiB}
fi

for ((i=1; i<=${param_sets_quantity}; i=i+1))
do
	echo "parameters set N:"   $i
	echo "- input_consider_flag:"   ${input_consider_flag[$i]}
	echo "- input_name:"   ${input_name[$i]}
	echo "- input_amount_of_archives:"   ${input_amount_of_archives[$i]}

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

#  check:    input_DSU_limit_MiB   - must be  >= 0

DSU_test=0
if (( ${input_DSU_limit_MiB} < 0 )); then
	DSU_test=1
	echo "input_DSU_limit_MiB   should be greater than 0"
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

	if (( ${length_of_name} >= 2 )); then
		end_of_seek=$(( ${length_of_name}-1 ))
		for ((j=1; j<=${end_of_seek}; j=j+1))
		do
			position1=j-1
			position2=j
			symbol1=$(echo ${input_name[${i}]:position1:1})   # i.e. one symbol in position 'position1'
			symbol2=$(echo ${input_name[${i}]:position2:1})   # i.e. one symbol in position 'position2'
			if [[ ${symbol1} == '-' ]]  &&  [[ ${symbol2} == '-' ]] ; then 
				echo "two hyphens (--) side by side are not allowed"
				short_name_test_result[${i}]+=1
			fi
		done
	fi

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

# check if the basic names for archives repeat (they shouldn't)

declare -i amount_of_diverse_names
declare -a diverse_names
declare -a diverse_names_occurrences
declare -i at_least_one_coincidence_found

amount_of_diverse_names=0
at_least_one_coincidence_found=0
echo
echo "analyzing short names given in parameters sets for repeats...."
for ((j=1; j<=${param_sets_quantity}; j=j+1))
do
	current_short_name=${input_name[${j}]}
	for ((n=1; n<=${param_sets_quantity}; n=n+1))    # param_sets_quantity is small (currently 3), so this algorythm is ok enough
	do
		name_to_compare=${input_name[${n}]}
		if [[ ${name_to_compare} == ${current_short_name} ]] && (( ${j} != ${n} )) ; then
			at_least_one_coincidence_found+=1
		fi
	done
done

short_names_are_different_test=0
if (( ${at_least_one_coincidence_found} != 0 )) ; then
	echo "Archives should be given different names - check input_name for each archive"
        short_names_are_different_test=1
else
	echo "..... ok (no repeats)"
fi
echo "====="
echo




# =============================================================================================

# check whether the plus_masks correspond to dirs and files inside the user/s home dir (if he is not root)
# (IN FACT, I DECIDED TO CHECK IF THE files and dirs to be archived belong to script_LEVELUP_dir)



UserName=$(whoami)
echo UserName:  ${UserName}

# script_dir  is determined in the very beginning of this script


script_LEVELUP_dir=$(dirname ${script_dir})
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
if [[ ${UserName} != "root" ]]; then           # first, lets extract all the paths
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
			if [[ ${remainder} == ${string1} ]]; then        # when nothing is taken away from path
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

# check if files and dirs (plus and minus) exist - USELESS - will not work for file masks
# the only way to get sure is to read  B-log-errors
#
# for ((i=1; i<=${param_sets_quantity}; i=i+1))
# do
# 	plus_paths_exist_test_result[$i]=0         # 0 will mean ok, paths exist
# 	for ip in ${plus_masks[$i]}
# 	do
# 		if ! $(test -e ${ip}); then plus_paths_exist_test_result[$i]+=1; fi
# 	done
# done


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


# now we will gather   "DSU_test"   "input_consider_flag"   "short_name_test_result"   "short_names_are_different_test"
#   "amount_of_archives_test_result"    "PLUS_path_test_result"    "compress_test_result"    "verify_test_result"


declare -a tests      # if 0 then ok
declare -i ok_count
ok_count=0
echo
echo "============================================="
echo "============================================="
echo "============= Check summary: ================"
if [[ ${DSU_test} != 0 ]]; then
	echo "No archives can be created - "
	echo "- check  input_DSU_limit_MiB"
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
		do
		tests[${i}]+=1
		done

elif [[ ${short_names_are_different_test} != 0 ]]; then
	echo "No archives can be created - "
	echo "- check  input_name  for each archive - they should be different"
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
		if (( amount_of_archives_test_result[${i}] != 0 )); then
			tests[${i}]+=1
			echo "check input_amount_of_archives:" ${input_amount_of_archives[${i}]}
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
# and execute tar
# and write positive logs to B-log 
# (the negative logs are redirected to B-log-errors, see in the beginning of this script)
# =============================================================================================


echo "                                           " >> B-log              # for convenience
echo "==========================================================================" >> B-log
echo "==========================================================================" >> B-log
echo "==========================================================================" >> B-log
echo "============" ${current_date} "============" >> B-log              # for convenience
echo "                                           " >> B-log
echo "Arcive(s) will be created for the following parameters sets:" >> B-log

echo $create_archives
if [[ $create_archives == 'yes' ]] ; then
	for ((i=1; i<=${param_sets_quantity}; i=i+1))
	do
		if (( tests[${i}] == 0 )) ; then
			echo " " >> B-log
			echo "================= parameters set #" $i " =================:" >> B-log
			echo "=== - name (input_name["$i"]):" ${input_name[$i]} >> B-log
			echo "=== - dirs and file masks (after filename expansion) to be archived:"  >> B-log
			echo "===  -- input_dirs_and_files_plus_1["$i"]:  " ${input_dirs_and_files_plus_1[$i]} >> B-log
			echo "===  -- input_dirs_and_files_plus_2["$i"]:  " ${input_dirs_and_files_plus_2[$i]} >> B-log
			echo "===  -- input_dirs_and_files_plus_3["$i"]:  " ${input_dirs_and_files_plus_3[$i]} >> B-log
			echo "===  -- input_dirs_and_files_plus_4["$i"]:  " ${input_dirs_and_files_plus_4[$i]} >> B-log
			echo "===  -- input_dirs_and_files_plus_5["$i"]:  " ${input_dirs_and_files_plus_5[$i]} >> B-log
			echo "=== - dirs and files masks (after filename expansion) NOT to be archived:"  >> B-log
			echo "===  -- input_dirs_and_files_minus_1["$i"]:  " ${input_dirs_and_files_minus_1[$i]} >> B-log
			echo "===  -- input_dirs_and_files_minus_2["$i"]:  " ${input_dirs_and_files_minus_2[$i]} >> B-log
			echo "===  -- input_dirs_and_files_minus_3["$i"]:  " ${input_dirs_and_files_minus_3[$i]} >> B-log
			echo "===  -- input_dirs_and_files_minus_4["$i"]:  " ${input_dirs_and_files_minus_4[$i]} >> B-log
			echo "===  -- input_dirs_and_files_minus_5["$i"]:  " ${input_dirs_and_files_minus_5[$i]} >> B-log
			echo "=== - compression (input_compress["$i"]):" ${input_compress[$i]} >> B-log
			echo "=== - need for verification (input_verify["$i"]):" ${input_verify[$i]} >> B-log
			echo " " >> B-log

			# assemble long names for archives:
			archive_name=$(echo ${script_dir}"/B-Archives/paramset"${i}"--"${input_name[${i}]}"--"${current_date}${extension[${i}]})

			# create long command for tar (gather options):

			# the script directory (and all archives inside) will not be added to the new archive
			# (minus_masks should also be excluded from archive)
			exclude_subphrase="--exclude="
			exclude_subphrase+=\'
			exclude_subphrase+=${script_dir}
			exclude_subphrase+=\'
			exclude_subphrase+=" "
			if (( ${minus_masks_exist[$i]} != 0 )); then
				for k in ${minus_masks[${i}]}
				do
					exclude_subphrase+="--exclude="
					exclude_subphrase+=\'
					exclude_subphrase+=${k}
					exclude_subphrase+=\'
					exclude_subphrase+=" "
				done
			fi

			basic_options=" -cvf "

			text_for_tar=$(echo ${basic_options} ${archive_name} ${exclude_subphrase} ${compress_option[${i}]} ${verify[${i}]} ${plus_masks[${i}]})

			# tar lets to write names of excluded files in "", but does not let to write names of included files in ""
			# so, there is a possible problem with filenames that include spaces!!!
			# Fortunately, at least Debian Bullseye places single quotes around a filename with a space within the name
			# so I will not write a corresponding check right now.
			# echo text_for_tar__________  ${text_for_tar}
			# dalee tar
			eval tar ${text_for_tar}
			# echo "================= tar command for parameters set # " $i " : =================:" >> B-log
			# echo "tar" ${text_for_tar} >> B-log
		fi      #  (( tests[${i}] == 0 ))
	done
fi





# =============================================================================================
# let's count the size of directory B-Archives

declare -i count_in_DSU_long
declare -i current_DSU_bytesf
declare -i input_DSU_limit_bytes

name_of_dir_with_archives="$(echo ${script_dir}/B-Archives/)"

# old text (the new one is below - using awk)
# current_DSU_bytes_text=$(eval du --summarize --block-size=1 ${name_of_dir_with_archives})    # gives a string with two fields
# counter_of_fields=0
# for i in  ${current_DSU_bytes_text}
# do
# 	counter_of_fields+=1
# 	if (( ${counter_of_fields} == 1 )); then
# 		current_DSU_bytes=$i
# 	fi
# done
# echo current_DSU_bytes_text = ${current_DSU_bytes_text}

current_DSU_bytes=$(du --summarize --block-size=1 ${name_of_dir_with_archives} | awk '{ print $1 }')    # gives a string with two fields
# echo current_DSU_bytes = ${current_DSU_bytes}

input_DSU_limit_bytes=$(( ${input_DSU_limit_MiB}*(2**20) ))

#if (( ${input_DSU_limit_bytes} > 0 )); then
#	echo "input_DSU_limit_bytes = "$input_DSU_limit_bytes
#else 
#	echo "input_DSU_limit_bytes: unlimited"
#fi

if (( ${current_DSU_bytes} >= ${input_DSU_limit_bytes} )) && (( ${input_DSU_limit_bytes} > 0 )); then
	echo "======================================"
	echo "ATTENTION! Current disk space usage in " ${name_of_dir_with_archives} "(" ${current_DSU_bytes} "bytes)"
	echo " is larger than input_DSU_limit (" ${input_DSU_limit_bytes} " bytes or "${input_DSU_limit_MiB} "MiB)"
	echo " CONSIDER DELETING OLD ARCHIVES MANUALLY (no auto deletion will be performed)"
	echo "======================================"
elif (( ${current_DSU_bytes} >= $((${input_DSU_limit_bytes}/2)) )) && (( ${input_DSU_limit_bytes} > 0 )); then
	echo "======================================"
	echo "ATTENTION! Current disk space usage in " ${name_of_dir_with_archives} "(" ${current_DSU_bytes} "bytes)"
	echo " is getting close to input_DSU_limit (" ${input_DSU_limit_bytes} " bytes or " ${input_DSU_limit_MiB} "MiB )"
	echo " CONSIDER DELETING OLD ARCHIVES MANUALLY (no auto deletion will be performed)"
	echo "======================================"
fi

# =============================================================================================
# let's count the amount of archives with the same "shortname" inside

declare -a existing_archives_short_names
declare -i count_files
declare -i total_number_of_files

list_of_all_archives=$(eval ls ${name_of_dir_with_archives})
# echo ${list_of_all_archives}

count_files=0
for k in ${list_of_all_archives}
do
	count_files+=1
	length_of_filename=$(echo ${#k})
	first_two_hyphens_detected=0
	second_two_hyphens_detected=0
	current_short_name=""
	end_of_seek_in_filename=$(( ${length_of_filename}-1 ))
	for ((j=1; j<=${end_of_seek_in_filename}; j=j+1))
	do
		position1=j-1
		position2=j
		symbol1=$(echo ${k:position1:1})   # i.e. one symbol in position 'position1'
		symbol2=$(echo ${k:position2:1})   # i.e. one symbol in position 'position2'
		if [[ ${symbol1} == '-' ]]  &&  [[ ${symbol2} == '-' ]] && (( ${first_two_hyphens_detected} == 0 )); then
			first_two_hyphens_detected=1
			current_short_name+=${symbol1}
		elif [[ ${symbol1} == '-' ]]  &&  [[ ${symbol2} == '-' ]] && (( ${first_two_hyphens_detected} == 1 )); then
			second_two_hyphens_detected=1
		elif [[ ${second_two_hyphens_detected=1} == 0 ]] ; then
			current_short_name+=${symbol1}
		fi
	done
	existing_archives_short_names[${count_files}]=${current_short_name}
done
total_number_of_files=${count_files}

# let's count unique short names (the beginnings of archives names)
declare -i amount_of_unique_names
declare -a unique_names
declare -a unique_names_occurrences

amount_of_unique_names=0
for ((j=1; j<=${total_number_of_files}; j=j+1))
do
	current_short_name=${existing_archives_short_names[${j}]}
	# echo ${current_short_name}
	if (( amount_of_unique_names == 0 )); then
		amount_of_unique_names=1
		unique_names[1]=${current_short_name}
		eval let unique_names_occurrences[1]=1*1    # reason for this: to be +/- sure that array members are integers...
	else
		coincidence_found=0
		for ((n=1; n<=${amount_of_unique_names}; n=n+1))
		do
			name_to_compare=${unique_names[${n}]}
			if [[ ${name_to_compare} == ${current_short_name} ]] ; then
				eval let unique_names_occurrences[${n}]+=1        # see the reason slightly above
				coincidence_found=1
			fi
		done
		if (( coincidence_found == 0 )) ; then
			amount_of_unique_names+=1
			unique_names[${amount_of_unique_names}]=${current_short_name}
			eval let unique_names_occurrences[${amount_of_unique_names}]=1*1    # see the reason slightly above
		fi
	fi
done

# echo amount_of_unique_names  ${amount_of_unique_names}
if (( ${amount_of_unique_names} > 0 )); then
	echo "Amount of archives in " ${name_of_dir_with_archives} "," 
	echo " the name of which starts with:"
	for ((n=1; n<=${amount_of_unique_names}; n=n+1))
	do
		echo "                        " ${unique_names[${n}]} " ,   is   " ${unique_names_occurrences[${n}]}
	done
	echo "If the amount is unreasonably high, consider deleting old archives manually (no auto deletion will be performed)"
fi
echo "===="
echo "Consider erasing files B-log and B-log-errors if the become too large"




# we have:
# 1) param_sets_quantity, arrays "input_name"
# 2) amount_of_unique_names , arrays "unique_names", "unique_names_occurrences"




# For "tar" command, there might exist a limit on the length of the lists of included and excluded paths,
# this should be checked sometimes.
# Also sometimes all the messages should be redirected from screen to a log.

