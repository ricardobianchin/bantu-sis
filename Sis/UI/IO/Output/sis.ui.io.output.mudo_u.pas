unit Sis.UI.IO.Output.Mudo_u;

interface

uses Sis.UI.IO.Output, Vcl.Dialogs;

type
  TMudoOutput = class(TInterfacedObject, IOutput)
  private

//    function GetEnabled: boolean;
//    procedure SetEnabled(Value: boolean);
    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
//    property Enabled: boolean read GetEnabled write SetEnabled;
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);

    property Ativo: boolean read GetAtivo write SetAtivo;

  end;


implementation

{ TMudoOutput }

procedure TMudoOutput.Exibir(pFrase: string);
begin

end;

procedure TMudoOutput.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin

end;

function TMudoOutput.GetAtivo: boolean;
begin
  Result := True;
end;

procedure TMudoOutput.SetAtivo(Value: boolean);
begin

end;

{
  function TMudoOutput.GetEnabled: boolean;
  begin
    result := false;
  end;

  procedure TMudoOutput.SetEnabled(Value: boolean);
  begin

  end;

}
end.
