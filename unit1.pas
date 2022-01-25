unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,Unit2,LCLTYPE;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InputKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  Form1: TForm1;
  Baum: TBaum;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Baum.einfuegen(StrToFloat(Edit1.Text));
  Baum.Showbaum(Image1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Baum.entfernen(StrToFloat(Edit1.Text));
  Baum.Showbaum(Image1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //Edit1.Text:=FloatToStr(AusgabeW)
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Label1.caption:= FloatToStr(Baum.vor(StrToFloat(Edit1.Text)));

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Label1.caption:= FloatToStr(Baum.zurueck(StrToFloat(Edit1.Text)));
end;

procedure TForm1.InputKeyPress(Sender: TObject; var Key: char);
begin
  if (key = #13) then Baum.einfuegen(StrToFloat(Edit1.Text));
  Baum.Showbaum(Image1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Baum:=TBaum.create;

end;

end.

