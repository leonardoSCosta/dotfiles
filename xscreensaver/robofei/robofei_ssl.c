#include <stdlib.h>
#include <X11/Xlib.h> // apt install libx11-dev
#include <X11/xpm.h> // apt install libxpm-dev
#include <stdio.h>
#include <math.h>

#include "robofei.xpm"
#include "vroot.h"

#define NCOLORS 8
#define ORANGE  0
#define GREEN   1
#define BLUE    2
#define BLACK   3
#define PINK    4
#define YELLOW  5
#define WHITE   6
#define LIGHT_GREEN 7

#define OFFSET 100
#define CENTER_CIRCLE 200
#define TEAM_SIZE 11

Display *display;
Window window;
XWindowAttributes windowAtt;
Pixmap doubleBuffer;
GC graphics, gc;
XColor colors[NCOLORS];
const char *colorNames[NCOLORS]={"orange", "webgreen", "blue", "black", "fuchsia", "yellow", "white", "green"};

typedef struct
{
    int color0;
    int color1;
    int color2;
    int color3;
}ID;

#define ID_0  {.color0 = PINK,        .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_1  {.color0 = LIGHT_GREEN, .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_2  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_3  {.color0 = PINK,        .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = PINK}
#define ID_4  {.color0 = PINK,        .color1 = PINK,        .color2 = PINK,        .color3 = LIGHT_GREEN}
#define ID_5  {.color0 = LIGHT_GREEN, .color1 = PINK,        .color2 = PINK,        .color3 = LIGHT_GREEN}
#define ID_6  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = PINK,        .color3 = LIGHT_GREEN}
#define ID_7  {.color0 = PINK,        .color1 = LIGHT_GREEN, .color2 = PINK,        .color3 = LIGHT_GREEN}
#define ID_8  {.color0 = LIGHT_GREEN, .color1 = LIGHT_GREEN, .color2 = LIGHT_GREEN, .color3 = LIGHT_GREEN}
#define ID_9  {.color0 = PINK,        .color1 = PINK,        .color2 = PINK,        .color3 = PINK}
#define ID_10 {.color0 = PINK,        .color1 = PINK,        .color2 = LIGHT_GREEN, .color3 = LIGHT_GREEN}

ID robotIDs[TEAM_SIZE] = { ID_0, ID_1, ID_2, ID_3, ID_4, ID_5, ID_6, ID_7,
                           ID_8, ID_9, ID_10 };

void setColor(int colorIndex)
{
    if(colorIndex >= 0 && colorIndex < NCOLORS)
    {
        XSetForeground(display, graphics, colors[colorIndex].pixel);
    }
}

typedef struct
{
    int x;
    int y;
    int dx;
    int dy;
    int size;

}BALL;
BALL ball = {.x = OFFSET, .y = OFFSET, .dx = 5, .dy = 5, .size = 21};

typedef struct
{
    int x;
    int y;
    int dx;
    int dy;
    int size;
    int color;
    int id;
}ROBOT;
#define BLUE_ROBOT {.x = OFFSET, .y = OFFSET, .dx = 3,\
                    .dy = 3, .size = 60, .color = BLUE, .id = 0}

#define YELLOW_ROBOT {.x = OFFSET, .y = OFFSET, .dx = 3,\
                      .dy = 3, .size = 60, .color = YELLOW, .id = 0}

ROBOT teamBlue[TEAM_SIZE] = {
                             BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
                             BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
                             BLUE_ROBOT, BLUE_ROBOT, BLUE_ROBOT,
                             BLUE_ROBOT, BLUE_ROBOT
                            },
      teamYellow[TEAM_SIZE] = {
                               YELLOW_ROBOT,YELLOW_ROBOT,YELLOW_ROBOT,
                               YELLOW_ROBOT, YELLOW_ROBOT, YELLOW_ROBOT,
                               YELLOW_ROBOT,YELLOW_ROBOT,YELLOW_ROBOT,
                               YELLOW_ROBOT, YELLOW_ROBOT
                               };

void drawField()
{
    setColor(GREEN);
    XFillRectangle(display, doubleBuffer, graphics,
            0, 0, windowAtt.width, windowAtt.height);

    setColor(WHITE);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, OFFSET,
            windowAtt.width-OFFSET, OFFSET);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height-OFFSET,
            windowAtt.width-OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, OFFSET, OFFSET,
            OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, windowAtt.width-OFFSET, OFFSET,
            windowAtt.width-OFFSET, windowAtt.height-OFFSET);
    XDrawLine(display, doubleBuffer, graphics, windowAtt.width/2-OFFSET, OFFSET,
            windowAtt.width/2-OFFSET, windowAtt.height-OFFSET);

    XDrawArc(display, doubleBuffer, graphics, windowAtt.width/2-OFFSET-CENTER_CIRCLE/2,
            windowAtt.height/2-OFFSET, CENTER_CIRCLE, CENTER_CIRCLE, 0, 360*64);

    const int areaHeight = 300, areaWidth = 150;
    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height/2 - areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, OFFSET, windowAtt.height/2 + areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 + areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, OFFSET+areaWidth, windowAtt.height/2 + areaHeight/2,
            OFFSET+areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET, windowAtt.height/2 - areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 - areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET, windowAtt.height/2 + areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 + areaHeight/2);

    XDrawLine(display, doubleBuffer, graphics, windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 + areaHeight/2,
            windowAtt.width - OFFSET - areaWidth, windowAtt.height/2 - areaHeight/2);
}

void updateBall(BALL *_ball)
{
    _ball->x += _ball->dx;
    _ball->y += _ball->dy;

    if(_ball->x < OFFSET || _ball->x >= windowAtt.width - OFFSET)
    {
        _ball->dx *= -1;
        return;
    }
    if(_ball->y < OFFSET || _ball->y >= windowAtt.height - OFFSET)
    {
        _ball->dy *= -1;
        return;
    }

    unsigned char collision = 0;
    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        if(sqrt(pow(_ball->x - teamBlue[i].x, 2) +
                pow(_ball->y - teamBlue[i].y, 2)) < _ball->size/2.0 + teamBlue[i].size/2.0)
        {
            collision = 1;
            break;
        }
        if(sqrt(pow(_ball->x - teamYellow[i].x, 2) +
                pow(_ball->y - teamYellow[i].y, 2)) < _ball->size/2.0 + teamYellow[i].size/2.0)
        {
            collision = 1;
            break;
        }
    }

    if(collision)
    {
        _ball->dx /= -_ball->dx;
        _ball->dy /= -_ball->dy;
        _ball->dx *= random() % 10 - 5;
        _ball->dy *= random() % 10 - 5;

        if(_ball->dx == 0 || _ball->dy == 0)
        {
            _ball->dx += 1;
            _ball->dy += 1;
        }
    }
}

void drawBall()
{
    setColor(ORANGE);
    XFillArc(display, doubleBuffer, graphics, ball.x, ball.y, ball.size, ball.size,
            0, 360*64);
    updateBall(&ball);
}

void updateRobot(ROBOT *_robot, int _id)
{
    _robot->x += _robot->dx;
    _robot->y += _robot->dy;

    if(_robot->x <= OFFSET || _robot->x >= windowAtt.width - OFFSET)
    {
        _robot->dx *= -1;
        return;
    }
    if(_robot->y <= OFFSET || _robot->y >= windowAtt.height - OFFSET)
    {
        _robot->dy *= -1;
        return;
    }

    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        if(_robot->color == YELLOW)
        {
            if(sqrt(pow(teamYellow[_id].x - teamBlue[i].x, 2) +
                    pow(teamYellow[_id].y - teamBlue[i].y, 2)) <
                        teamYellow[i].size)
            {
                teamBlue[i].dx = random() % 6 - 3;
                teamBlue[i].dy = random() % 6 - 3;

                if(teamBlue[i].dx == 0)
                {
                    teamBlue[i].dx = 1;
                }
                if(teamBlue[i].dy == 0)
                {
                    teamBlue[i].dy = 1;
                }

                teamYellow[_id].dx = -teamBlue[i].dx;
                teamYellow[_id].dy = -teamBlue[i].dy;
            }
//             if(i < TEAM_SIZE - 1)
//             {
//                 if(sqrt(pow(teamYellow[_id].x - teamYellow[i].x, 2) +
//                             pow(teamYellow[_id].y - teamYellow[i].y, 2)) < teamYellow[_id].size/2.0 + teamBlue[i].size/2.0)
//                 {
//                     teamYellow[i].dx *= -1;
//                     teamYellow[i].dy *= -1;
//                     teamYellow[_id].dx *= -1;
//                     teamYellow[_id].dy *= -1;
//                 }
//             }
        }
        else
        {
            if(sqrt(pow(teamYellow[i].x - teamBlue[_id].x, 2) +
                    pow(teamYellow[i].y - teamBlue[_id].y, 2)) <
                        teamYellow[i].size)
            {
                teamYellow[i].dx = random() % 6 - 3;
                teamYellow[i].dy = random() % 6 - 3;

                if(teamYellow[i].dx == 0)
                {
                    teamYellow[i].dx = 1;
                }
                if(teamYellow[i].dy == 0)
                {
                    teamYellow[i].dy = 1;
                }

                teamBlue[_id].dx = -teamYellow[i].dx;
                teamBlue[_id].dy = -teamYellow[i].dy;
            }

//             if(i < TEAM_SIZE - 1)
//             {
//                 if(sqrt(pow(teamBlue[_id].x - teamBlue[i].x, 2) +
//                             pow(teamBlue[_id].y - teamBlue[i].y, 2)) < teamBlue[_id].size/2.0 + teamBlue[i].size/2.0)
//                 {
//                     teamBlue[i].dx *= -1;
//                     teamBlue[i].dy *= -1;
//                     teamBlue[_id].dx *= -1;
//                     teamBlue[_id].dy *= -1;
//                 }
//             }
        }
    }
}


void initRobots()
{
    for(int i = 0; i < TEAM_SIZE; ++i)
    {
        teamBlue[i].x = random() % (windowAtt.width - 2*OFFSET) + OFFSET;
        teamBlue[i].y = random() % (windowAtt.height - 2*OFFSET) + OFFSET;
        teamBlue[i].id = i;
        teamYellow[i].x = random() % (windowAtt.width - 2*OFFSET) + OFFSET;
        teamYellow[i].y = random() % (windowAtt.height - 2*OFFSET) + OFFSET;
        teamYellow[i].id = i;
    }
}

void drawRobot(ROBOT *_robot)
{
    const int blobSize = 15;
    int size = _robot->size;
    setColor(BLACK);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - size/2, _robot->y - size/2, size, size,
            0, 360*64);
    setColor(_robot->color);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2, _robot->y - blobSize/2,
            blobSize, blobSize,
            0, 360*64);

    setColor(robotIDs[_robot->id].color0);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2 - blobSize, _robot->y - blobSize/2 - blobSize,
            blobSize, blobSize,
            0, 360*64);
    setColor(robotIDs[_robot->id].color1);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2 + blobSize, _robot->y - blobSize/2 - blobSize,
            blobSize, blobSize,
            0, 360*64);

    setColor(robotIDs[_robot->id].color2);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2.0 - blobSize*0.7, _robot->y - blobSize/2 + blobSize,
            blobSize, blobSize,
            0, 360*64);
    setColor(robotIDs[_robot->id].color3);
    XFillArc(display, doubleBuffer, graphics,
            _robot->x - blobSize/2.0 + blobSize*0.7, _robot->y - blobSize/2 + blobSize,
            blobSize, blobSize,
            0, 360*64);
}

void drawRobots()
{
    for(int i = 0; i < TEAM_SIZE; ++i)
    {

        drawRobot(&teamBlue[i]);
        updateRobot(&teamBlue[i], i);

        drawRobot(&teamYellow[i]);
        updateRobot(&teamYellow[i], i);
    }
}

int main ()
{
    // open the display (connect to the X server)
    display = XOpenDisplay(getenv("DISPLAY"));
    // get the root window
    window = DefaultRootWindow(display);
    // create a GC for drawing in the window
    graphics = XCreateGC(display, window, 0, NULL);
    XSetLineAttributes(display, graphics, 10, LineSolid, CapProjecting,
                       JoinRound);

    // set foreground color
    XSetForeground(display, graphics, WhitePixelOfScreen(DefaultScreenOfDisplay(display)));

    // get attributes of the root window
    XGetWindowAttributes(display, window, &windowAtt);
    doubleBuffer = XCreatePixmap(display, window, windowAtt.width,
                                 windowAtt.height, windowAtt.depth);

    // read the image
    XImage *robofeiImg, *clipMask;
    Pixmap pix;
    if(XpmCreateImageFromData(display, robofei, &robofeiImg, &clipMask, NULL))
    {
        printf("Error reading image\n");
        exit(1);
    }
    // copy the transparent image into the pixmap
    pix = XCreatePixmap(display, doubleBuffer, clipMask->width, clipMask->height, clipMask->depth);
    gc = XCreateGC (display, pix, 0, NULL);
    XPutImage(display, pix, gc, clipMask, 0, 0, 0, 0, clipMask->width, clipMask->height);

    // allocate colors
    for(int c = 0; c < NCOLORS; c++)
    {
        XColor xc, sc;
        XAllocNamedColor(display,
                DefaultColormapOfScreen(DefaultScreenOfDisplay(display)),
                colorNames[c], &sc, &xc);
        colors[c] = sc;
    }

    initRobots();

    // draw something
    while(1)
    {
        drawField();
        drawBall();
        drawRobots();

        XSetClipMask(display, graphics, pix);
        XSetClipOrigin(display, graphics, 0, 0);
        XPutImage(display, doubleBuffer, graphics, robofeiImg, 0, 0,
                0, 0, robofeiImg->width, robofeiImg->height);
        XSetClipMask(display, graphics, None);


        // flush changes and sleep
        XCopyArea(display, doubleBuffer, window, graphics, 0, 0,
                  windowAtt.width, windowAtt.height, 0, 0);
        XFlush(display);
        // 60 FPS
        usleep(1000000/60);
    }

    XCloseDisplay(display);
}
