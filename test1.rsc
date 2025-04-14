{
    :global userInput do={
        :local input [:terminal ask]
        :put "$input, $a"
    }
    
    $userInput a="test"
}