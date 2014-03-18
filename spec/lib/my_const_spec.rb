class TestClass
  my_const_set('OPTIONS', [ 'A', 'B' ])
end

describe TestClass do
  it "const OPTIONS setted" do
    expect(TestClass::OPTIONS).to eq( [ 'a', 'b' ] )
  end

  it "const A, B setted" do
    expect(TestClass::A).to eq( 'a' )
    expect(TestClass::B).to eq( 'b' )
  end
end
