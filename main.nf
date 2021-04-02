#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process capitalize {

    container "ubuntu:latest"
    cpus 1
    memory '512 MB'
    
    publishDir params.publishDir
    
    input:
        path inputFile
        
    output:
        path 'output.txt'

    script:
        """
        echo 'asdf' > output.txt
        """
}

workflow {
    files = Channel.fromPath(params.sourceDir + "/file.txt")
    capitalize(files)
}
