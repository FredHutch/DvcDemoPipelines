#!/usr/bin/env nextflow
nextflow.enable.dsl=2

import groovy.json.JsonSlurper
def jsonSlurper = new JsonSlurper()
def config = jsonSlurper.parseText(new File("${params.wfconfig}").text)

process count {

    publishDir "$config.dataset.s3path"

    input:
      path x
    
    output:
      path "count.txt"

    script: 
        """
        grep -o -i $config.dataset.parameters.word $x | wc -l > count.txt
        """
}

process capitalize {

    publishDir "$config.dataset.s3path"

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