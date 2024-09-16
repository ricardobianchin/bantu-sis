unit Crypt1Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Sis.Types.strings.Crypt_u;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    procedure Processe;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

//procedure Encriptar(pCryVer: integer; pStr: string; out pEncriptado: string);
//procedure Desencriptar(pCryVer: integer; pEncriptado: string; out pStr: string);

procedure TForm2.Button1Click(Sender: TObject);
var
  s: string;
begin
  Encriptar(1, Edit1.Text, s);
  Edit2.Text := s;
  Desencriptar(1, Edit2.Text, s);
  Edit3.Text := s;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  Processe;
end;

procedure TForm2.Processe;
var
  s: string;
begin
  Encriptar(1, Edit1.Text, s);
  Edit2.Text := s;
  Desencriptar(1, Edit2.Text, s);
  Edit3.Text := s;
end;

end.
