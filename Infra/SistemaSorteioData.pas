unit SistemaSorteioData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Forms,
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, UDFConexaoBancoDados, System.ImageList, Vcl.ImgList,
  Vcl.Controls, Vcl.Dialogs;

type
  TdmSistemaSorteio = class(TDataModule)
    FDManager: TFDManager;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConexao: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    qrAuxiliar: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FConexao: TConexao;
  public
    function TentarConectar: Boolean;
    procedure InserirDadosBD(const ASql: string; const AParams: array of Variant);
    function ExecutarSql(const ASql: string; const AOpen: Boolean): TFDQuery;
    function ObterMax(const Tabela, Campo: string): Integer;
  end;

var
  dmSistemaSorteio: TdmSistemaSorteio;

implementation

uses
  UDFScripts;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmSistemaSorteio.DataModuleCreate(Sender: TObject);
begin
  try
    Self.FConexao := TConexao.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
    Self.FDPhysFBDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
    Self.FConexao.ConfigurarParametros(FDConexao);
    Self.FDConexao.Connected := True;

    UDFScripts.CriarEstruturaBanco;
  except
    on E: Exception do
      ShowMessage('Erro fatal na inicialização do banco: ' + E.Message);
  end;
end;

function TdmSistemaSorteio.TentarConectar: Boolean;
begin
  Result := False;
  Self.FDPhysFBDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';

  if Self.FConexao = nil then
    Self.FConexao := TConexao.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
  Self.FConexao.LerINI;
  if (Self.FConexao.Database = '') or (not FileExists(Self.FConexao.Database)) then
    Exit;
  try
    Self.FConexao.ConfigurarParametros(FDConexao);
    Self.FDConexao.Connected := True;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TdmSistemaSorteio.InserirDadosBD(const ASql: string; const AParams: array of Variant);
var
  qrInserir: TFDQuery;
  LIndice: Integer;
begin
  qrInserir := TFDQuery.Create(nil);
  try
    qrInserir.Connection := FDConexao;
    qrInserir.SQL.Text := ASql;

    for LIndice := Low(AParams) to High(AParams) do
    begin
      qrInserir.Params[LIndice].Value := AParams[LIndice];
    end;

    qrInserir.ExecSQL;
  finally
    qrInserir.Free;
  end;
end;

function TdmSistemaSorteio.ExecutarSql(const ASql: string; const AOpen: Boolean): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := FDConexao;
    Result.SQL.Text := ASql;

    if AOpen then
      Result.Open
    else
      Result.ExecSQL;
  except
    Result.Free;
    raise;
  end;
end;

function TdmSistemaSorteio.ObterMax(const Tabela, Campo: string): Integer;
var
  qrMax: TFDQuery;
begin
  qrMax := ExecutarSql('SELECT COALESCE(MAX(' + Campo + '), 0) AS MAXTABELA FROM ' + Tabela, True);
  try
    Result := qrMax.FieldByName('MAXTABELA').AsInteger;
  finally
    qrMax.Free;
  end;
end;

end.
