unit Sis.DB.SqlCreator;

interface

type
  ISqlCreator = interface(IInterface)
    ['{72D87AF8-13ED-48AE-9AD0-1754DC1E7863}']
    function GetSqlText: string;
    procedure SetSqlText(const Value: string);

    function ParamSetStr(pNomeParam: string; pValor: string): ISqlCreator;
    function ParamSetInt(pNomeParam: string; pValor: Int64): ISqlCreator;
    function ParamSetBool(pNomeParam: string; pValor: Boolean): ISqlCreator;

    function ParamSetData(pNomeParam: string; pValor: TDateTime): ISqlCreator;
    function ParamSetDataHora(pNomeParam: string; pValor: TDateTime): ISqlCreator;

    property SqlText: string read GetSqlText write SetSqlText;
  end;

implementation

end.
