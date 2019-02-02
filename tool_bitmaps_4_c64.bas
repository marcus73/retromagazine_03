    dim shared vettore(7999+2) as ubyte
    dim shared indice as integer
    
    function converti(dato as string) as integer
    
    'Conversione della sequenza di 8 bit  
    'in numero a notazione decimale
    
        dim valore as integer
        dim i as integer
        dim el as string
        
        valore=0
        
        for i=8 to 1 step-1
            el=mid$(dato,i,1)
            if el="1" then 
                valore=valore+2^(i-1)
            end if
        next
        
        return valore
        
    end function
    
    sub elabora(x as integer,y as integer)
    
    'Scansione dell'immagine alla ricerca
    'dei pixel accesi e spenti
        
        dim xx as integer
        dim yy as integer
        dim xj as integer
        dim yk as integer
        dim dato as string
        dim c as integer
        
        xx=x*8
        yy=y*8
        
        for yk=yy to yy+7
            dato=""
            for xj=xx to xx+7
                c=Point(xj,yk)
                if c=1 then
                        dato="1"+dato
                    else
                        dato="0"+dato
                end if
            next xj
            
            vettore(indice)=converti(dato)
            indice=indice+1
        next yk
    end sub

    sub salva_f
    
    'Salvataggio su disco del vettore
    'che rappresenta l'immagine
    
    dim ciclo as integer
    Open "hires.dat" For Binary As #1
        for ciclo=0 to 7999+2-1
            Put #1, ciclo+1, chr(vettore(ciclo))
        next
    Close #1
    
    end sub

    Screen 13, 32
    Cls
    BLoad "immagine.bmp"
    
    dim x as integer
    dim y as integer
    
    vettore(0)=0
    vettore(1)=32
    
    indice=2
    
    for y=0 to 24
        for x=0 to 39
            elabora(x,y)
        next x
    next y
    
    salva_f
    
    sleep