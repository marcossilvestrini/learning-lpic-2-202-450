ConvertTo-SecureString -String 'EncryptMe' -AsPlainText -Force

function Test {
    [CmdletBinding]
    Param
    (
        $ErrorVariable,
        $Parameter2
    )
}