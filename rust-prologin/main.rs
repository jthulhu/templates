use std::io::stdin;

fn main() {
    let mut buffer = String::new();
}

fn read_line(buffer: &mut String) -> &str {
    buffer.clear();
    stdin()
	.read_line(buffer)
	.expect("impossible to read new line");
    buffer.trim_end()
}

fn read_tuple<T>(buffer: &mut String) -> (T, T)
where
    T: FromStr
    <T as FromStr>::Err: Debug,
{
    let mut line = read_line(buffer).split_whitespace().map(|x| x.parse.unwrap());
    (line.next().unwrap(), line.next().unwrap())
}
