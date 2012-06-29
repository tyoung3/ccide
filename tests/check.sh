
Check() {
        ./hello  && Success ./hello || Fail ./hello
        TestHello > /tmp/check.out 2>/tmp/check.err && ShowBal >/tmp/ShowBal.out 2>/tmp/ShowBal.err && echo $* TestHello checks OK! &
        for  NDL in test*.ndl; do
                echo -n Testing ${NDL}: 
                ../dfd -g0 <$NDL 2>/dev/null >/dev/null && Success $NDL || Fail $NDL
        done
        for  NDL in fail*.ndl; do
                echo -n Testing ${NDL}: 
                ../dfd -g0 <$NDL 2>/dev/null >/dev/null && Fail $NDL || Success $NDL
        done
        
        Summarize
        
}

