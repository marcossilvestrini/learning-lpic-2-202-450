require ["fileinto","envelope","reject","vacation"];

if allof (envelope :contains "from" "facebook", header :contains "subject" "notification")
    {
        reject "This server does not support emails of Facebook or others Social Media!!!";
        stop;
    }

if header :contains "subject" ["curriculum", "cv"]
    {
        redirect "skynet@lpic2.com.br";
        stop;
    }

if envelope :contains "from" "vagrant@lpic2.com.br"
    {
        fileinto "rule-from-vagrant";
    }

vacation
    :days 1
    :subject "Vacation Auto Reply"
    :addresses ["silvestrini@lpic2.com.br"]
"Hello

I'm on vocation

I'm back January 1st

Thank you for your patience.

Regards,

LPIC2 Employee";