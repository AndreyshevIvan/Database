#pragma warning(disable : 4996)
#include "stdafx.h"
#include <fstream>
#include <iostream>
#include <map>
#include <vector>
#include <sstream>

const int ARGUMENTS_COUNT = 2;
const char OTHERS_NAMES_KEY = '#';
const std::string OTHERS_NAMES_FILE_NAME = "others.txt";

void InitMemoryForWrite(std::map<char, std::fstream*>& memory);
void InitMemoryForRead(std::map<char, std::fstream*>& memory);
std::pair<char, std::fstream*> GetMemoryPair(char letter);

void ReadDatabase(std::istream& input, std::map<char, std::fstream*>& memory);
void AddRecotdToMemory(std::map<char, std::fstream*>& memory, std::pair<int, std::string> const& record);
std::pair<int, std::string> ParseNameAndId(std::string const& record);

void EnterSearching(std::map<char, std::fstream*>& memory);
void SearchUser(std::fstream* keyFile, std::string const& username);
void ReturnTheSearchResults(std::vector<int> identificators);

int main(int argc, char* argv[])
{
	if (argc != ARGUMENTS_COUNT)
	{
		std::cout << "Invalid arguments count:\n"
			<< "Usage: FindUsername.exe <file.csv>\n";
		return 1;
	}

	std::ifstream input(argv[1]);

	if (!input.is_open())
	{
		std::cout << "Failed to open " << argv[1] << " for reading\n";
		return 1;
	}

	std::map<char, std::fstream*> memoryMap;
	InitMemoryForWrite(memoryMap);
	ReadDatabase(input, memoryMap);
	InitMemoryForRead(memoryMap);

	EnterSearching(memoryMap);

	return 0;
}

void InitMemoryForWrite(std::map<char, std::fstream*>& memory)
{
	for (char letter = 'a'; letter <= 'z'; letter++)
	{
		memory.insert(GetMemoryPair(letter));
	}

	std::fstream* othersNamesFile = new std::fstream();
	othersNamesFile->open(OTHERS_NAMES_FILE_NAME, std::ios::out);
	memory.insert(std::pair<char, std::fstream*>(OTHERS_NAMES_KEY, othersNamesFile));
}

void InitMemoryForRead(std::map<char, std::fstream*>& memory)
{
	for (char letter = 'a'; letter <= 'z'; letter++)
	{
		memory.find(letter)->second->close();
		memory.find(letter)->second->open(std::string(&letter, 0, 1) + ".txt", std::ios::in);
	}

	memory.find(OTHERS_NAMES_KEY)->second->close();
	memory.find(OTHERS_NAMES_KEY)->second->open(OTHERS_NAMES_FILE_NAME, std::ios::in);
}

std::pair<char, std::fstream*> GetMemoryPair(char letter)
{
	std::fstream* file = new std::fstream();
	file->open(std::string(&letter, 0, 1) + ".txt", std::ios::out);
	return std::pair<char, std::fstream*>(letter, file);
}

void ReadDatabase(std::istream& input, std::map<char, std::fstream*>& memory)
{
	std::cout << "Preparing your database. " << std::endl << "Please, wait..." << std::endl;
	std::string csvRecord;
	int recordsCount = 0;

	getline(input, csvRecord); // To skip the description line
	while (getline(input, csvRecord))
	{
		auto record = ParseNameAndId(csvRecord);
		AddRecotdToMemory(memory, record);
		recordsCount++;
	}

	std::cout << recordsCount << " records complete..." << std::endl;
}

void AddRecotdToMemory(std::map<char, std::fstream*>& memory, std::pair<int, std::string> const& record)
{
	std::string username = record.second;
	int id = record.first;
	char firstSymbol = (char)tolower(record.second[0]);
	std::fstream* file;
	if (firstSymbol < 'a' || firstSymbol > 'z')
	{
		file = memory.find(OTHERS_NAMES_KEY)->second;
	}
	else
	{
		file = memory.find(firstSymbol)->second;
	}

	*file << username << "," << id << std::endl;
}

std::pair<int, std::string> ParseNameAndId(std::string const& record)
{
	std::stringstream stream(record);
	std::string username = "";
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
		username += std::string(&symbol, 0, 1);
		stream >> symbol;
	}

	if (username[0] == '"' && username[username.size() - 1] == '"')
	{
		std::string newUsername = "";
		for (size_t i = 1; i != username.size() - 1; i++)
		{
			newUsername = newUsername + username[i];
		}
		username = newUsername;
	}

	return std::pair<int, std::string>(id, username);
}

void EnterSearching(std::map<char, std::fstream*>& memory)
{
	std::string username;
	std::fstream* keyFile;
	char key;

	while (!std::cin.eof() && !std::cin.fail())
	{
		std::cout << "Enter username: ";
		std::getline(std::cin, username);
		if (!username.empty())
		{
			key = username[0];
			if (key < 'a' || key > 'z')
			{
				keyFile = memory.find(OTHERS_NAMES_KEY)->second;
			}
			else
			{
				keyFile = memory.find(key)->second;
			}
			SearchUser(keyFile, username);
			InitMemoryForRead(memory);
		}
		else
		{
			std::cout << "The user name cannot be empty...Try again!" << std::endl;
		}
	}
}

void SearchUser(std::fstream* keyFile, std::string const& username)
{
	std::string tmpStr;
	int id = 0;
	std::vector<int> identificators;

	while (getline(*keyFile, tmpStr))
	{
		std::stringstream stream(tmpStr);
		std::string readingName = "";
		char symbol;

		stream >> symbol;
		while (symbol != ',')
		{
			readingName += std::string(&symbol, 0, 1);
			stream >> symbol;
		}

		if (strcmp(username.c_str(), readingName.c_str()) == 0)
		{
			stream >> id;
			identificators.push_back(id);
		}
	}

	ReturnTheSearchResults(identificators);
}

void ReturnTheSearchResults(std::vector<int> identificators)
{
	int countOfMeetings = identificators.size();

	if (countOfMeetings != 0)
	{
		std::cout << "Record id: ";
		for (auto id : identificators)
		{
			std::cout << id;
			if (id != identificators.back())
			{
				std::cout << ", ";
			}
			else
			{
				std::cout << ".";
			}
		}
	}
	else
	{
		std::cout << "Record not found, try again!";
	}

	std::cout << std::endl;
}