unit HashItem_u;

interface

uses CodItem_u, HashItem_i, Vcl.Controls;

type
  THashItem=class(TCodItem, IHashItem)
  private
    FDescr:string;
    function GetDescr:string;
    procedure SetDescr(const Value:string);
  protected
    function GetAsStringCSV: string;virtual;
    function GetAsCaption: TCaption;virtual;

  public
    procedure Zerar;override;

    property Descr:string read GetDescr write SetDescr;
    constructor Create(pDescr:string=''; pCod:integer=0);

    property AsStringCSV: string read GetAsStringCSV;
    property AsCaption: TCaption read GetAsCaption;
  end;

implementation

uses sysutils;

{ THashItem }

constructor THashItem.Create(pDescr: string; pCod: integer);
begin
  inherited Create(pCod);
  FDescr := pDescr
end;

function THashItem.GetAsCaption: TCaption;
begin
  result := Cod.ToString +' - ' +Descr;
end;

function THashItem.GetAsStringCSV: string;
begin
  result := Cod.ToString +';' +Descr;
end;

function THashItem.GetDescr: string;
begin
  result := FDescr;
end;

procedure THashItem.SetDescr(const Value: string);
begin
  FDescr := Value;
end;

procedure THashItem.Zerar;
begin
  inherited Zerar;
  SetDescr('');
end;

end.
