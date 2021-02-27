#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process capitalize {

    container "ubuntu:20.04"
    publishDir params.publishDir
    
    input:
        path inputFile
        
    output:
        path 'output.txt'

    script:
        """
        #!/bin/bash
        
        echo "$params.word Appears " > output.txt
        grep -o -i $params.word file.txt | wc -l >> output.txt
        echo " times" >> output.txt
        """
}

workflow {
    files = channel.fromPath(params.sourceDir + "file.txt")
    capitalize(files)
}
