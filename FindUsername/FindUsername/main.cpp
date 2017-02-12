#pragma warning(disable : 4996)
#include "stdafx.h"
#include <fstream>
#include <iostream>
#include <map>
#include <sstream>

using namespace std;

const int ARGUMENTS_COUNT = 2;

void InitMemory(map<char, ofstream*>& memory);
pair<char, ofstream*> GetMemoryPair(char letter);
void ReadDatabase(std::istream& input, map<char, ofstream*>& memory);
void AddRecotdToMemory(map<char, ofstream*>& memory, pair<int, string> const& record);
pair<int, string> ParseCSVRecord(string const& record);

int main(int argc, char* argv[])
{
	if (argc != ARGUMENTS_COUNT)
	{
		cout << "Invalid arguments count:\n"
			<< "Usage: FindUsername.exe <file.csv>\n";
		return 1;
	}

	ifstream input(argv[1]);

	if (!input.is_open())
	{
		std::cout << "Failed to open " << argv[1] << " for reading\n";
		return 1;
	}

	map<char, ofstream*> memoryMap;
	InitMemory(memoryMap);
	//ReadDatabase(input, memoryMap);

	string str = "";
	getline(cin, str);
	auto record = ParseCSVRecord(str);
	cout << record.first;
	cout << record.second;

	return 0;
}

void InitMemory(map<char, ofstream*>& memory)
{
	for (char letter = 'a'; letter <= 'z'; letter++)
	{
		memory.insert(GetMemoryPair(letter));
	}
}

pair<char, ofstream*> GetMemoryPair(char letter)
{
	ofstream file(string(&letter, 0, 1));
	return pair<char, ofstream*>(letter, &file);
}

void ReadDatabase(std::istream& input, map<char, ofstream*>& memory)
{
	string csvRecord;

	getline(input, csvRecord); // To skip the description line
	while (getline(input, csvRecord))
	{
		auto record = ParseCSVRecord(csvRecord);
		AddRecotdToMemory(memory, record);
	}
}

void AddRecotdToMemory(map<char, ofstream*>& memory, pair<int, string> const& record)
{

}

pair<int, string> ParseCSVRecord(string const& record)
{
	stringstream stream(record);
	string username = "";
	int id = 0;
	int symbolsCount = 0;
	char symbol;

	stream >> id;

	while (symbolsCount != 4)
	{
		stream >> symbol;
		if (symbol == ',')
		{
			symbolsCount++;
		}
	}

	stream >> symbol;
	while (symbol != ',')
	{
		username += string(&symbol, 0, 1);
		stream >> symbol;
	}

	if (username[0] == '"' && username[username.size() - 1] == '"')
	{
		string newUsername = "";
		for (size_t i = 1; i != username.size() - 1; i++)
		{
			newUsername = newUsername + username[i];
		}
		username = newUsername;
	}

	return pair<int, string>(id, username);
}