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

@ num = 0
## Running total of 40 tests (0-39)
        cp ${tests}/dmem_0.fill cmp_test.dmem.0.fill
		cp ${tests}/dmem_15.fill cmp_test.dmem.15.fill
		
		cp ${tests}/imem_0.fill cmp_test.imem.0.fill
		cp ${tests}/imem_15.fill cmp_test.imem.15.fill
		
	
	echo "" >> ${myid}.txt
	echo "Running Test # ${num} " >> ${myid}.txt
	echo "Running Test # ${num} " >> ${myid}.diff
	echo "Running Test # ${num} "
	
	# Run the test
	make run >> ${myid}.txt


	echo " " >> ${myid}.diff
	echo " " >> ${myid}.diff

	@ num = $num + 1
end

## End of testing
# Here are the results file
ls ${myid}*
