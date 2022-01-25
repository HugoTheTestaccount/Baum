unit Unit2;

{$mode objfpc}{$H+}

interface
  uses
  Classes, SysUtils,Forms,Graphics,FileUtil,Dialogs,Controls,ExtCtrls;
  {TYPE AusgabeWClass = class
  AUsgabeW:Extended;
  end;}
  Type TBrokkoli = class
  element:Extended;
  lub:TBrokkoli;
  rub:TBrokkoli;
  //index:Extended;
end;
  TYPE TBaum = class
  Procedure einfuegen(e:EXtended);
  procedure entf(b:TBrokkoli);
  procedure entfernen(K:Extended);
  function vor(l:Extended):Extended;
  function zurueck(K:Extended):Extended;
  function suchen(K:Extended):TBrokkoli;
  procedure showbaum(im:TImage);
  constructor create;
end;
Var
  AusgabeW:String;

implementation




Type TMyBaum=class(TBaum)

  we:TBrokkoli;
  current:TBrokkoli;
  constructor create;
end;
constructor TMyBaum.create;
begin
  we:=TBrokkoli.create;
  we:=NIL;
end;
constructor TBaum.create;
begin
  self:=TMyBaum.create;
end;
procedure TBaum.einfuegen(e:Extended);
   procedure einf(VAR b:TBrokkoli);
   begin
     IF b=NIL THEN
     begin
        b:=TBrokkoli.create;
        b.element:=e;
        b.lub:=NIL;
        b.rub:=NIL;
     end
     else IF b.element>e THEN einf(b.lub) ELSE IF b.element<e Then einf(b.rub);
   end;
begin
  with TMyBaum(self) do
  begin
  einf(we)

  end;
end;
function TBaum.suchen(K:Extended):TBrokkoli;
VAR notaknot:TBrokkoli; cnt:cardinal;
    function such(n:Tbrokkoli;K:Extended):TBrokkoli;
    begin
      if (K=TMyBaum(self).we.element) then
      begin
         result:=TMyBaum(self).we;
         ausgabeW:='mitte';
         cnt:=0
      end;
      if not((n.rub=NIL) and (n.lub=NIL)) then  //Überprüfen, ob wir am ende angekommen sind, wenn ja
         begin
           cnt:=0;
           if (n.rub<>NIL) then      //wenn es ein rechtes child hat
           begin
                if (K=n.rub.element)then      //und dieses child das gesuchte element
                begin
                     result:=n;                //gib den parent aus
                     cnt:=0;
                     AusgabeW:='rechts';
                end
                else if (result<>n) then
                begin cnt:=1;
                end;

           end;

           If (n.lub<>NIL) then
           begin                           //das gleiche mit links
                if (K=n.lub.element) then
                begin
                     result:= n;
                      cnt:=0;
                      AusgabeW:='links';
                end
                else if (result<>n) then
                begin cnt:=1;
                end;
           end;
      {else                            // das gesuchte element gibt es nicht
        begin                              // stranger output
             {notaknot:=TBrokkoli.create;
             notaknot.element:=69696969696969;
             result:=notaknot;
             //AusgabeW:=notaknot.element;}
             end;}
        if cnt=1 then                        //es hat einen Unterbaum, also jetzt
        begin                             //in dem entsprechenden suchen
             if (K<n.element) then
             begin
                  result:=such(n.lub,K)
             end

             else if (K>n.element) then
             begin
                  result:=such(n.rub,K)
             end;
        end;
        end


        end;
begin
with TMyBaum(self) do
begin
     result:=(such(we,K))
end;
end;

procedure TBaum.entf(b:TBrokkoli);
VAR mew:TBrokkoli; a:Extended; mew2:TBrokkoli;
  function mini (r:TBrokkoli):TBrokkoli;
  begin
       if (r.lub<>NIL) then
       begin
            result:=mini(r.lub);
       end
       else
       begin
         result:=r;
         a:=r.element;
       end
  end;

begin
if (ausgabeW='mitte') then
begin
     if b.rub<>NIL then
     begin
          mew:=TBrokkoli.create;
      mew:=(mini(b.rub));//das mini des rehcten Unterbaums, und das element davon
      //entfernen(mew.element);
      TMyBaum(self).we.element:=mini(b.rub).element;

     end
     else if (b.lub<>NIl) and (b.rub=NIL) then
     begin
          TMyBaum(self).we:=b.lub;
     end
     else
     begin
          b:=NIL;
          TMyBaum(self).we:=NIL;
     end;

     end;
if (ausgabeW='rechts') then                                           //großes überprüfen, ob das zu entf. elem. das rechte child ist, wenn ja
begin                                                                           //(entfernen eines Elements mit keinem Child)
  If (b.rub.lub=NIL) and (b.rub.rub=NIL) THen                   //gucken ob das zu entf. elem keinen child hat
  begin
     b.rub:=NIL;                                               //wenn ja, dann einfach die "Verindung" zw. Parent und zu entf. elem. kappen
  end
                                                                                //(entfernung eines Elements mit einem child)
  else if (b.rub.rub<>NIL) and (b.rub.lub=NIL) THEN                               //überprüfen, ob es einen rechten Unterbaum hat ((um es hinreichend zu machen, überprüfen,
  begin                                                         //ob es zusätzlich noch kein linkes hat))
   b.rub:=b.rub.rub;                                              //wenn es nur den rechten Unterbaum hat, dann wird einfach der angehangene Baum des zu entf. elem.
  end                                                              // das neue child des parents

  else if (b.rub.lub<>NIL) and (b.rub.rub=NIL) then                                       //das gleiche, wenn das zu entf. elem. nur einen linken unterbaum hat
  begin
  b.rub:=b.rub.lub;
  end

   else if (b.rub.lub<>NIL) and (b.rub.rub<>NIL) then                          //(enfternen bei zwei childs)
   begin
        mew:=TBrokkoli.create;
        mew:=(mini(b.rub.rub));//das mini des rehcten Unterbaums, und das element davon
        entfernen(mew.element);
        //b.lub.element:= mew.element;
        b.rub.element:=a;                   //in den zu entf. knoten packen; mini entfernen
     end
  end
                                                                     //das ganze jetzt nochmal, wenn das zu entf. elem. das linke child ist
else if (ausgabeW='links') then
  begin
  If (b.lub.lub=NIL) and (b.lub.rub=NIL) THen
  begin
     b.lub:=NIL;

  end

  else if (b.lub.rub<>NIL) and (b.lub.lub=NIL) THEN
  begin
  b.lub:=b.lub.rub;
  end
  else if (b.lub.rub=NIL) and (b.lub.rub=NIL) then
  begin
  b.lub:=b.lub.lub;
  end

  else if (b.lub.lub<>NIL) and (b.lub.rub<>NIL) then                          //(enfternen bei zwei childs)
   begin
        mew:=TBrokkoli.create;
        mew:=(mini(b.lub.rub));//das mini des rehcten Unterbaums, und das element davon
        entfernen(mew.element);
        //b.lub.element:= mew.element;
        b.lub.element:=a;
                          //in den zu entf. knoten packen; mini entfernen
     end;



 end
end;
procedure TBaum.entfernen(K:Extended);
begin
  entf(suchen(K))
end;
function weiter(P:TBrokkoli):Extended;
function mini (r:TBrokkoli):TBrokkoli;
  begin
       if (r.lub<>NIL) then
       begin
            result:=mini(r.lub);
       end
       else
       begin
         result:=r;
       end
  end;
begin
if (ausgabeW = 'rechts') then
begin
  Result:=(mini(P.rub.rub)).element

  end
else if (ausgabeW = 'links') then
begin
  Result:=(mini(P.lub.rub)).element

  end
else
  result:=(mini(P.rub).element)
end;

function TBaum.vor(l:Extended):Extended;
begin
     result := weiter(suchen(l))
end;

function TBaum.zurueck(K:Extended):Extended;
begin
     result:=(suchen(K).element)
end;

{
var mew:TBrokkoli;
begin
  with TmyBaum(self) do
  begin
    if we.element=69696969 then
       begin
       we.element:=e;
       current:=we;
       end
    else
        begin
        if c=0 then
           begin
           current:=we
           end;

    if (e<current.element) then
       begin
       if (current.lub=current) then
          begin
          mew:=TBrokkoli.create;
          mew.element:=e;
          mew.lub:=mew;
          mew.rub:=mew;
          current.lub:=mew;
          end
            else
                begin
                current:=current.lub;
                einf(e,1)
                end;

       end
    else if (e>current.element) then
         begin
         if (current.rub=current) then
            begin
            mew:=TBrokkoli.create;
            mew.element:=e;
            mew.lub:=mew;
            mew.rub:=mew;
            current.rub:=mew;
            end
         else
             begin
             current:=current.rub;
             einf(e,1)
             end;

         end;
         end;
  end;
end; }
procedure Tbaum.ShowBaum(im:TImage);
   procedure zeich (b:TBrokkoli; posx, dx, posy:Integer);
   VAR s:String;
   begin
      IF b<>NIL THEN
      BEGIN
         {CASE b^.last OF
           rechts: s:='R';
           gleich: s:='G';
           links:  s:='L'}

     //With TMyBaum(b) do
     //Begin
         im.Canvas.TextOut(posx,posy,FloatToStr(b.element));
         im.Canvas.MoveTo(posx,posy+12);
         im.Canvas.LineTo(posx-dx,posy+40);
         im.Canvas.MoveTo (posx,posy+12);
         im.Canvas.LineTo (posx+dx,posy+40);
         zeich (b.lub, posx-dx,dx div 2, posy+40);
         zeich (b.rub, posx+dx, dx div 2, posy+40)
      END;
   end;
begin
   WITH TMyBaum (self) DO
   BEGIN
      im.canvas.Rectangle(0,0,im.Width,im.Height);
      zeich (we, im.width div 2, im.width div 4, 5);
   END;
end;
end.
