$ zzestado
AC    Acre                   Rio Branco
AL    Alagoas                Maceió
AP    Amapá                  Macapá
AM    Amazonas               Manaus
BA    Bahia                  Salvador
CE    Ceará                  Fortaleza
DF    Distrito Federal       Brasília
ES    Espírito Santo         Vitória
GO    Goiás                  Goiânia
MA    Maranhão               São Luís
MT    Mato Grosso            Cuiabá
MS    Mato Grosso do Sul     Campo Grande
MG    Minas Gerais           Belo Horizonte
PA    Pará                   Belém
PB    Paraíba                João Pessoa
PR    Paraná                 Curitiba
PE    Pernambuco             Recife
PI    Piauí                  Teresina
RJ    Rio de Janeiro         Rio de Janeiro
RN    Rio Grande do Norte    Natal
RS    Rio Grande do Sul      Porto Alegre
RO    Rondônia               Porto Velho
RR    Roraima                Boa Vista
SC    Santa Catarina         Florianópolis
SP    São Paulo              São Paulo
SE    Sergipe                Aracaju
TO    Tocantins              Palmas
$ zzestado --formato '{sigla}-{nome}\n'
AC-Acre
AL-Alagoas
AP-Amapá
AM-Amazonas
BA-Bahia
CE-Ceará
DF-Distrito Federal
ES-Espírito Santo
GO-Goiás
MA-Maranhão
MT-Mato Grosso
MS-Mato Grosso do Sul
MG-Minas Gerais
PA-Pará
PB-Paraíba
PR-Paraná
PE-Pernambuco
PI-Piauí
RJ-Rio de Janeiro
RN-Rio Grande do Norte
RS-Rio Grande do Sul
RO-Rondônia
RR-Roraima
SC-Santa Catarina
SP-São Paulo
SE-Sergipe
TO-Tocantins
$ zzestado --html
<select>
  <option value="AC">AC - Acre</option>
  <option value="AL">AL - Alagoas</option>
  <option value="AP">AP - Amapá</option>
  <option value="AM">AM - Amazonas</option>
  <option value="BA">BA - Bahia</option>
  <option value="CE">CE - Ceará</option>
  <option value="DF">DF - Distrito Federal</option>
  <option value="ES">ES - Espírito Santo</option>
  <option value="GO">GO - Goiás</option>
  <option value="MA">MA - Maranhão</option>
  <option value="MT">MT - Mato Grosso</option>
  <option value="MS">MS - Mato Grosso do Sul</option>
  <option value="MG">MG - Minas Gerais</option>
  <option value="PA">PA - Pará</option>
  <option value="PB">PB - Paraíba</option>
  <option value="PR">PR - Paraná</option>
  <option value="PE">PE - Pernambuco</option>
  <option value="PI">PI - Piauí</option>
  <option value="RJ">RJ - Rio de Janeiro</option>
  <option value="RN">RN - Rio Grande do Norte</option>
  <option value="RS">RS - Rio Grande do Sul</option>
  <option value="RO">RO - Rondônia</option>
  <option value="RR">RR - Roraima</option>
  <option value="SC">SC - Santa Catarina</option>
  <option value="SP">SP - São Paulo</option>
  <option value="SE">SE - Sergipe</option>
  <option value="TO">TO - Tocantins</option>
</select>
$ zzestado --js
var siglas = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'];

var nomes = ['Acre', 'Alagoas', 'Amapá', 'Amazonas', 'Bahia', 'Ceará', 'Distrito Federal', 'Espírito Santo', 'Goiás', 'Maranhão', 'Mato Grosso', 'Mato Grosso do Sul', 'Minas Gerais', 'Pará', 'Paraíba', 'Paraná', 'Pernambuco', 'Piauí', 'Rio de Janeiro', 'Rio Grande do Norte', 'Rio Grande do Sul', 'Rondônia', 'Roraima', 'Santa Catarina', 'São Paulo', 'Sergipe', 'Tocantins'];

var capitais = ['Rio Branco', 'Maceió', 'Macapá', 'Manaus', 'Salvador', 'Fortaleza', 'Brasília', 'Vitória', 'Goiânia', 'São Luís', 'Cuiabá', 'Campo Grande', 'Belo Horizonte', 'Belém', 'João Pessoa', 'Curitiba', 'Recife', 'Teresina', 'Rio de Janeiro', 'Natal', 'Porto Alegre', 'Porto Velho', 'Boa Vista', 'Florianópolis', 'São Paulo', 'Aracaju', 'Palmas'];

var estados = {
  AC: 'Acre',
  AL: 'Alagoas',
  AP: 'Amapá',
  AM: 'Amazonas',
  BA: 'Bahia',
  CE: 'Ceará',
  DF: 'Distrito Federal',
  ES: 'Espírito Santo',
  GO: 'Goiás',
  MA: 'Maranhão',
  MT: 'Mato Grosso',
  MS: 'Mato Grosso do Sul',
  MG: 'Minas Gerais',
  PA: 'Pará',
  PB: 'Paraíba',
  PR: 'Paraná',
  PE: 'Pernambuco',
  PI: 'Piauí',
  RJ: 'Rio de Janeiro',
  RN: 'Rio Grande do Norte',
  RS: 'Rio Grande do Sul',
  RO: 'Rondônia',
  RR: 'Roraima',
  SC: 'Santa Catarina',
  SP: 'São Paulo',
  SE: 'Sergipe',
  TO: 'Tocantins'
};

var estados = {
  AC: ['Acre', 'Rio Branco', 'acre'],
  AL: ['Alagoas', 'Maceió', 'alagoas'],
  AP: ['Amapá', 'Macapá', 'amapa'],
  AM: ['Amazonas', 'Manaus', 'amazonas'],
  BA: ['Bahia', 'Salvador', 'bahia'],
  CE: ['Ceará', 'Fortaleza', 'ceara'],
  DF: ['Distrito Federal', 'Brasília', 'distrito-federal'],
  ES: ['Espírito Santo', 'Vitória', 'espirito-santo'],
  GO: ['Goiás', 'Goiânia', 'goias'],
  MA: ['Maranhão', 'São Luís', 'maranhao'],
  MT: ['Mato Grosso', 'Cuiabá', 'mato-grosso'],
  MS: ['Mato Grosso do Sul', 'Campo Grande', 'mato-grosso-do-sul'],
  MG: ['Minas Gerais', 'Belo Horizonte', 'minas-gerais'],
  PA: ['Pará', 'Belém', 'para'],
  PB: ['Paraíba', 'João Pessoa', 'paraiba'],
  PR: ['Paraná', 'Curitiba', 'parana'],
  PE: ['Pernambuco', 'Recife', 'pernambuco'],
  PI: ['Piauí', 'Teresina', 'piaui'],
  RJ: ['Rio de Janeiro', 'Rio de Janeiro', 'rio-de-janeiro'],
  RN: ['Rio Grande do Norte', 'Natal', 'rio-grande-do-norte'],
  RS: ['Rio Grande do Sul', 'Porto Alegre', 'rio-grande-do-sul'],
  RO: ['Rondônia', 'Porto Velho', 'rondonia'],
  RR: ['Roraima', 'Boa Vista', 'roraima'],
  SC: ['Santa Catarina', 'Florianópolis', 'santa-catarina'],
  SP: ['São Paulo', 'São Paulo', 'sao-paulo'],
  SE: ['Sergipe', 'Aracaju', 'sergipe'],
  TO: ['Tocantins', 'Palmas', 'tocantins']
}
$ zzestado --sigla
AC
AL
AP
AM
BA
CE
DF
ES
GO
MA
MT
MS
MG
PA
PB
PR
PE
PI
RJ
RN
RS
RO
RR
SC
SP
SE
TO
$
