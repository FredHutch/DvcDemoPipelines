#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process capitalize {

    container "ubuntu:20.04"
    
    input:
        path inputFile
        
    output:
        path 'output.txt'

    script:
        """
        tr "[:lower:]" "[:upper:]" < $inputFile > output.txt
        """
}

workflow {
    files = channel.fromPath("file.txt")
    capitalize(files)
}
