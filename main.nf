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
        ls > output.txt
        """
}

workflow {
    files = Channel.fromPath(params.sourceDir + "file.txt")
    capitalize(files)
}
