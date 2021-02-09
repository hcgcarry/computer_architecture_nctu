#include<iostream>
#include<string>
#include<vector>
#include<fstream>
#include<algorithm>
#include<bitset>

#define BLOCKSIZE 64
#define CACHESIZE (1*1024)
#define memoryBitNum 32
#define set_num_way 2

int countBitNum(int num);
using namespace std;

typedef struct cacheLine{
    int validateBit = 0;
    int tag ;
    int lastAccessTime;
}CacheLine;
class cache{
    public:
    int numOfSet  = CACHESIZE/(BLOCKSIZE*set_num_way);
    int blockOffsetBitNum = countBitNum(BLOCKSIZE);
    int SetIndexBitNum = countBitNum(numOfSet);
    int tagBitNum = memoryBitNum - blockOffsetBitNum- SetIndexBitNum;
    int curTime = 0;
    int miss = 0;
    vector<vector<CacheLine>> cacheTable = vector<vector<CacheLine>> (numOfSet,vector<CacheLine>(set_num_way));
    //vector<vector<CacheLine>> cacheTable;
    cache(){
    }
    void insert(unsigned int MemAddress){
        curTime ++ ;
        cout << "----------------------------new " ;
        printf("%04x",MemAddress);
        cout << endl;
        cout << "curTime " << curTime << endl;
        unsigned int setIndex,tag;
        tag = MemAddress >> (memoryBitNum - tagBitNum);
        setIndex = (MemAddress << tagBitNum) >> (memoryBitNum - SetIndexBitNum);
        std::bitset<32> tmp_MemAddress(MemAddress);
        std::bitset<32> tmp_setIndex(setIndex);
        std::bitset<32> tmp_tag(tag);
        cout << "insert address:" << tmp_MemAddress<< endl;
        cout << "setIndex " << tmp_setIndex << endl;
        cout << "tag " << tmp_tag << endl;
        //find if exist
        bool exist = false;
        for(auto &item:cacheTable[setIndex]){
            if(item.validateBit ==1 && item.tag ==tag){
                item.lastAccessTime = curTime;
                exist = true;
                break;
            }
        }
        if(!exist){
            cout << "memaddress " << MemAddress << "isn't exist" << endl;
            miss ++ ;
            bool isFull = true;
            for(auto &item:cacheTable[setIndex]){
                if(item.validateBit == 0){
                    item.validateBit = 1;
                    item.lastAccessTime = curTime;
                    item.tag = tag;
                    isFull = false;
                    break;
                }
            }
            if(isFull){
                cout << "setindex " << setIndex<< "is full " << endl;
                LRU(setIndex,tag);
            }
            else{
                cout << "setindex isn't full "<< endl;
            }
        }
        else{
            cout << "mem address exist" << endl;
        }
    }
    void LRU(int setIndex,int tag){
        sort(cacheTable[setIndex].begin(),cacheTable[setIndex].end(),
        [](CacheLine tmp1,CacheLine tmp2){
            return tmp1.lastAccessTime < tmp2.lastAccessTime;
        });
        cacheTable[setIndex][0].tag = tag;
        cacheTable[setIndex][0].lastAccessTime = curTime;
        cacheTable[setIndex][0].validateBit= 1;
    }
    void printResult(){
        cout << set_num_way << " way"<< endl;
        cout << "cache size " << CACHESIZE << endl;
        cout << "block size " << BLOCKSIZE << endl;
        cout << "hit rate " << (float)(curTime - miss )/curTime<< endl;
        
    }
    void printInfo(){
        cout << "num of set " <<  numOfSet << endl;
        cout <<"block offset bit num " << blockOffsetBitNum << endl;
        cout << "set index bit num " << SetIndexBitNum << endl;
        cout << "tagBitNum " << tagBitNum << endl;
    }
    void printCacheContent(){
        for(int i=0;i<numOfSet;i++){
            for(int j=0;j<cacheTable[i].size();j++){
                auto item = cacheTable[i][j];
                if(item.validateBit == 1){
                    cout << "--set index " << i << " j " << j<< endl;
                    cout <<"tag " << item.tag <<" validateBit " <<item.validateBit << " last access time " << item.lastAccessTime<< endl;
                }
            }
        }
    }
};

int main(void){
    fstream Cachefile;
    cache cacheObj;
    string line;
    cacheObj.printInfo();
    Cachefile.open("LRU.txt",ios::in);
    cout << "size of long " << sizeof(long);
    while(getline(Cachefile,line)){
        unsigned long MemAddress = stoul(line,NULL,16);
        cacheObj.insert(MemAddress);
        //cacheObj.printCacheContent();
    }
    cacheObj.printResult();
    
}

int countBitNum(int num){
    int result =0; 
    while(num >1){
        result++;
        num >>= 1;
    }
    return result;
}