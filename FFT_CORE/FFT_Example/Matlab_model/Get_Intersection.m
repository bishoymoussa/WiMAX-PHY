function c = Get_Intersection(a,b)
    k= 1;
    c = [];
    for i = 1 : length(a)
        for j = 1 : length(b)
            if(a(i)==b(j))
                m = 0;
                for z = 1 : length(c)
                    if(c(z)==a(i))
                        m = 1;
                        break;
                    end
                end
                if m == 0
                     c(k) = a(i);
                     k = k + 1;
                end
            end        
        end
    end
end