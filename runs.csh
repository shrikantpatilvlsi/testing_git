#!/bin/csh -f

set cur_dir = `pwd`
echo $cur_dir
set myid = `whoami`
echo $myid


set tests = ${cur_dir}/test_cases

# Remove log files
rm -f ${myid}.txt ${myid}.diff


make init
make clean
make

@ num = 42
## Running total of 40 tests (0-39)
while ( $num < 43 )
	if ($num == 0 || $num == 41) then
		cp ${tests}/dmem_${num}.0.fill cmp_test.dmem.0.fill
		cp ${tests}/dmem_${num}.1.fill cmp_test.dmem.1.fill
		cp ${tests}/dmem_${num}.2.fill cmp_test.dmem.2.fill
		cp ${tests}/dmem_${num}.3.fill cmp_test.dmem.3.fill
		cp ${tests}/dmem_${num}.4.fill cmp_test.dmem.4.fill
		cp ${tests}/dmem_${num}.5.fill cmp_test.dmem.5.fill
		cp ${tests}/dmem_${num}.6.fill cmp_test.dmem.6.fill
		cp ${tests}/dmem_${num}.7.fill cmp_test.dmem.7.fill
		cp ${tests}/dmem_${num}.8.fill cmp_test.dmem.8.fill
		cp ${tests}/dmem_${num}.9.fill cmp_test.dmem.9.fill
		cp ${tests}/dmem_${num}.10.fill cmp_test.dmem.10.fill
		cp ${tests}/dmem_${num}.11.fill cmp_test.dmem.11.fill
		cp ${tests}/dmem_${num}.12.fill cmp_test.dmem.12.fill
		cp ${tests}/dmem_${num}.13.fill cmp_test.dmem.13.fill
		cp ${tests}/dmem_${num}.14.fill cmp_test.dmem.14.fill
		cp ${tests}/dmem_${num}.15.fill cmp_test.dmem.15.fill

		cp ${tests}/imem_${num}.0.fill cmp_test.imem.0.fill
		cp ${tests}/imem_${num}.1.fill cmp_test.imem.1.fill
		cp ${tests}/imem_${num}.2.fill cmp_test.imem.2.fill
		cp ${tests}/imem_${num}.3.fill cmp_test.imem.3.fill
		cp ${tests}/imem_${num}.4.fill cmp_test.imem.4.fill
		cp ${tests}/imem_${num}.5.fill cmp_test.imem.5.fill
		cp ${tests}/imem_${num}.6.fill cmp_test.imem.6.fill
		cp ${tests}/imem_${num}.7.fill cmp_test.imem.7.fill
		cp ${tests}/imem_${num}.8.fill cmp_test.imem.8.fill
		cp ${tests}/imem_${num}.9.fill cmp_test.imem.9.fill
		cp ${tests}/imem_${num}.10.fill cmp_test.imem.10.fill
		cp ${tests}/imem_${num}.11.fill cmp_test.imem.11.fill
		cp ${tests}/imem_${num}.12.fill cmp_test.imem.12.fill
		cp ${tests}/imem_${num}.13.fill cmp_test.imem.13.fill
		cp ${tests}/imem_${num}.14.fill cmp_test.imem.14.fill
		cp ${tests}/imem_${num}.15.fill cmp_test.imem.15.fill


	else if ($num == 42) then
		cp ${tests}/dmem.fill cmp_test.dmem.0.fill
		cp ${tests}/dmem.fill cmp_test.dmem.1.fill
		cp ${tests}/dmem.fill cmp_test.dmem.2.fill
		cp ${tests}/dmem.fill cmp_test.dmem.3.fill
		cp ${tests}/dmem.fill cmp_test.dmem.4.fill
		cp ${tests}/dmem.fill cmp_test.dmem.5.fill
		cp ${tests}/dmem.fill cmp_test.dmem.6.fill
		cp ${tests}/dmem.fill cmp_test.dmem.7.fill
		cp ${tests}/dmem.fill cmp_test.dmem.8.fill
		cp ${tests}/dmem.fill cmp_test.dmem.9.fill
		cp ${tests}/dmem.fill cmp_test.dmem.10.fill
		cp ${tests}/dmem.fill cmp_test.dmem.11.fill
		cp ${tests}/dmem.fill cmp_test.dmem.12.fill
		cp ${tests}/dmem.fill cmp_test.dmem.13.fill
		cp ${tests}/dmem.fill cmp_test.dmem.14.fill
		cp ${tests}/dmem.fill cmp_test.dmem.15.fill


		cp ${tests}/cmp_test.asm cmp_test.imem.0.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.1.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.2.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.3.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.4.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.5.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.6.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.7.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.8.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.9.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.10.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.11.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.12.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.13.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.14.fill
		cp ${tests}/cmp_test.asm cmp_test.imem.15.fill
	else
		cp ${tests}/dmem.fill cmp_test.dmem.0.fill
		cp ${tests}/dmem.fill cmp_test.dmem.1.fill
		cp ${tests}/dmem.fill cmp_test.dmem.2.fill
		cp ${tests}/dmem.fill cmp_test.dmem.3.fill
		cp ${tests}/dmem.fill cmp_test.dmem.4.fill
		cp ${tests}/dmem.fill cmp_test.dmem.5.fill
		cp ${tests}/dmem.fill cmp_test.dmem.6.fill
		cp ${tests}/dmem.fill cmp_test.dmem.7.fill
		cp ${tests}/dmem.fill cmp_test.dmem.8.fill
		cp ${tests}/dmem.fill cmp_test.dmem.9.fill
		cp ${tests}/dmem.fill cmp_test.dmem.10.fill
		cp ${tests}/dmem.fill cmp_test.dmem.11.fill
		cp ${tests}/dmem.fill cmp_test.dmem.12.fill
		cp ${tests}/dmem.fill cmp_test.dmem.13.fill
		cp ${tests}/dmem.fill cmp_test.dmem.14.fill
		cp ${tests}/dmem.fill cmp_test.dmem.15.fill

		cp ${tests}/imem_${num}.fill cmp_test.imem.0.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.1.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.2.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.3.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.4.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.5.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.6.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.7.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.8.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.9.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.10.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.11.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.12.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.13.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.14.fill
		cp ${tests}/imem_${num}.fill cmp_test.imem.15.fill
	endif

	echo "" >> ${myid}.txt
	echo "Running Test # ${num} " >> ${myid}.txt
	echo "Running Test # ${num} " >> ${myid}.diff
	echo "Running Test # ${num} "

	# Run the test
	make run >> ${myid}.txt

	if ($num == 0 || $num == 41) then
		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.0.dump cmp_test.dmem0.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.0.dump cmp_test.dmem0.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.0.dump cmp_test.dmem0.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.1.dump cmp_test.dmem1.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.1.dump cmp_test.dmem1.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.1.dump cmp_test.dmem1.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.2.dump cmp_test.dmem2.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.2.dump cmp_test.dmem2.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.2.dump cmp_test.dmem2.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.3.dump cmp_test.dmem3.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.3.dump cmp_test.dmem3.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.3.dump cmp_test.dmem3.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.4.dump cmp_test.dmem4.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.4.dump cmp_test.dmem4.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.4.dump cmp_test.dmem4.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.5.dump cmp_test.dmem5.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.5.dump cmp_test.dmem5.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.5.dump cmp_test.dmem5.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.6.dump cmp_test.dmem6.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.6.dump cmp_test.dmem6.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.6.dump cmp_test.dmem6.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.7.dump cmp_test.dmem7.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.7.dump cmp_test.dmem7.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.7.dump cmp_test.dmem7.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.8.dump cmp_test.dmem8.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.8.dump cmp_test.dmem8.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.8.dump cmp_test.dmem8.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.9.dump cmp_test.dmem9.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.9.dump cmp_test.dmem9.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.9.dump cmp_test.dmem9.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.10.dump cmp_test.dmem10.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.10.dump cmp_test.dmem10.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.10.dump cmp_test.dmem10.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.11.dump cmp_test.dmem11.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.11.dump cmp_test.dmem11.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.11.dump cmp_test.dmem11.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.12.dump cmp_test.dmem12.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.12.dump cmp_test.dmem12.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.12.dump cmp_test.dmem12.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.13.dump cmp_test.dmem13.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.13.dump cmp_test.dmem13.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.13.dump cmp_test.dmem13.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.14.dump cmp_test.dmem14.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.14.dump cmp_test.dmem14.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.14.dump cmp_test.dmem14.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.15.dump cmp_test.dmem15.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.15.dump cmp_test.dmem15.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.15.dump cmp_test.dmem15.dump >> ${myid}.diff

	else
		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem0.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem0.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem0.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem1.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem1.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem1.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem2.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem2.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem2.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem3.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem3.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem3.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem4.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem4.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem4.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem5.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem5.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem5.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem6.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem6.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem6.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem7.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem7.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem7.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem8.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem8.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem8.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem9.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem9.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem9.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem10.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem10.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem10.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem11.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem11.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem11.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem12.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem12.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem12.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem13.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem13.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem13.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem14.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem14.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem14.dump >> ${myid}.diff

		echo "diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem15.dump" >> ${myid}.diff
		diff --brief --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem15.dump >> ${myid}.diff
		diff --ignore-all-space ${tests}/expected_dmem_${num}.dump cmp_test.dmem15.dump >> ${myid}.diff
	endif

	echo " " >> ${myid}.diff
	echo " " >> ${myid}.diff

	@ num = $num + 1
end

## End of testing
# Here are the results file
ls ${myid}*
