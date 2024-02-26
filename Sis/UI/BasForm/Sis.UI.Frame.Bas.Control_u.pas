unit Sis.UI.Frame.Bas.Control_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u;

type
  TControlBasFrame = class(TBasFrame)
  private
    { Private declarations }
  protected
    procedure SetValue(const Value: variant); virtual;
    function GetValue: variant; virtual;

    function GetAsString: string; virtual;
    function GetAsStringSQL: string; virtual;
    function GetAsInteger: integer; virtual;
    function GetAsSmallInt: smallint; virtual;

    property Value: variant read GetValue write SetValue;

    property AsString: string read GetAsString;
    property AsStringSQL: string read GetAsStringSQL;
    property AsInteger: integer read GetAsInteger;
    property AsSmallInt: smallint read GetAsSmallInt;
  public
    { Public declarations }
  end;

var
  ControlBasFrame: TControlBasFrame;

implementation

{$R *.dfm}

uses Sis.Types.Integers, Sis.Types.strings_u;

{ TControlBasFrame }

function TControlBasFrame.GetAsInteger: integer;
begin
  Result := VarToInteger(GetValue);
end;

function TControlBasFrame.GetAsSmallInt: smallint;
begin
  Result := SmallInt(GetAsInteger);
end;

function TControlBasFrame.GetAsString: string;
begin
  Result := VarToString(GetValue);
end;

function TControlBasFrame.GetAsStringSQL: string;
begin
  Result := GetAsString;
end;

function TControlBasFrame.GetValue: variant;
begin
  Result := '';
end;

procedure TControlBasFrame.SetValue(const Value: variant);
begin

end;

end.
