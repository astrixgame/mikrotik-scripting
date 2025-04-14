{
    :global userInput do={
        :local input [:terminal ask]
        :put "$input, $arg1"
    }
    
    $userInput "test123"
}