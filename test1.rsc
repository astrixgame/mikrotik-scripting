{
    :global userInput do={
        :local input [:terminal ask]
        :put "$input, $1"
    }
    
    $userInput "test123"
}