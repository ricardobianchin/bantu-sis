unit App.UI.Controls.ComboBox.Select.DB.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.ComboBox.Select.Frame_u,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, Sis.UI.IO.Output, App.Ent.DBI;

type
  TComboBoxSelectDBFrame = class(TComboBoxSelectBasFrame)
  private
    { Private declarations }
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FErroOutput: IOutput;

    function GetEntEd: IEntEd;
    function GetErroOutput: IOutput;
  protected
    property EntEd: IEntEd read GetEntEd;
    property ErroOutput: IOutput read GetErroOutput;
  public
    { Public declarations }
  constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pErroOutput: IOutput); reintroduce;
  end;

var
  ComboBoxSelectDBFrame: TComboBoxSelectDBFrame;

implementation

{$R *.dfm}

{ TComboBoxSelectDBFrame }

constructor TComboBoxSelectDBFrame.Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI;
  pErroOutput: IOutput);
begin
  inherited Create(AOwner);
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
  FErroOutput := pErroOutput;
end;

function TComboBoxSelectDBFrame.GetEntEd: IEntEd;
begin
  Result := FEntEd;
end;

function TComboBoxSelectDBFrame.GetErroOutput: IOutput;
begin
  Result := FErroOutput;
end;

end.
