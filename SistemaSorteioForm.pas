unit SistemaSorteioForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ComCtrls, Vcl.StdCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.WinXPanels,
  System.Generics.Collections;

type
  TfmSistemaSorteio = class(TForm)
    paSuperior: TPanel;
    paGrid: TPanel;
    grDadosCadastrados: TDBGrid;
    paInferior: TPanel;
    qrClientes: TFDQuery;
    qrVendas: TFDQuery;
    qrCarros: TFDQuery;
    cbTipoFiltros: TComboBox;
    caFiltros: TCardPanel;
    tsVendas: TCard;
    lbTipoFiltro: TLabel;
    btCadastrarClientes: TButton;
    btCadastrarCarros: TButton;
    btExcluirVendas: TButton;
    Label1: TLabel;
    edClientesVendas: TEdit;
    cbModelosVendas: TComboBox;
    Label2: TLabel;
    tsCliente: TCard;
    Label3: TLabel;
    edClientes: TEdit;
    tsCarros: TCard;
    lbModelos: TLabel;
    cbModelos: TComboBox;
    btLocalizar: TButton;
    lbClientesSemVenda: TLabel;
    lbTitulo: TLabel;
    tsSorteio: TCard;
    btInserirVendas: TButton;
    dsGrid: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbTipoFiltrosChange(Sender: TObject);
    procedure btCadastrarClientesClick(Sender: TObject);
    procedure btInserirVendasClick(Sender: TObject);
    procedure btCadastrarCarrosClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure btExcluirVendasClick(Sender: TObject);
    procedure cbModelosChange(Sender: TObject);
    procedure cbModelosVendasChange(Sender: TObject);
    procedure grDadosCadastradosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FSQLClientesSemVenda: String;

    function ExibirConfiguracao: Boolean;
    procedure RedimensionarPaineis;
    procedure AjustarColunas(DBGrid: TDBGrid);
    procedure AtualizarQuantidadeClientesSemVenda;
    procedure ConfigurarColunasVisiveis(AGrid: TDBGrid; AColunasVisiveis: TList<Integer>);
    procedure SomarVendas(AVendas: TFDQuery);
  end;

var
  fmSistemaSorteio: TfmSistemaSorteio;

implementation

uses
  ConexaoBancoDadosForm,
  UDFConexaoBancoDados,
  SistemaSorteioData,
  UDFUtils,
  ClienteService,
  CarroService,
  VendasService,
  UDFConstantes,
  SorteioService,
  Math;

{$R *.dfm}

procedure TfmSistemaSorteio.FormCreate(Sender: TObject);
begin
  if not dmSistemaSorteio.TentarConectar then
  begin
    MessageDlg('Conexão não encontrada ou banco de dados inválido.' + #13 +
      'Por favor, configure os dados de acesso.', mtInformation, [mbOK], 0);

    if not ExibirConfiguracao then
    begin
      Application.Terminate;
      Exit;
    end;
  end;
end;

procedure TfmSistemaSorteio.FormResize(Sender: TObject);
begin
  Self.RedimensionarPaineis;
end;

procedure TfmSistemaSorteio.FormShow(Sender: TObject);
var
  LIndice: Integer;
begin
  Self.RedimensionarPaineis;

  qrClientes.Connection := dmSistemaSorteio.FDConexao;
  qrVendas.Connection := dmSistemaSorteio.FDConexao;
  qrCarros.Connection := dmSistemaSorteio.FDConexao;

  Self.FSQLClientesSemVenda := 'SELECT COUNT(*) AS QTD FROM CLIENTE C LEFT JOIN VENDA V ON V.IDCLIENTE = C.IDCLIENTE WHERE V.IDVENDA IS NULL';

  cbModelosVendas.Items.Clear;
  cbModelos.Items.Clear;

  for LIndice := Low(MODELOSCARROS) to High(MODELOSCARROS) do
  begin
    cbModelosVendas.Items.Add(MODELOSCARROS[LIndice]);
    cbModelos.Items.Add(MODELOSCARROS[LIndice]);
  end;

  cbModelosVendas.Items.Add('Selecione...');
  cbModelos.Items.Add('Selecione...');

  cbTipoFiltrosChange(cbTipoFiltros);

  cbModelosVendas.ItemIndex := 0;
  cbModelos.ItemIndex := 0;
  Self.btLocalizarClick(Self.btLocalizar);
end;

procedure TfmSistemaSorteio.grDadosCadastradosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'CPFCNPJ' then
  begin
    grDadosCadastrados.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
      UDFUtils.FormatarDocumento(Column.Field.AsString));
  end
  else
    grDadosCadastrados.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
procedure TfmSistemaSorteio.RedimensionarPaineis;
begin
  paSuperior.Height := (Trunc(Self.Height / 4) - 10);
  lbTitulo.Top := paGrid.Top - 24;
  lbTitulo.Left := 8;
  Self.AjustarColunas(Self.grDadosCadastrados);
end;

procedure TfmSistemaSorteio.btCadastrarCarrosClick(Sender: TObject);
var
  LCarroService: TCarroService;
begin
  LCarroService := TCarroService.Create;
  try
    LCarroService.InserirCarrosPadrao;
    qrCarros.Close;
    qrCarros.Open;
    MessageDlg('Carros foram cadastrados automaticamente com sucesso!', mtInformation, [mbOK], 0);
    Self.btLocalizarClick(Self.btLocalizar);
  finally
    LCarroService.Free;
  end;
end;

procedure TfmSistemaSorteio.btCadastrarClientesClick(Sender: TObject);
var
  LClienteService: TClienteService;
begin
  LClienteService := TClienteService.Create;
  try
    LClienteService.InserirClientesAutomaticos;
    Self.AtualizarQuantidadeClientesSemVenda;
    MessageDlg('Clientes foram cadastrados automaticamente com sucesso!', mtInformation, [mbOK], 0);
    Self.btLocalizarClick(Self.btLocalizar);
  finally
    LClienteService.Free;
  end;
end;

procedure TfmSistemaSorteio.btInserirVendasClick(Sender: TObject);
var
  LVendasService: TVendasService;
begin
  LVendasService := TVendasService.Create;
  try
    LVendasService.InserirVendas;
    MessageDlg('Vendas foram feitas com sucesso!', mtInformation, [mbOK], 0);
    Self.AtualizarQuantidadeClientesSemVenda;
    Self.btLocalizarClick(Self.btLocalizar);
  finally
    LVendasService.Free;
  end;
end;

procedure TfmSistemaSorteio.btLocalizarClick(Sender: TObject);
var
  LSQL: string;
  LSorteioService: TSorteioService;
  LExibirTotalVendasModelo: Boolean;
begin
  LSorteioService := TSorteioService.Create;
  LExibirTotalVendasModelo := False;
  try
    case cbTipoFiltros.ItemIndex of
      0:
        begin
          dsGrid.DataSet := qrCarros;
          if cbModelos.ItemIndex = 5 then
          begin
            LSQL := 'SELECT CA.MODELO, COUNT(V.IDVENDA) AS QTDEVENDAS, CA.DATALANCAMENTO ' +
              'FROM CARRO CA LEFT JOIN VENDA V ON V.IDCARRO = CA.IDCARRO ' +
              'GROUP BY CA.MODELO, CA.DATALANCAMENTO';
            qrCarros.SQL.Text := LSQL;
          end
          else
          begin
            LSQL := 'SELECT CA.MODELO, COUNT(V.IDVENDA) AS QTDEVENDAS, CA.DATALANCAMENTO ' +
              'FROM CARRO CA LEFT JOIN VENDA V ON V.IDCARRO = CA.IDCARRO ' +
              'WHERE CA.MODELO = :MODELO ' +
              'GROUP BY CA.MODELO, CA.DATALANCAMENTO';
            qrCarros.SQL.Text := LSQL;
            qrCarros.ParamByName('MODELO').AsString := cbModelos.Text;
          end;
          qrCarros.Close;
          qrCarros.Open;
        end;
      1:
        begin
          dsGrid.DataSet := qrClientes;
          if length(edClientes.Text) = 0 then
          begin
            LSQL := 'SELECT NOME, CPFCNPJ, DATACADASTRO FROM CLIENTE';
            qrClientes.SQL.Text := LSQL;
          end
          else
          begin
            LSQL := 'SELECT NOME, CPFCNPJ, DATACADASTRO FROM CLIENTE WHERE UPPER(NOME) LIKE UPPER(:PESQUISA)';
            qrClientes.SQL.Text := LSQL;
            qrClientes.ParamByName('PESQUISA').AsString := '%' + edClientes.Text + '%';
          end;
          qrClientes.Close;
          qrClientes.Open;
        end;
      2:
        begin
          dsGrid.DataSet := qrVendas;

          LSQL := 'SELECT C.IDCLIENTE, C.NOME, CA.MODELO, COUNT(V.IDVENDA) AS QTDEVENDAS ' +
            'FROM CLIENTE C JOIN VENDA V ON V.IDCLIENTE = C.IDCLIENTE ' +
            'JOIN CARRO CA ON CA.IDCARRO = V.IDCARRO WHERE 1 = 1 ';

          if Trim(edClientesVendas.Text) <> '' then
            LSQL := LSQL + ' AND UPPER(C.NOME) LIKE :NOME ';

          if (cbModelosVendas.ItemIndex <> 5) and (cbModelosVendas.ItemIndex <> -1) then
            LSQL := LSQL + ' AND UPPER(CA.MODELO) LIKE :MODELO ';

          LSQL := LSQL + ' GROUP BY C.IDCLIENTE, C.NOME, CA.MODELO ORDER BY C.NOME, CA.MODELO';

          qrVendas.Close;
          qrVendas.SQL.Text := LSQL;

          if Trim(edClientesVendas.Text) <> '' then
            qrVendas.ParamByName('NOME').AsString := '%' + UpperCase(edClientesVendas.Text) + '%';

          if (cbModelosVendas.ItemIndex <> 5) and (cbModelosVendas.ItemIndex <> -1) then
          begin
            qrVendas.ParamByName('MODELO').AsString := '%' + UpperCase(cbModelosVendas.Text) + '%';
            LExibirTotalVendasModelo := True;
          end
          else
            LExibirTotalVendasModelo := False;

          qrVendas.Open;

          if LExibirTotalVendasModelo then
           Self.SomarVendas(qrVendas)
          else
            lbTitulo.Caption := 'Resumo por vendas:';
        end;
      3:
        begin
          btLocalizar.Caption := 'Sortear';
          dmSistemaSorteio.qrAuxiliar := LSorteioService.ExecutarSorteio;
          dsGrid.DataSet := dmSistemaSorteio.qrAuxiliar;
          dmSistemaSorteio.qrAuxiliar.Open;
        end;
    end;
    Self.AtualizarQuantidadeClientesSemVenda;
  finally
    LSorteioService.Free;
  end;
end;

procedure TfmSistemaSorteio.SomarVendas(AVendas: TFDQuery);
var
  LTotalVendas: Integer;
begin
  lbTitulo.Caption := 'Resumo por vendas - ';
  LTotalVendas := 0;
  if AVendas.Eof then
  begin
    LTotalVendas := 0;
    exit;
  end;

  AVendas.First;

  while not AVendas.Eof do
  begin
    LTotalVendas := LTotalVendas + AVendas.FieldByName('QTDEVENDAS').AsInteger;
    AVendas.Next;
  end;
  if LTotalVendas = 0 then
    lbTitulo.Caption := lbTitulo.Caption + 'Nenhum modelo foi vendido.'
  else
    lbTitulo.Caption := lbTitulo.Caption + IntToStr(LTotalVendas) + ' veículos deste modelos foram vendidos.'
end;

procedure TfmSistemaSorteio.btExcluirVendasClick(Sender: TObject);
var
  LSorteioService: TSorteioService;
begin
  LSorteioService := TSorteioService.Create;
  try
    LSorteioService.ExcluirVendasNaoSorteadas;
    MessageDlg('Vendas não sorteadas foram excluídas!', mtInformation, [mbOK], 0);
    Self.AtualizarQuantidadeClientesSemVenda;
  finally
    LSorteioService.Free;
  end;
end;

procedure TfmSistemaSorteio.AtualizarQuantidadeClientesSemVenda;
var
  qrClientesSemVendas: TFDQuery;
begin
  qrClientesSemVendas := TFDQuery.Create(nil);
  try
    qrClientesSemVendas := dmSistemaSorteio.ExecutarSql(Self.FSQLClientesSemVenda, True);
    lbClientesSemVenda.Caption := qrClientesSemVendas.FieldByName('QTD').AsString + ' clientes cadastrados não efetuaram nenhuma venda.'
  finally
    qrClientesSemVendas.Free;
  end;
end;

procedure TfmSistemaSorteio.cbModelosChange(Sender: TObject);
begin
  Self.btLocalizarClick(Self.btLocalizar);
end;

procedure TfmSistemaSorteio.cbModelosVendasChange(Sender: TObject);
begin
  Self.btLocalizarClick(Self.btLocalizar);
end;

procedure TfmSistemaSorteio.cbTipoFiltrosChange(Sender: TObject);
var
  LColunas: TList<Integer>;
begin
  LColunas := TList<Integer>.Create;
  try
    case cbTipoFiltros.ItemIndex of
      0: // Carros
        begin
          caFiltros.ActiveCard := tsCarros;
          lbTitulo.Caption := 'Resumo por modelo de carro:';

          grDadosCadastrados.Columns[2].FieldName := 'MODELO';
          grDadosCadastrados.Columns[3].FieldName := 'DATALANCAMENTO';
          grDadosCadastrados.Columns[6].FieldName := 'QTDEVENDAS';

          LColunas.AddRange([2, 3, 6]);
          Self.btLocalizarClick(Self.btLocalizar);
        end;

      1: // Clientes
        begin
          caFiltros.ActiveCard := tsCliente;
          lbTitulo.Caption := 'Resumo por clientes:';

          grDadosCadastrados.Columns[0].FieldName := 'NOME';
          grDadosCadastrados.Columns[1].FieldName := 'CPFCNPJ';

          LColunas.AddRange([0, 1]);
          Self.btLocalizarClick(Self.btLocalizar);
        end;

      2: // Vendas
        begin
          caFiltros.ActiveCard := tsVendas;
          lbTitulo.Caption := 'Resumo por vendas - ';

          grDadosCadastrados.Columns[0].FieldName := 'NOME';
          grDadosCadastrados.Columns[2].FieldName := 'MODELO';
          grDadosCadastrados.Columns[6].FieldName := 'QTDEVENDAS';

          LColunas.AddRange([0, 2, 6]);
          Self.btLocalizarClick(Self.btLocalizar);
        end;

      3: // Sorteio
        begin
          caFiltros.ActiveCard := tsSorteio;
          lbTitulo.Caption := 'Lista de sorteados do concurso Taif:';

          grDadosCadastrados.Columns[0].FieldName := 'NOME';
          grDadosCadastrados.Columns[1].FieldName := 'CPFCNPJ';
          grDadosCadastrados.Columns[3].FieldName := 'DATALANCAMENTO';

          LColunas.AddRange([0, 1, 3]);
          Self.btLocalizarClick(Self.btLocalizar);
        end;
    end;

    ConfigurarColunasVisiveis(grDadosCadastrados, LColunas);
    Self.AtualizarQuantidadeClientesSemVenda;

    if cbTipoFiltros.ItemIndex = 3 then
      btLocalizar.Caption := 'Sortear'
    else
      btLocalizar.Caption := 'Localizar';
  finally
    LColunas.Free;
  end;
end;

function TfmSistemaSorteio.ExibirConfiguracao: Boolean;
var
  LConfiguracao: TfmConexaoBancoDados;
begin
  Result := False;
  LConfiguracao := TfmConexaoBancoDados.Create(Self);
  try
    if LConfiguracao.ShowModal = mrOk then
    begin
      Result := dmSistemaSorteio.TentarConectar;
    end;
  finally
    LConfiguracao.Free;
  end;
end;

procedure TfmSistemaSorteio.AjustarColunas(DBGrid: TDBGrid);
var
  LIndice: Integer;
  LLargura: Integer;
begin
  if DBGrid.Columns.Count = 0 then
    Exit;

  LLargura := DBGrid.ClientWidth;

  if dgIndicator in DBGrid.Options then
    Dec(LLargura, 20);

  for LIndice := 0 to DBGrid.Columns.Count - 1 do
    DBGrid.Columns[LIndice].Width := LLargura div DBGrid.Columns.Count;
end;

procedure TfmSistemaSorteio.ConfigurarColunasVisiveis(AGrid: TDBGrid;
  AColunasVisiveis: TList<Integer>);
var
  LIndice: Integer;
begin
  if not Assigned(AGrid) then
    Exit;

  for LIndice := 0 to AGrid.Columns.Count - 1 do
  begin
    AGrid.Columns[LIndice].Visible := AColunasVisiveis.Contains(LIndice);
  end;
end;

end.
