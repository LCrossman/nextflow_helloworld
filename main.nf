#!/usr/bin/env nextflow

params.input = 'input.txt'
params.outputDir = 'output'
params.outputFile = "${params.outputDir}/word_count.txt"

// Create the output directory if it doesn't exist
def outputDir = file(params.outputDir)
outputDir.mkdirs()

inputFileChannel = Channel.fromPath(params.input)

process countWords {
    input:
    path inputFileChannel

    output:
    path 'word_count.txt'

    script:
    """
    wc -w $inputFileChannel > word_count.txt
    """
}

workflow {
    countWords(inputFileChannel).view { outputFile -> 
       def outputFilePath = file(params.outputFile)
       outputFile.moveTo(outputFilePath)
       }   
}
