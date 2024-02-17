unit App.UI.Decorator.Form.Excl_u;

interface

uses App.UI.Decorator.Form.Excl;

type
  TDecoratorExcl = class(TInterfacedObject, IDecoratorExcl)
  private
  public
    procedure FormShow(Sender: TObject);
    function GetCaption: string;
    function GetNome: string; virtual; abstract;
    function GetValues: string; virtual; abstract;
    function GetPergunta: string;

  end;

implementation

uses System.SysUtils;

{ TDecoratorExcl }

procedure TDecoratorExcl.FormShow(Sender: TObject);
begin

end;

function TDecoratorExcl.GetCaption: string;
var
  sCaption: string;
begin
  sCaption := 'Excluir ' + GetNome;
  Result := sCaption;
end;

function TDecoratorExcl.GetPergunta: string;
var
  sFormat: string;
begin
  sFormat := 'Deseja excluir ''%s''?';
  Result := Format(sFormat, [GetValues]);
end;

end.
