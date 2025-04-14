{
    :global userInput do={
        :local input [:terminal ask]
        :put "$input, $a1"
    }
    
    $userInput a1="test123"
}