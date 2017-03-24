#include "dataprocessor.h"
#include <QObject>

DataProcessor::DataProcessor(QQuickItem *parent)
    :QQuickItem(parent)
{
}

//-------------------------------------------- OTHER FUNCTIONS
void DataProcessor::updateX()
{
    double xCoord = m_xCoord;
    double xControl = static_cast<double>(m_xControl*2);

    double dt = m_dt;

    // x = vx*dt+x0;
    xCoord = xControl*dt+xCoord;
    setxCoord(xCoord);
}

void DataProcessor::updateY()
{
    double yCoord = m_yCoord;
    double yControl = static_cast<double>(m_yControl*2);
    double dt = m_dt;
    yCoord = yControl*dt+yCoord;
    setyCoord(yCoord);
}

void DataProcessor::updateZ()
{
    double zCoord = m_zCoord;
    double zControl = static_cast<double>(m_zControl*2);
    double dt = m_dt;
    zCoord = zControl*dt+zCoord;
    setzCoord(zCoord);
}

void DataProcessor:: updateCoords()
{
    updateX();
    updateY();
    updateZ();
}

void DataProcessor:: updateOthers(int p, double x, double y, double z)
{

    switch(p)
    {
    case 2:
        m_xCoord = x;
        m_yCoord = y+m_cubeLength;
        m_zCoord = z;
        break;
    case 3:
        m_xCoord = x-m_cubeLength;
        m_yCoord = y;
        m_zCoord = z;
        break;
    case 4:
        m_xCoord = x+m_cubeLength;
        m_yCoord = y;
        m_zCoord = z;
        break;
    case 5:
        m_xCoord = x;
        m_yCoord = y;
        m_zCoord = z+m_cubeLength;
        break;
    case 6:
        m_xCoord = x;
        m_yCoord = y;
        m_zCoord = z+m_cubeLength*2;
        break;
    case 7:
        m_xCoord = x;
        m_yCoord = y;
        m_zCoord = z+m_cubeLength*3;
        break;
    }




    updateX();
    updateY();
    updateZ();
}

//-------------------------------------------- COORDINATES
double DataProcessor::xCoord()
{
    return m_xCoord;
}

double DataProcessor::yCoord()
{
    return m_yCoord;
}

double DataProcessor::zCoord()
{
    return m_zCoord;
}

int DataProcessor::point()
{
    return m_point;
}

double DataProcessor::cubeLength()
{
    return m_cubeLength;
}

void DataProcessor::setxCoord(double &xCoord)
{
    m_xCoord = xCoord;
}


void DataProcessor::setyCoord(double &yCoord)
{
    m_yCoord = yCoord;
}

void DataProcessor::setzCoord(double &zCoord)
{
    m_zCoord = zCoord;
}
//-------------------------------------------- VELOCITIES
double DataProcessor::xVel()
{
    return m_xVel;
}

double DataProcessor::yVel()
{
    return m_yVel;
}

double DataProcessor::zVel()
{
    return m_zVel;
}

void DataProcessor::setxVel(double &xVel)
{
    m_xVel = xVel;
}


void DataProcessor::setyVel(double &yVel)
{
    m_yVel = yVel;
}

void DataProcessor::setzVel(double &zVel)
{
    m_zVel = zVel;
}

//-------------------------------------------- TIMES
double DataProcessor::t0()
{
    return m_t0;
}

double DataProcessor::t1()
{
    return m_t1;
}

double DataProcessor::t2()
{
    return m_t2;
}

double DataProcessor::dt()
{
    return m_dt;
}

void DataProcessor::sett0(double &t0)
{
    m_t0 = t0;
}

void DataProcessor::sett1(double &t1)
{
    m_t1 = t1;
}

void DataProcessor::sett2(double &t2)
{
    m_t2 = t2;
}

void DataProcessor::setdt(double &dt)
{
    m_dt = dt;
}

//-------------------------------------------- CONTROL INPUT VALUES
int DataProcessor::xControl()
{
    return m_xControl;
}

int DataProcessor::yControl()
{
    return m_yControl;
}

int DataProcessor::zControl()
{
    return m_zControl;
}

void DataProcessor::setxControl(int &xControl)
{
    m_xControl = xControl;
}

void DataProcessor::setyControl(int &yControl)
{
    m_yControl = yControl;
}

void DataProcessor::setzControl(int &zControl)
{
    m_zControl = zControl;
}

void DataProcessor::setPoint(int &point)
{
    m_point = point;
}

void DataProcessor::setCubeLength(double &cubeLength)
{
    m_cubeLength = cubeLength;
}
