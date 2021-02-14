#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// params.inUri = '/Users/zager/Documents/Projects/DvcDemoPipelines'
params.output.folder = '/Users/zager/Documents/Projects/DvcDemoPipelines/output'
params.word = ' A '

process count {

    publishDir "$params.output.folder"

    input:
      path x
    
    output:
      path "count.txt"

    script: 
        """
        grep -o -i $params.word $x | wc -l > count.txt
        """
}

process capitalize {

    publishDir "$params.output.folder"

    input:
      path x

    output:
      path "output.txt"

    script: 
        """
        tr "[:lower:]" "[:upper:]" < $x > output.txt
        """
}

workflow {
    files = channel.fromPath("*.txt")
    capitalize(files)
    count(files)
}